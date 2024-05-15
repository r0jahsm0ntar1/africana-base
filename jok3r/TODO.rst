=====
TODO
=====

BUGS
===============================================================================
* When using --cat-only: [Check 01/total] => total is taking all checks in account
* cmd> java -jar jndiat.jar datasource -v -s 192.168.142.41 -p 7002   
	SEVERE:You must to choose a mandatory command (--sql-shell, --listen-port)  to run this module


IMPROVEMENTS / NEW FEATURES
===============================================================================
* Run custom command
* Session / Restore
* Indicate checks that need a reverse connection (IP reachable from target)
* Products SMTP (eg Exim) https://en.wikipedia.org/wiki/List_of_mail_server_software

* Web UI to view results in live (Flask ?)


SMARTMODULES / MATCHSTRINGS
===============================================================================
Not done yet:
* whatweb

      Summary   : Script, HTML5, Drupal, PHP[7.2.3], HTTPServer[Debian Linux][Apache/2.4.25 (Debian)], X-Powered-By[PHP/7.2.3], PoweredBy[-block], UncommonHeaders[x-drupal-dynamic-cache,x-content-type-options,x-generator,x-drupal-cache], MetaGenerator[Drupal 8 (https://www.drupal.org)], Content-Language[en], Apache[2.4.25], X-Frame-Options[SAMEORIGIN], X-UA-Compatible[IE=edge]

      Summary   : PHP[5.6.40], X-Powered-By[PHP/5.6.40], JQuery, PasswordField[password], HttpOnly[89f8df32fa3e404e00d734d41437761f], MetaGenerator[Joomla! - Open Source Content Management], HTTPServer[Debian Linux][Apache/2.4.25 (Debian)], Cookies[89f8df32fa3e404e00d734d41437761f], Apache[2.4.25], HTML5, Script[application/json]

* davscan
* wpseku 
* vbscan
* barmie
* snmpwn



TOOLS/CHECKS TO ADD
===============================================================================
* https://github.com/Coalfire-Research/java-deserialization-exploits/blob/master/OpenNMS/opennms_rce.py
* https://github.com/AlisamTechnology/PRESTA-modules-shell-exploit/blob/master/PRESTA-shell-exploit.pl
* Sharepoint -> https://github.com/TestingPens/SPartan
* check https://bitvijays.github.io/LFF-IPS-P2-VulnerabilityAnalysis.html
* https://github.com/RhinoSecurityLabs/CVEs/tree/master/CVE-2019-0227
* http://pentestit.com/apache-jmeter-rmi-remote-code-execution-vulnerability-poc-cve-2018-1297/
* Wordpress RCE https://github.com/opsxcq/exploit-CVE-2016-10033
* https://github.com/peacand/winsharecrawler
* https://github.com/Bo0oM/fuzz.txt/blob/master/fuzz.txt

DOCUMENTATION
===============================================================================
* Important note: need to be reachable directly from target for exploit with reverse shell !


SERVICES TO ADD
===============================================================================
* NFS
    * nfsshell (sudo apt-get install libreadline-dev ; make)
* MongoDB
* RPC
    * https://github.com/hegusung/RPCScan.git
* DNS
* LDAP
* MDNS
    * https://github.com/chadillac/mdns_recon
* POP3
* REXEC
* RLOGIN
* RSH
* IMAP




rvm list
rvm use ruby-2.4
rvm gemset create ww

rvm gemset list
rvm gemset delete whatweb-test --force

rvm use ruby-2.4@ww
or
rvm use ruby-2.4
rvm gemset use ww

rvm current # show current env
ruby -v
http://masnun.com/2012/01/28/fetching-changed-files-diff-between-two-git-commits-in-python.html