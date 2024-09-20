import os
import random
from rgbprint import gradient_print

try:
    from colorama import Fore, Style
except ModuleNotFoundError:
    os.system("pip install colorama")

from urllib.request import urlopen
from Core.helper.color import green, white, blue, red, start, alert , yellow , purple

green = yellow
red   = purple
white = purple
Version = "2.2"

banner = r"""
                   _,.---.---.---.--.._ 
               _.-' '--.'---.'---'-. _,'--.._
              /'--._ .'.     '.     ','-.'-._\
             ||   \  '.'---.__'__..-'. ,''-._/
        _  ,'\ '-._\   \    '.    '_.-'-._,''-.
     ,'   '-_ \/ '-.'--.\    _\_.-'\__.-'-.'-._'.
    (_.o> ,--. '._/'--.-',--'  \_.-'       \'-._ \
     '---'    '._ '---._/__,----'           '-. '-\
               /_, ,  _..-'                    '-._\
               \_, \/ ._(       Jesus Christ is
                \_, \/ ._\  The Lamb that was slain
                 '._,\/ ._\      for our sins.
                   '._// ./'-._
                     '-._-_-_.-'
"""


def connected(host='http://duckduckgo.com'):
    try:
        urlopen(host)
        return True
    except:
        return False


all_col = [Style.BRIGHT + Fore.RED, Style.BRIGHT + Fore.CYAN, Style.BRIGHT + Fore.LIGHTCYAN_EX,
           Style.BRIGHT + Fore.LIGHTBLUE_EX, Style.BRIGHT + Fore.LIGHTCYAN_EX, Style.BRIGHT + Fore.LIGHTMAGENTA_EX,
           Style.BRIGHT + Fore.LIGHTYELLOW_EX]

ran = random.choice(all_col)


def menu():
    print(green + banner + white)
    print(blue + "\n        ~>( 🪝" + white + "Select a number from the table below" + blue + " )<~\n" + white)
    print(blue + "[ 01. Instagram................12.Paypal..................]")
    print(blue + "[ 02. Facebook.................13.Discord.................]")
    print(blue + "[ 03. Gmail....................14.Spotify.................]")
    print(blue + "[ 04. Gmail(Si)................15.Blockchain..............]")
    print(blue + "[ 05. Twitter..................16.RiotGames...............]")
    print(blue + "[ 06. Snapchat.................17.Rockstar................]")
    print(blue + "[ 07. SnapchatS................18.AskFM...................]")
    print(blue + "[ 08. Steam....................19.000Webhost..............]")
    print(blue + "[ 09. Dropbox..................21.Gamehag.................]")
    print(blue + "[ 10. Linkedin.................22.Mega....................]")
    print(blue + "[ 11. Playstation.........................................]")
    print(blue + "[ 0...EXIT and go back to menu............................]")
    print(blue + "[ file will be saved at /root/.africana/output/OutputName.]")

menu()

