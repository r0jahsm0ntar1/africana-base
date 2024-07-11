#!/usr/bin/env python3
# -*- coding: utf-8 -*-
###
### Core > AttackScope
###
import sys
import time

from lib.core.Config import *
from lib.requester.ResultsRequester import ResultsRequester
from lib.requester.ServicesRequester import ServicesRequester
from lib.utils.StringUtils import StringUtils
from lib.output.Logger import logger
from lib.output.Output import Output
from lib.output.StatusBar import *


class AttackScope:
    """Stores all targets selected for the current attack."""

    def __init__(self, 
                 settings, 
                 arguments,
                 sqlsession,
                 mission,
                 filter_categories=None, 
                 filter_checks=None, 
                 attack_profile=None,
                 fast_mode=False):
        """
        Construct AttackScope object

        :param Settings settings: Settings
        :param ArgumentsParser arguments: Arguments from command-line
        :param Session sqlsession: SQLAlchemy session
        :param str mission: Mission name
        :param list filter_categories: Selection of categories of checks to run 
            (default is None, for all categories)
        :param list filter_checks: Selection of checks to run
            (default is None, for all checks)
        :param AttackProfile attack_profile: Attack profile
            (default is None, meaning no profile)
        :param bool fast_mode: Set to true to disable prompts
        """
        self.settings            = settings
        self.arguments           = arguments
        self.sqlsess             = sqlsession
        self.mission_name        = mission
        self.services_requester  = ServicesRequester(self.sqlsess)
        self.targets             = list()
        self.current_targetid    = 1
        self.filter_categories   = filter_categories
        self.filter_checks       = filter_checks
        self.attack_profile      = attack_profile
        self.fast_mode           = fast_mode

        self.services_requester.select_mission(self.mission_name)


    #------------------------------------------------------------------------------------

    def add_target(self, target):
        """
        Add a target to the scope.

        :param Target target: Target to add
        """ 
        self.targets.append(target)

    #------------------------------------------------------------------------------------
    # Run Methods

    def attack(self):
        """Run the attack against all targets in the scope"""

        # Initialize top status/progress bar
        # If single target (total=None), the counter format will be used instead of 
        # the progress bar format
        attack_progress = manager.counter(
            total=len(self.targets)+1 if len(self.targets) > 1 else None, 
            desc='', 
            unit='target',
            bar_format=STATUSBAR_FORMAT, # For multi targets
            counter_format=STATUSBAR_FORMAT_SINGLE) # For single target

        time.sleep(.5) # hack for progress bar display

        # Loop over the targets
        for i in range(1,len(self.targets)+1):

            # Display table with targets
            self.show_summary()

            # Prompt for target selection
            if not self.fast_mode:
                if len(self.targets) == 1:
                    if Output.prompt_confirm('Start attack ?', default=True):
                        self.current_targetid = 1
                    else:
                        logger.warning('Attack canceled !')
                        sys.exit(1)

                else:
                    self.current_targetid = Output.prompt_choice_range(
                        'Attack target # (Ctrl+C to quit) ? [{default}] '.format(
                            default=self.current_targetid), 
                        1, len(self.targets), self.current_targetid)

            target = self.targets[self.current_targetid-1]

            # Update status/progress bar
            status = 'Current target [{cur}/{total}]: {target}'.format(
                    cur    = i,
                    total  = len(self.targets),
                    target = target)

            attack_progress.desc = '{status}{fill}'.format(
                status = status,
                fill   = ' '*(DESC_LENGTH-len(status)))
            attack_progress.update()
            print()

            # Check the selected target and update its information
            # This is done for targets loaded from the database in multi-targets mode
            # (For single target, done before adding it to a mission in AttackController)
            #
            # - Reverse DNS lookup: not by default (should have already been done)
            # - Port check: always (target might not been reachable anymore)
            # - Nmap service detection: not by default (should have already been done)
            # - HTML title grabbing: always
            # - Web technologies detection: always
            # - Context initialization via SmartStart: always
            if len(self.targets) > 1:
                reachable = target.smart_check(
                    reverse_dns_lookup=(self.arguments.args.reverse_dns == 'on'), 
                    availability_check=True, 
                    nmap_banner_grabbing=(self.arguments.args.nmap_banner_grab == 'on'),
                    html_title_grabbing=True,
                    web_technos_detection=True,
                    smart_context_initialize=True)

                # Update info into database if needed
                self.services_requester.add_target(target)

                # Display availability status, skip if not reachable
                if target.service.name == 'http':
                    msg = 'Target URL {url} is {neg}reachable'.format(
                        url=target.get_url(),
                        neg='not ' if not reachable else '')
                else:
                    msg = 'Target {neg}reachable: {target}'.format(
                        neg='not ' if not reachable else '',
                        target=target)

                if reachable:
                    logger.success(msg)
                else: 
                    logger.error(msg)
                    self.__next_target()
                    continue

            # Launch the attack on the selected target
            self.__attack_target(target, attack_progress)

            # Move to next target
            self.__next_target()


        # Clear progress bars
        attack_progress.update()
        time.sleep(.5)

        attack_progress.close()
        manager.stop() 


    def __attack_target(self, target, attack_progress):
        """
        Run security checks against one target.

        :param Target target: The Target
        :param enlighten.Counter attack_progress: Attack progress
        """
                   
        # Print target information
        target.print_http_headers()
        target.print_context()

        # Run security checks
        service_checks = self.settings.services.get_service_checks(
            target.get_service_name())
        service_checks.run(target, 
                           self.arguments,
                           self.sqlsess,
                           filter_categories=self.filter_categories, 
                           filter_checks=self.filter_checks,
                           attack_profile=self.attack_profile,
                           attack_progress=attack_progress)


    def __next_target(self):
        """
        Move to next target by incrementing current target id
        """
        if self.current_targetid == len(self.targets):
            self.current_targetid = 1
        else:
            self.current_targetid += 1


    #------------------------------------------------------------------------------------
    # Output methods

    def show_summary(self):
        """
        Display a table showing the summary of the attack scope.
        The table has a max size defined in lib.core.Config, to avoid displaying an
        unreadable summary when large amount of targets have been loaded.
        """
        if len(self.targets) > ATTACK_SUMMARY_TABLE_MAX_SIZE:
            id_min = self.current_targetid-2
            if id_min < 1:  
                id_min = 1

            id_max = self.current_targetid+ATTACK_SUMMARY_TABLE_MAX_SIZE-1 \
                -(self.current_targetid-id_min)
            if id_max > len(self.targets):
                id_min = id_min-(id_max-len(self.targets))
                id_max = len(self.targets)
        else:
            id_min = 1
            id_max = len(self.targets)

        data = list()
        columns = [
            'id',
            'IP',
            'Hostname',
            'Port',
            'Proto',
            'Service',
            'Banner',
            'URL',
        ]
        id_ = 1
        for target in self.targets:
            if id_ < id_min:
                id_ += 1
                continue
            if id_ > id_max:
                break

            pointer_color = 'blue'   if self.current_targetid == id_ else None
            pointer_attr  = 'bold' if self.current_targetid == id_ else None

            data.append([
                Output.colored('>'+str(id_) if self.current_targetid == id_ \
                               else str(id_), 
                    color=pointer_color, attrs=pointer_attr),
                Output.colored(target.get_ip(), 
                    color=pointer_color, attrs=pointer_attr),
                Output.colored(StringUtils.wrap(target.get_host(), 50), 
                    color=pointer_color, attrs=pointer_attr),
                Output.colored(str(target.get_port()), 
                    color=pointer_color, attrs=pointer_attr),
                Output.colored(target.get_protocol(), 
                    color=pointer_color, attrs=pointer_attr),
                Output.colored(target.get_service_name(), 
                    color=pointer_color, attrs=pointer_attr),
                Output.colored(StringUtils.wrap(target.get_banner(), 55), 
                    color=pointer_color, attrs=pointer_attr),
                Output.colored(StringUtils.wrap(target.get_url(), 50), 
                    color=pointer_color, attrs=pointer_attr),
            ])
            id_ += 1

        print()
        Output.table(columns, data, hrules=False)
        if len(self.targets) > ATTACK_SUMMARY_TABLE_MAX_SIZE:
            logger.info('Table has been truncated. Total number of loaded ' \
                'targets: {}'.format(len(self.targets)))
        print()

