import sys
import os

INJECT_API_KEY = "AIzaSyBxQtEky-iIky5G7uajz5Q9fx1f1mBIhl8"
DETECT_TARGET_PATTERN = "google_api_public_key_inject_flutter_android_manifest_xml"
TARGET_FILE_LOCATION = "./android/app/src/main/AndroidManifest.xml"

def inject():
    file = ""
    with open(TARGET_FILE_LOCATION, 'r') as handle:
        file = handle.readlines()
    
    file = "".join(file)
    
    file = file.replace(DETECT_TARGET_PATTERN, INJECT_API_KEY)

    with open(TARGET_FILE_LOCATION, 'w') as handle:
        handle.write(file)

def hide():
    file = ""
    with open(TARGET_FILE_LOCATION, 'r') as handle:
        file = handle.readlines()
    
    file = "".join(file)


    file = file.replace(INJECT_API_KEY, DETECT_TARGET_PATTERN)

    with open(TARGET_FILE_LOCATION, 'w') as handle:
        handle.write(file)

if (os.path.isfile(TARGET_FILE_LOCATION) == False):
    input("not the proper injection target specified. \nexit to any ...")
    exit()

if (len(sys.argv) > 1):
    if (sys.argv[1] == "inject"):
        inject()
    elif (sys.argv[1] == "hide"):
        hide()
