#!/usr/bin/env python3
# -*- coding: utf-8 -*-
###
### Core > Service Checks
###
import time

from lib.core.Constants import *
from lib.utils.OrderedDefaultDict import OrderedDefaultDict
from lib.output.Logger import logger
from lib.output.Output import Output
from lib.output.StatusBar import *
from lib.requester.Filter import Filter
from lib.requester.Condition import Condition
from lib.requester.ResultsRequester import ResultsRequester

class ServiceChecks:
    """All Security Checks for a Service"""

    def __init__(self, service, categories):
        """
        Construct ServiceChecks object.

        :param str service: Service name
        :param list categories: Categories used to classify the various checks
        """
        self.service = service
        self.categories = categories
        # Organize checks in dict {category: [checks]}
        self.checks = OrderedDefaultDict(list, {k:[] for k in categories})


    #------------------------------------------------------------------------------------
    # Basic Operations

    def add_check(self, check):
        """
        Add a Check.

        :param Check check: The check to add
        :return: Status
        :rtype: bool
        """
        self.checks[check.category].append(check)
        return True


    def get_check(self, checkname):
        """
        Get a check by name (NOT case-sensitive).

        :param checkname: Name of the check to get
        :return: Check if found, None otherwise
        :rtype: Check|None
        """
        for cat in self.checks:
            for c in self.checks[cat]:
                if c.name.lower() == checkname.lower():
                    return c
        return None


    def get_all_check_names(self):
        """
        Get list of names of all checks.

        :return: Names of all checks
        :rtype: list
        """
        return [item.name for sublist in self.checks.values() for item in sublist]


    def is_existing_check(self, checkname):
        """
        Indicates if a given check name is existing for the current service 
        (NOT case-sensitive)

        :param checkname: Name of the check to look for
        :return: Result of the search
        :rtype: bool
        """
        return checkname.lower() in map(lambda x: x.lower(), self.get_all_check_names())


    def nb_checks(self):
        """
        Get the total number of checks

        :return: Number of checks
        :rtype: int
        """
        nb = 0
        for category in self.categories:
            nb += len(self.checks[category])
        return nb


    #------------------------------------------------------------------------------------
    # Run 

    def run(self, 
            target, 
            arguments,
            sqlsession,
            filter_categories=None, 
            filter_checks=None, 
            attack_profile=None,
            attack_progress=None):
        """
        Run checks for the service.
        By default, all the checks are run (but commands are actually run only if 
        target complies with context requirements). It is however possible to apply 
        filters to select the checks to run:
            - Filter on categories,
            - Filter on names of checks.

        :param Target target: Target
        :param ArgumentsParser arguments: Arguments from command-line
        :param Session sqlsession: SQLAlchemy session
        :param list filter_categories: Selection of categories to run (default: all)
        :param list filter_checks: Selection of checks to run (default: all)
        :param AttackProfile attack_profile: Attack profile (default: no profile)
        :param enlighten.Counter attack_progress: Attack progress
        """

        # # Important: We must keep the order of categories
        # categories = sorted(filter_categories, key=self.categories.index)
        if filter_categories is None:
            filter_categories = self.categories

        # Standard mode 
        # Selected/all categories of checks are run
        if filter_checks is None and attack_profile is None:
            self.__run_standard_mode(target,
                                     arguments,
                                     sqlsession,
                                     filter_categories,
                                     attack_progress)

        # Special mode
        # User has provided either an attack profile or a list of checks to run 
        # (may be one single check)
        else:

             self.__run_special_mode(target, 
                                     arguments,
                                     sqlsession,
                                     filter_checks,
                                     attack_profile,
                                     attack_progress)

        return


    def __run_standard_mode(self,
                            target, 
                            arguments,
                            sqlsession,
                            filter_categories, 
                            attack_progress=None):
        """
        Run checks for the service in standard mode, i.e. when all or a subset of
        categories of checks must be run against the target.

        :param Target target: Target
        :param ArgumentsParser arguments: Arguments from command-line
        :param Session sqlsession: SQLAlchemy session
        :param list categories: Sorted list of categories to run
        :param enlighten.Counter attack_progress: Attack progress
        """

        # logger.info('Categories of checks that will be run: {cats}'.format(
        #     cats=', '.join(categories)))

        nb_checks = self.nb_checks()

        # Initialize sub status/progress bar
        checks_progress = manager.counter(total=nb_checks+1, 
                                          desc='', 
                                          unit='check',
                                          leave=False,
                                          bar_format=STATUSBAR_FORMAT)
        time.sleep(.5) # hack for progress bar display

        j = 1
        for category in self.categories:
            # Apply filter on categories
            if category not in filter_categories:
                continue

            Output.title1('Category > {cat}'.format(cat=category.capitalize()))

            i = 1
            for check in self.checks[category]:

                # Update status/progress bar
                status = ' +--> Current check [{cur}/{total}]: {category} > ' \
                    '{checkname}'.format(
                        cur       = j,
                        total     = nb_checks,
                        category  = check.category,
                        checkname = check.name)

                checks_progress.desc = '{status}{fill}'.format(
                    status = status,
                    fill   = ' '*(DESC_LENGTH-len(status)))
                checks_progress.update()
                if attack_progress:
                    # Hack to refresh the attack progress bar without incrementing
                    # useful if the tool run during the check has cleared the screen
                    attack_progress.refresh()


                # Run the check if and only if:
                #   - The check has not been already run for this target (except 
                #       if --recheck is specified in command-line)
                #   - Target is compliant with the check,
                #   - The tool used for the check is well installed.
                if i > 1: print()
                
                results_req = ResultsRequester(sqlsession)
                results_req.select_mission(target.service.host.mission.name)
                filter_ = Filter(FilterOperator.AND)
                filter_.add_condition(Condition(target.service.id, 
                    FilterData.SERVICE_ID))
                filter_.add_condition(Condition(check.name, FilterData.CHECK_NAME))
                results_req.add_filter(filter_)
                result = results_req.get_first_result()

                if result is None or arguments.args.recheck == True:

                    if check.check_target_compliance(target):
                        Output.title2('[{category}][Check {num:02}/{total:02}] ' \
                            '{name} > {description}'.format(
                                category    = category.capitalize(),
                                num         = j,
                                total       = nb_checks,
                                name        = check.name,
                                description = check.description))

                        if not check.tool.installed:
                            logger.warning('Skipped: the tool "{tool}" used by ' \
                                'this check is not installed yet'.format(
                                    tool=check.tool.name))
                        else:
                            try:
                                check.run(target, 
                                          arguments,
                                          sqlsession)

                            except KeyboardInterrupt:
                                print()
                                logger.warning('Check {check} skipped !'.format(
                                    check=check.name))

                    else:
                        logger.info('[{category}][Check {num:02}/{total:02}] ' \
                            '{name} > Skipped because context requirements are ' \
                            'not matching the target'.format(
                                name     = check.name,
                                category = category.capitalize(),
                                num      = j,
                                total    = nb_checks))
                        time.sleep(.2)
                else:

                    logger.info('[{category}][Check {num:02}/{total:02}] ' \
                            '{name} > Skipped because the check has already ' \
                            'been run'.format(
                                name     = check.name,
                                category = category.capitalize(),
                                num      = j,
                                total    = nb_checks))
                    time.sleep(.2)

                i += 1
                j += 1

        checks_progress.update()
        time.sleep(.5)

        checks_progress.close()
        return


    def __run_special_mode(self,
                           target, 
                           arguments,
                           sqlsession,
                           filter_checks=None, 
                           attack_profile=None,
                           attack_progress=None):
        """
        Run checks for the service in special mode, i.e. when user has provided
        either an attack profile (pre-selection of checks) or a list of checks
        (may even be one single check to run)

        :param Target target: Target
        :param ArgumentsParser arguments: Arguments from command-line
        :param Session sqlsession: SQLAlchemy session
        :param list filter_checks: Selection of checks to run (default: all)
        :param AttackProfile attack_profile: Attack profile (default: no profile)
        :param enlighten.Counter attack_progress: Attack progress        
        """

        # User has submitted list of checks
        if filter_checks:
            filter_checks = list(filter(
                lambda x: self.is_existing_check(x), filter_checks))

            if not filter_checks:
                logger.warning('None of the selected checks is existing for the ' \
                    'service {service}'.format(service=target.get_service_name()))
                return

            logger.info('Selected check(s) that will be run:')
            for c in filter_checks:
                check = self.get_check(c)
                if check:
                    Output.print('    | - {name} ({category})'.format(
                        name=c, category=check.category))

        # User has submitted an attack profile
        else:
            if not attack_profile.is_service_supported(target.get_service_name()):
                logger.warning('The attack profile {profile} is not supported for ' \
                    'target service {service}'.format(
                        profile=attack_profile, service=target.get_service_name()))
                return
            else:
                filter_checks = attack_profile.get_checks_for_service(
                    target.get_service_name())

                logger.info('Selected attack profile: {}'.format(attack_profile))


        # Initialize sub status/progress bar
        checks_progress = manager.counter(total=len(filter_checks)+1, 
                                          desc='', 
                                          unit='check',
                                          leave=False,
                                          bar_format=STATUSBAR_FORMAT)
        time.sleep(.5) # hack for progress bar display

        i = 1
        for checkname in filter_checks:
            print()
            check = self.get_check(checkname)

            # Update status/progress bar
            status = ' +--> Current check [{cur}/{total}]: {category} > ' \
                '{checkname}'.format(
                    cur       = i,
                    total     = len(filter_checks),
                    category  = check.category,
                    checkname = checkname)

            checks_progress.desc = '{status}{fill}'.format(
                status = status,
                fill   = ' '*(DESC_LENGTH-len(status)))
            checks_progress.update()
            if attack_progress:
                # Hack to refresh the attack progress bar without incrementing
                # useful if the tool run during the check has cleared the screen
                attack_progress.update(incr=0, force=True) 

            # Run the check if:
            #   - The check has not been already run for this target (except 
            #       if --recheck is specified in command-line)
            #   - Target is compliant with the check,
            #   - The tool used for the check is well installed.

            results_req = ResultsRequester(sqlsession)
            results_req.select_mission(target.service.host.mission.name)
            filter_ = Filter(FilterOperator.AND)
            filter_.add_condition(Condition(target.service.id, 
                FilterData.SERVICE_ID))
            filter_.add_condition(Condition(check.name, FilterData.CHECK_NAME))
            results_req.add_filter(filter_)
            result = results_req.get_first_result()

            if result is None or arguments.args.recheck == True:

                if check.check_target_compliance(target):

                    Output.title2('[Check {num:02}/{total:02}] {name} > ' \
                        '{description}'.format(
                            num         = i,
                            total       = len(filter_checks),
                            name        = check.name,
                            description = check.description))

                    if not check.tool.installed:
                        logger.warning('Skipped: the tool "{tool}" used by ' \
                            'this check is not installed yet'.format(
                                tool=check.tool.name))
                    else:
                        try:
                            check.run(target, 
                                      arguments,
                                      sqlsession)
                        except KeyboardInterrupt:
                            print()
                            logger.warning('Check {check} skipped !'.format(
                                check=check.name))

                else:
                    logger.info('[Check {num:02}/{total:02}] ' \
                        '{name} > Skipped because context requirements are ' \
                        'not matching the target'.format(
                            name     = check.name,
                            num      = i,
                            total    = len(filter_checks)))
                    time.sleep(.2)

            else:

                logger.info('[Check {num:02}/{total:02}] ' \
                        '{name} > Skipped because the check has already ' \
                        'been run'.format(
                            name     = check.name,
                            num      = i,
                            total    = len(filter_checks)))
                time.sleep(.2)

            i += 1     

        checks_progress.update()
        time.sleep(.5)

        checks_progress.close()  


    #------------------------------------------------------------------------------------
    # Output methods

    def show(self):
        """Display a table with all the checks for the service."""
        data = list()
        columns = [
            'Name',
            'Category',
            'Description',
            'Tool used',
            #'# Commands',
        ]
        for category in self.categories:
            for check in self.checks[category]:
                color_tool = 'grey_19' if not check.tool.installed else None
                data.append([
                    check.name,
                    category,
                    check.description,
                    Output.colored(check.tool.name, color=color_tool),
                    #len(check.commands),
                ])
                
        Output.title1('Checks for service {service}'.format(service=self.service))
        Output.table(columns, data, hrules=False)



