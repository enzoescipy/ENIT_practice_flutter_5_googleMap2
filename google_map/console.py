import subprocess
import os
import api_handler
from termcolor import colored

while True:
    try:
        user_input = input(colored(os.getcwd() + " > ", color='cyan' ,attrs=['bold']))
        api_handler.hide()
        subprocess.run(user_input)
        api_handler.inject()
    except Exception:
        pass
