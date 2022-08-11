sudo apt-get install unzip
rm install.bash
# menu.sh
# Description: Bash menu generator
# 
# Created by Jamie Cruwys on 21/02/2014.
#

# Configuration
symbol="*"
paddingSymbol=" "
lineLength=70
charsToOption=1
charsToName=3

function generatePadding() {
    string="";
    for (( i=0; i < $2; i++ )); do
        string+="$1";
    done
    echo "$string";
}

# Generated configs
remainingLength=$(( $lineLength - 2 ));
line=$(generatePadding "${symbol}" "${lineLength}");
toOptionPadding=$(generatePadding "${paddingSymbol}" "${charsToOption}");
toNamePadding=$(generatePadding "$paddingSymbol" "$charsToName");

# generateText (text)
function generateText() {
    totalCharsToPad=$((remainingLength - ${#1}));
    charsToPadEachSide=$((totalCharsToPad / 2));
    padding=$(generatePadding "$paddingSymbol" "$charsToPadEachSide");
    totalChars=$(( ${#symbol} + ${#padding} + ${#1} + ${#padding} + ${#symbol} ));
    if [[ ${totalChars} < ${lineLength} ]]; then
        echo "${symbol}${padding}${1}${padding}${paddingSymbol}${symbol}";
    else
        echo "${symbol}${padding}${1}${padding}${symbol}";
    fi
}

# generateTitle (title)
function generateTitle() {  
    echo "$line"
    generateText ""
    generateText "$1"
    generateText ""
    echo "$line"
}

# generateOption (dialogType, optionNumber, optionName)
function generateOption() {
    tempOptionPadding=$toOptionPadding
    tempNamePadding=$toNamePadding
    if [[ $1 == "options" ]]; then
        if [[ $3 == "Exit" ]] || [[ $3 == "Return to the main menu" ]]; then
            optionString="[0]"
        else
            optionString="[$2]"
        fi
    elif [[ $1 == "instructions" ]]; then
        optionString="$2."
    fi
    charsToPadName=$(( ${lineLength} - ${#symbol} - ${#tempOptionPadding} - ${#optionString} - ${#tempNamePadding} - ${#3} - ${#symbol} ));
    namePadding=$(generatePadding "$paddingSymbol" "$charsToPadName");
    echo "${symbol}${tempOptionPadding}${optionString}${tempNamePadding}${3}${namePadding}${symbol}";
}

# generateOptionsFromArray (dialogType, array[options])
function generateOptionsFromArray() {
    index=1
    generateText "" 
    for OPTION in "${@:2}"
    do
        if [[ "$1" == "message" ]]; then
            generateText "$OPTION"
        else
            generateOption "$1" "$index" "$OPTION"
        fi
        ((index++))
    done
    generateText ""
}

# generateDialog (dialogType, dialogTitle, array[options])
function generateDialog() { 
    generateTitle "$2"
    generateOptionsFromArray "$1" "${@:3}"
    echo "$line";
}

# generateGoBackDialog (name, isNewLine)
function generateGoBackDialog() {
    if [[ $2 == "true" ]]; then
        echo -e "\n$line"
    else
        echo -e "$line"
    fi
    generateText ""
    generateOption "options" "0" "$1"
    generateText ""
    echo -e "$line"
}

# generateMessageDialog (title, array[message])
function generateMessageDialog() {
    if [[ "${#1}" > 0 ]]; then
        generateTitle "$1"
    fi
    generateOptionsFromArray "message" "${@:2}"
    echo -e "$line"
}
clear
declare -a dialogwelcome=("Hello, welcome to the Paradox MC Server Creation Tool." "This step by step process will quickly create a Minecraft server " "for you that you can customize your self.");
generateMessageDialog "Welcome!" "${dialogwelcome[@]}"
read -p "CONTINUE > "
clear
declare -a dialogdirnotice=("Your server will be created in THIS folder." "If you do not want this to happen, please exit" "this script and start it somewhere else.");
generateMessageDialog "Notice" "${dialogdirnotice[@]}"
read -p "CONTINUE > "
function INSTALL() {
    echo "Installing your server now."
    if [ $SOFTWARE = "paper" ]; then
        if [ $VERSION = "1.19" ]; then
            curl --output jar.zip https://paradox.blue/projects/createserver/jars/paper119.zip
            unzip jar.zip
            rm jar.zip
        elif [ $VERSION = "1.18" ]; then
            curl --output jar.zip https://paradox.blue/projects/createserver/jars/paper118.zip
            unzip jar.zip
            rm jar.zip
        elif [ $VERSION = "1.17" ]; then
            curl --output jar.zip https://paradox.blue/projects/createserver/jars/paper117.zip
            unzip jar.zip
            rm jar.zip
        else
            echo "Error, please restart."
        fi
    elif [ $SOFTWARE = "spigot" ]; then
        if [ $VERSION = "1.19" ]; then
            curl --output jar.zip https://paradox.blue/projects/createserver/jars/spigot119.zip
            unzip jar.zip
            rm jar.zip
        elif [ $VERSION = "1.18" ]; then
            curl --output jar.zip https://paradox.blue/projects/createserver/jars/spigot118.zip
            unzip jar.zip
            rm jar.zip
        elif [ $VERSION = "1.17" ]; then
            curl --output jar.zip https://paradox.blue/projects/createserver/jars/spigot117.zip
            unzip jar.zip
            rm jar.zip
        else
            echo "Error, please restart."
        fi
    elif [ $SOFTWARE = "bukkit" ]; then
        if [ $VERSION = "1.19" ]; then
            curl --output jar.zip https://paradox.blue/projects/createserver/jars/bukkit119.zip
            unzip jar.zip
            rm jar.zip
        elif [ $VERSION = "1.18" ]; then
            curl --output jar.zip https://paradox.blue/projects/createserver/jars/bukkit118.zip
            unzip jar.zip
            rm jar.zip
        elif [ $VERSION = "1.17" ]; then
            curl --output jar.zip https://paradox.blue/projects/createserver/jars/bukkit117.zip
            unzip jar.zip
            rm jar.zip
        else
            echo "Error, please restart."
        fi
    else
        echo "Error, please restart."
    fi
    if [ $PLUGINS = "yes" ]; then
        mkdir plugins
        cd plugins
        curl --output plugins.zip https://paradox.blue/projects/createserver/plugins.zip
        unzip plugins.zip
        rm plugins.zip
    fi
    echo "Completed! You can now do everything else :)"
}
function EULA() {
    clear
    declare -a dialogEULA=("Yes" "No");
    generateDialog "options" "Do you accept the MC EULA? https://aka.ms/MinecraftEULA" "${dialogEULA[@]}"
    read -p "CHOOSE > " EULA
    if [ $EULA = "yes" ]; then
        echo "eula=true" >> eula.txt
        INSTALL
    elif [ $EULA = "no" ]; then
        echo "Cannot continue without accepting eula"
    else
        echo "Cannot continue without accepting eula"
    fi
}
function PLUGINSCHOICE() {
    clear
    declare -a dialogpluginsnotice=("Would you like to install our premade plugins list" "It contains all plugins for a simple server" "It will be shown on the next screen")
    generateMessageDialog "Notice" "${dialogpluginsnotice[@]}"
    read -p "CONTINUE > "
    clear
    declare -a dialogpluginslist=("EssentialsX" "EssentialsX Chat" "World Edit" "World Guard" "Multiverse Core" "Multiverse Inventories" "Vault" "Skript")
    generateDialog "instructions" "Plugins List:" "${dialogpluginslist[@]}"
    read -p "CONTINUE > "
    clear
    declare -a dialogpluginssure=("Yes" "No");
    generateDialog "options" "Would you like to install it?" "${dialogpluginssure[@]}"
    read -p "CHOOSE > " PLUGINS
    EULA
}
function VERSION_SURE() {
    clear
    declare -a dialogversionsure=("Yes" "No");
    generateDialog "options" "You chose $VERSION, is this correct?" "${dialogversionsure[@]}"
    read -p "CHOOSE > " VERSIONSURE
    if [ $VERSIONSURE = "yes" ]; then
        PLUGINSCHOICE
    elif [ $VERSIONSURE = "no" ]; then
        VERSIONCHOICE
    else
        VERSIONCHOICE
    fi
}
function VERSIONCHOICE() {
    clear
    declare -a dialogversion=("1.19" "1.18" "1.17");
    generateDialog "options" "Server Version" "${dialogversion[@]}"
    read -p "CHOOSE > " VERSION
    VERSION_SURE
}
function SOFTWARE_SURE() {
    clear
    declare -a dialogsoftwaresure=("Yes" "No");
    generateDialog "options" "You chose $SOFTWARE, is this correct?" "${dialogsoftwaresure[@]}"
    read -p "CHOOSE > " SOFTWARESURE
    if [ $SOFTWARESURE = "yes" ]; then
        VERSIONCHOICE
    elif [ $SOFTWARESURE = "no" ]; then
        SOFTWARECHOICE
    else
        SOFTWARECHOICE
    fi
}
function SOFTWARECHOICE() {
    clear
    declare -a dialogsoftware=("Paper (Recommended)" "Spigot" "Bukkit");
    generateDialog "options" "Server Software" "${dialogsoftware[@]}"
    read -p "CHOOSE > " SOFTWARE
    SOFTWARE_SURE
}
SOFTWARECHOICE

