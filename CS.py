import os
from os import name, system
import glob
import urllib.request
import zipfile
dir =  os.path.dirname(__file__)

def clear():
    if name == 'nt':
        _ = system('cls')
    else: 
        _ = system('clear')

def title():
    print("============== Paradox Create Server ==============")
    

def footer(step, outof, fail = False):
    if fail == True:
        print("===================== Failed ======================")
    else:
        pos = step + "/" + outof
        print("======================= " + pos + " =======================")
        
def install(software, version, plugins, bedrock):
    clear()
    print("Installing now!")
    print("Downloading server.jar - will take a moment!")
    if software == "1":
        if version == "1":
            urllib.request.urlretrieve("http://paradoxcdn.ddns.net/content/projects/createserver/jars/paper119.zip", "paper119.zip")
            print("Extracting server.jar")
            with zipfile.ZipFile("paper119.zip","r") as zip_ref:
                zip_ref.extractall(dir)
        elif version == "2":
            urllib.request.urlretrieve("http://paradoxcdn.ddns.net/content/projects/createserver/jars/paper118.zip", "paper118.zip")
            print("Extracting server.jar")
            with zipfile.ZipFile("paper118.zip","r") as zip_ref:
                zip_ref.extractall(dir)
        elif version == "3":
            urllib.request.urlretrieve("http://paradoxcdn.ddns.net/content/projects/createserver/jars/paper117.zip", "paper117.zip")
            print("Extracting server.jar")
            with zipfile.ZipFile("paper117.zip","r") as zip_ref:
                zip_ref.extractall(dir)
        else:
            clear()
            title()
            print("Incorrect version choice")
            print("Press any key to exit.")
            footer("0", "0", True)
            input()
            exit()
    elif software == "2":
        if version == "1":
            urllib.request.urlretrieve("http://paradoxcdn.ddns.net/content/projects/createserver/jars/spigot119.zip", "spigot119.zip")
            print("Extracting server.jar")
            with zipfile.ZipFile("spigot119.zip","r") as zip_ref:
                zip_ref.extractall(dir)
        elif version == "2":
            urllib.request.urlretrieve("http://paradoxcdn.ddns.net/content/projects/createserver/jars/spigot118.zip", "spigot118.zip")
            print("Extracting server.jar")
            with zipfile.ZipFile("spigot118.zip","r") as zip_ref:
                zip_ref.extractall(dir)
        elif version == "3":
            urllib.request.urlretrieve("http://paradoxcdn.ddns.net/content/projects/createserver/jars/spigot117.zip", "spigot117.zip")
            print("Extracting server.jar")
            with zipfile.ZipFile("spigot117.zip","r") as zip_ref:
                zip_ref.extractall(dir)
        else:
            clear()
            title()
            print("Incorrect version choice")
            print("Press any key to exit.")
            footer("0", "0", True)
            input()
            exit()
    elif software == "3":
        if version == "1":
            urllib.request.urlretrieve("http://paradoxcdn.ddns.net/content/projects/createserver/jars/bukkit119.zip", "bukkit119.zip")
            print("Extracting server.jar")
            with zipfile.ZipFile("bukkit119.zip","r") as zip_ref:
                zip_ref.extractall(dir)
        elif version == "2":
            urllib.request.urlretrieve("http://paradoxcdn.ddns.net/content/projects/createserver/jars/bukkit118.zip", "bukkit118.zip")
            print("Extracting server.jar")
            with zipfile.ZipFile("bukkit118.zip","r") as zip_ref:
                zip_ref.extractall(dir)
        elif version == "3":
            urllib.request.urlretrieve("http://paradoxcdn.ddns.net/content/projects/createserver/jars/bukkit117.zip", "bukkit117.zip")
            print("Extracting server.jar")
            with zipfile.ZipFile("bukkit117.zip","r") as zip_ref:
                zip_ref.extractall(dir)
        else:
            clear()
            title()
            print("Incorrect version choice")
            print("Press any key to exit.")
            footer("0", "0", True)
            input()
            exit()
    else:
        clear()
        title()
        print("Incorrect software choice")
        print("Press any key to exit.")
        footer("0", "0", True)
        input()
        exit()
    if plugins == "Y" or plugins == "y":
        print("Downloading plugins")
        urllib.request.urlretrieve("http://paradoxcdn.ddns.net/content/projects/createserver/plugins.zip", "plugins.zip")
        print("Extracting plugins")
        with zipfile.ZipFile("plugins.zip","r") as zip_ref:
            zip_ref.extractall(dir + "\plugins")
    if bedrock == "Y" or bedrock == "y":
        print("Downloading bedrock compatability")
        urllib.request.urlretrieve("http://paradoxcdn.ddns.net/content/projects/createserver/bedrock.zip", "bedrock.zip")
        print("Extracting bedrock compatibility")
        with zipfile.ZipFile("bedrock.zip","r") as zip_ref:
            zip_ref.extractall(dir + "\plugins")
    print("How many Giga Bytes of RAM would you like to allocate? eg: 5")
    gba = input(">> ")
    f = open("start.bat", "w")
    f.write("java -Xmx" + gba + "G -jar server.jar -nogui")
    f.close()
    print("Cleaning Up...")
    for file in glob.glob("*.zip"):
        os.remove(file)
    os.remove("Execute.bat")
    os.remove("requirements.txt")
    print("Finished! Please dispose of this python file and run the start.bat")
    

clear()
title()
print("Welcome to the Paradox Server Creation Tool!")
print("This guide will help you make a plugin-able server with a few plugins as a starter")
print("Press any key to continue")
footer("0", "5")
input()
clear()
title()
print("Please choose your server software")
print("* 1 - Paper (Recommended)")
print("* 2 - Spigot")
print("* 3 - Bukkit")
footer("1", "5")
software = input(">> ")
clear()
title()
print("Please choose your server version")
print("* 1 - 1.19")
print("* 2 - 1.18")
print("* 3 - 1.17")
footer("2", "5")
version = input(">> ")
clear()
title()
print("Would you like some plugins to come with your server?")
footer("3", "5")
plugins = input("Y/N >> ")
clear()
title()
print("Would you like to make your server bedrock compatible?")
print("!! - This requires extra configuration, no support will be provided!")
footer("4", "5")
bedrock = input("Y/N >> ")
clear()
title()
print("Do you accept the Minecraft End User License Agreement?")
footer("5", "5")
eula = input("Y/N >> ")
if eula == "N" or eula == "n":
    clear()
    title()
    print("You cannot continue without accepting the EULA")
    print("Press any key to exit.")
    footer("0", "0", True)
    input()
elif eula == "Y" or eula == "y" :
    f = open("eula.txt", "w")
    f.write("eula=true")
    f.close()
    install(software, version, plugins, bedrock)
else:
    clear()
    title()
    print("You cannot continue without accepting the EULA")
    print("Press any key to exit.")
    footer("0", "0", True)
    input()
    