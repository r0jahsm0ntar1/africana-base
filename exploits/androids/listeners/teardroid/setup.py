import os
from Teardroid import banner
from colorama import Fore, Style
import subprocess
import random
import string


def id_generator(size=6, chars=string.ascii_uppercase + string.digits):
    return ''.join(random.choice(chars) for _ in range(size))


def run_without_output(command: str) -> None:
    os.system(command)


def save_token(token_instr):
    with open("/home/"+os.environ.get('USER')+"/.deta/tokens", "w") as token:
        token.write(str({"deta_access_token": token_instr}))
        os.environ["DETA_ACCESS_TOKEN"] = token_instr


def setup():
    print(Fore.GREEN + banner())
    print(Fore.GREEN + "Running teardroid control panel setup...")
    print(Fore.RED + "Please make sure your running this script as root.")
    print(Fore.GREEN + "Please login into your deta account and go to settings and get the access token")
    access_token = input("Please Enter your access token here : ")
    if (os.name != "posix"):
        print(Fore.RED + "This script is not for windows use wsl or codespace if your using windows or setup control panel manually...")
        os._exit(0)
    deta_cli_path = "/home/"+os.environ.get('USER')+"/.deta/bin/deta"
    deta_micro_name = id_generator()
    print(Fore.GREEN + "updating your system.")
    run_without_output("sudo apt-get update")
    print(Fore.GREEN + "installing git...")
    run_without_output("sudo apt-get install git")
    print(Fore.GREEN + "installing deta-cli...")
    run_without_output("curl -fsSL https://get.deta.dev/cli.sh | sh")
    print(Fore.GREEN + "setting your access token...")
    save_token(access_token)
    print(Fore.GREEN + "creating new micro in deta...")
    run_without_output(
        deta_cli_path + " new --python " + deta_micro_name)
    print(Fore.GREEN + "cloning teardroid_api repo")
    run_without_output(
        "git clone https://github.com/ScRiPt1337/Teardroidv4_api")
    print(Fore.GREEN + "Moving all the important files...")
    run_without_output(
        f"cp -r ./Teardroidv4_api/* ./{deta_micro_name}/")
    print(Fore.GREEN + "Deploying code into the cloud...")
    run_without_output(f"cd ./{deta_micro_name}/ && {deta_cli_path} deploy")


setup()
