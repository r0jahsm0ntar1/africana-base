import os
from colorama import Fore
red    = "\033[91m"
green  = "\033[92m"
white  = "\033[0m"
blue   = "\033[94m"
yellow = "\033[93m"

yellow = Fore.CYAN
purple = Fore.MAGENTA


start = (green + "[" + white + "+" + green + "]" + white)
alert = (green + "[" + red + "!" + green + "]" + white)

def numbering(num):
  return green + "[" + white + str(num) + green + "]"

def CurrentDir():
    path = '/root/.africana/output'
    print(green + "[" + white + "+" + green + "]" + white + " Your Templates Saved @ ~> " + path)
