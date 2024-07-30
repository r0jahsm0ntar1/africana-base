# -*- coding: utf-8 -*-
import glob
import signal
import threading
import multiprocessing
import ipaddress
import time
import os
import sys
import socket
import argparse
import warnings
from datetime import datetime
import navigator


warnings.filterwarnings("ignore")

domainList = []
scopeList = []

animation = "⢿⣻⣽⣾⣷⣯⣟⡿"
reset = '\033[m'
light_grey = '\033[37m'
dark_grey = '\033[90m'
red = '\033[31m'
green = '\033[32m'
bold = '\033[1m'
yellow = '\033[93m'
blue = '\033[96m'


def banner():
    head = ''' 
\t                      {1};            ;                  
\t                    {0}ρ{1}ββΚ          ;ββΝ                
\t                  {0}έΆ{1}χββββββββββββββββββΒ              
\t                {0};ΣΆ{1}χΜ΅΅ΫΝββββββββ Ϋ΅΅ΫβββΝ            
\t               {0}όΆΆχ{1}β   {2}Ά{1}   ββββ΅  {2}Ά΅{1}  βββββ           
\t              {0}χΆΆΆφ{1}βΒ; {2}Ϋ΅{1};έββββΒ; {2}Ϋ΅{1} ρββββββ          
\t              {0}ΆΆΆΆδ{1}βββββββββ{0};χ{1}ββββββμβββββββ          
\t              {0}ΪχχχχΧ{1}βββββββββββββββββββθθθθΚ          
\t             {0}·ϊβθβζ  {1}Ϊθθβββββββββββββββμ ;όβΫ΅        
\t              {0}·΅   ΅ΫΫΫΆΆθ{1}βββββββββθθΫ΅   ΅Ϋ΅         
\t                      {0};ΣΆθ{1}ββββΒΝρρρμ                  
\t                     {0};ΣΆΆ{1}βββββββββββμ{3}
\t ▄∞∞∞∞∞▄, ╒∞∞▄   ∞∞▄ ▄∞∞∞∞∞∞▄   ,▄∞∞∞∞▄      ▄∞∞4▄  ╒∞∞∞∞∞∞∞▄,
\t▐▄ ═▄▄▄ ▐█▐ ,▀  j' █▌█  ▄▄▄ ▀█▌█▀ ╓▄▄  ▀▄  ¡█  , ▐█ ▐▄▄▄  ▄▄██
\t▐▄ `'""▀██▐  █▌ j  █▌█  `"" ▄█▌█ ▐█▀`▀▄██' M  $██  █, `█ ▐█```
\tj▀▀███▌ ▐█▐  ▀▌▄█  ▀▀█ ▐███  █▌▄ ▀█▄▄▀ ▐█M▀.       ▀█▄.▀ J▀
\t╚▄,,¬¬⌐▄█▌ ▀▄,,, ▄██ █,,,,,▓██▌ ▀▄,,,,▄█╩j▌,██▀▀▀▀▌,█▌`█,▐█
\t  ▀▀▀▀▀▀▀    ▀▀▀▀▀▀ ""▀▀▀▀▀▀      ▀▀▀""`  ▀▀▀     ▀▀▀   ▀▀▀
\t               {0}΅qΆΆΆΆ{1}βββββββββββββββββββββΡ΅  
\t                  {0}ΫθΆΆΆ{1}ββββββββββββββββΡ΅         
\t                      {1}΅ΫΫΫΫΝNNΝΫΫΫΐ΅΅      
\t                    
\t                    
\t                    {5}v{0}{{{2}1.2.1{5}#dev}}{0}@{3}duty1g{1}
\t                            {4}
'''
    head = head.format(light_grey, dark_grey, red, yellow, reset, green)
    #os.system('cls' if os.name == 'nt' else 'clear')
    print(bold + head + reset)


class SubCat:
    def __init__(self, domain, output, threads=50, scope=False, debug=False, statusCode=False, title=False, ip=False,
                 silent=False):
        self.domain = domain
        self.threads = threads
        self.scope = scope
        self.debug = debug
        self.silent = silent
        self.statusCode = statusCode
        self.title = title
        self.ip = ip
        self.output = output
        self.scopeList = []
        if self.scope:
            self._log('Loading scope list')
            with open(self.scope) as f:
                lines = f.readlines()
            self._log('Resolving scope list to IPV4')
            for line in lines:
                for ip in ipaddress.IPv4Network(line.strip()):
                    self.scopeList.append(str(ip))

    def log(self, line):
        if self.output and not self.silent:
            with open(self.output, 'a') as output_file:
                output_file.write("%s\n" % line)

    def fetchWorker(self, q):
        domainAndIp = q
        domainReturn = domainAndIp
        if self.statusCode:
            try:
                statusCode = navigator.Navigator().downloadResponse('http://{}'.format(domainAndIp), 'STATUS',
                                                                    'HEAD').status_code
            except:
                statusCode = 'TIMEOUT'

            if statusCode is not None:
                if statusCode == 200:
                    domainReturn += ' [{0}{1}{2}]'.format(green, statusCode, reset)
                    if self.title:
                        title = navigator.Navigator().downloadResponse('http://{}'.format(domainAndIp), 'TITLE',
                                                                       'GET')
                        domainReturn += ' [{0}{1}{2}]'.format(dark_grey, title, reset)
                elif statusCode == 'TIMEOUT':
                    domainReturn += ' [{0}{1}{2}]'.format(red, statusCode, reset)
                else:
                    domainReturn += ' [{0}{1}{2}]'.format(dark_grey, statusCode, reset)

            # if self.title and statusCode != 'TIMEOUT':
            #     title = navigator.Navigator().downloadResponse('http://{}'.format(domainAndIp), 'TITLE',
            #                                                    'GET')
            #     domainReturn += ' [{0}{1}{2}]'.format(dark_grey, title, reset)

        if self.ip:
            ipDomain = self.getIP(domainAndIp)
            if self.scope:
                if ipDomain in self.scopeList:
                    domainReturn += ' {}'.format(ipDomain)
                    sys.stdout.write(domainReturn + '\n')
                self.log(domainReturn)
            else:
                domainReturn += ' {}'.format(ipDomain)
                sys.stdout.write(domainReturn + '\n')
                self.log(domainReturn)
        elif self.scope:
            ipDomain = self.getIP(domainAndIp)
            if ipDomain in self.scopeList:
                sys.stdout.write(domainReturn + '\n')
                self.log(domainReturn)
        else:
            domainReturn += ''
            sys.stdout.write(domainReturn + '\n')
            self.log(domainReturn)

    def ModulesWorker(self, q):
        module = q
        mod = __import__('modules.{0}'.format(module))
        rr = getattr(mod, module).returnDomains(self.domain, self.silent)
        return rr


    def init_worker(self):
        signal.signal(signal.SIGINT, signal.SIG_IGN)

    def fetchDomains(self, sublist):
        try:
            pool = multiprocessing.Pool(self.threads, initializer=self.init_worker)
            pool.map(self.fetchWorker, sublist)
            pool.close()
            pool.join()
        except KeyboardInterrupt:
            self._warn('Shutting down...')
            pool.terminate()

    def fetch(self):
        self._log('loading Modules')
        dir_path =  os.path.dirname(os.path.realpath(__file__)) + '/modules/*.py'
        modules = []
        for path in glob.glob(dir_path):
            if os.path.isfile(os.path.join(dir_path, path)):
                if '__init__.py' not in path:
                    modules.append(os.path.basename(path).replace('.py',''))

        try:
            pool = multiprocessing.Pool(self.threads)
            result = pool.map_async(self.ModulesWorker, modules)
            pool.close()
            load = 1
            while result._number_left > 1:
                if not self.silent:
                    self._info('{0} Enumerating subdomains for {4}{2}{5}{5}'.format(animation[
                                                                                        load % len(animation)], 0,
                                                                                    self.domain, yellow, red, reset),
                               r=True)
                    sys.stdout.flush()
                    load += 1
                    time.sleep(0.09)
                    sys.stdout.flush()
            pool.join()
            domainList = []
            for __ in result.get():
                for _ in __:
                    domainList.append(_.lower())
                domainList = list(dict.fromkeys(domainList))
            sys.stdout.write('\x1b[2K\n')
            self._info('Found {2}{0}{4} for {3}{1}{4}\n\n'.format(len(domainList), self.domain, yellow, red, reset), r=True)
            self.fetchDomains(domainList)

        except KeyboardInterrupt:
            self._warn('Shutting down...')
            pool.terminate()

    def getDomains(self):
        th = threading.Thread(target=self.fetch)
        th.daemon = True
        th.start()
        th.join()
        print()
    def _log(self, *args):
        if self.debug and not self.silent:
            now = datetime.now()
            current_time = now.strftime("%H:%M:%S")
            print(
                '[' + '\033[36m' + current_time + '\033[m' + '] [' + '\033[33m' + 'DBG' + '\033[m' + ']:' + '\033[m' + ' {0}'.format(
                    *args))

    def _info(self, *args, r=False):
        if not self.silent:
            now = datetime.now()
            current_time = now.strftime("%H:%M:%S")
            if r:
                sys.stdout.write('\r'
                                 '[' + '\033[36m' + current_time + '\033[m' + '] [' + '\033[36m' + 'INF' + '\033[m' + ']:' + '\033[m' + ' {0}'.format(
                    *args))
            else:
                print(
                    '[' + '\033[36m' + current_time + '\033[m' + '] [' + '\033[36m' + 'INF' + '\033[m' + ']:' + '\033[m' + ' {0}'.format(
                        *args))

    def _warn(self, *args):
        if not self.silent:
            now = datetime.now()
            current_time = now.strftime("%H:%M:%S")
            print(
                '\n\033[m[' + '\033[36m' + current_time + '\033[m' + '] [' + '\033[31m' + 'WRN' + '\033[m' + ']:' + '\033[m' + ' {0}'.format(
                    *args))

    def getIP(self, subdomain):
        try:
            return socket.gethostbyname(subdomain)
        except:
            return '0.0.0.0'


def argParserCommands():
    parser = argparse.ArgumentParser()
    parser.add_argument('-d', '--domain', dest="domain", help='domains to find subdomains for',
                        required=False)
    parser.add_argument('-l', default=(None if sys.stdin.isatty() else sys.stdin), type=argparse.FileType('r'),
                        dest="domainList", help='file containing list of domains for subdomain discovery',
                        required=False)
    parser.add_argument('-sc', '--status-code', dest="statusCode",
                        help='show response status code', default=False,
                        action="store_true")
    parser.add_argument('-title', '--title', dest="title",
                        help='show page title', default=False,
                        action="store_true")
    parser.add_argument('--scope', dest="scope",
                        help='show only subdomains in scope', default=False)
    parser.add_argument('-t', '--threads', type=int, dest="threads", default=50,
                        help="number of concurrent threads for resolving (default 40)")
    parser.add_argument('-ip', '--ip', dest="ip", help='Resolve IP address', default=False,
                        action="store_true")
    parser.add_argument('-v', dest="verbose", help='show verbose output', default=False,
                        action="store_true")
    parser.add_argument('-silent', '--silent', dest="silent", help='show only subdomains in output', default=False,
                        action="store_true")
    parser.add_argument("-o", "--output", help="file to write output to")

    return parser


if __name__ == "__main__":
    args = argParserCommands().parse_args()
    if not args.silent:
        banner()

    if args.domainList and args.domain is None:
        dlist = args.domainList.read()
        for d in dlist.split('\n'):
            subcat = SubCat(d.strip(), args.output, args.threads, args.scope, args.verbose, args.statusCode, args.title,
                            args.ip, args.silent)
            subcat.getDomains()
    elif args.domain and args.domainList is None:
        subcat = SubCat(args.domain, args.output, args.threads, args.scope, args.verbose, args.statusCode, args.title,
                        args.ip, args.silent)
        subcat.getDomains()
    elif args.domain and args.domainList:
        dlist = args.domainList.read()
        for d in dlist.split('\n'):
            subcat = SubCat(d.strip(), args.output, args.threads, args.scope, args.verbose, args.statusCode, args.title,
                            args.ip, args.silent)
            subcat.getDomains()
    else:
        argParserCommands().print_help()
