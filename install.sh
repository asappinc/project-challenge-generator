#!/bin/bash -e

BASEURL="https://raw.githubusercontent.com/ASAPPinc/project-challenge-generator/master/scripts"

# Check dependencies
if [ -N `which node` ]; then
    echo "Please install node.js - https://nodejs.org/en/download"
    exit 1
fi

CUROFF='\033[?25l'
CURON='\033[?25h'
WH='\033[1;37m'
BL='\033[1;34m'
PK='\033[1;35m'
GR='\033[0;90m'
LG='\033[0;37m'
YL='\033[0;33m'
GN='\033[0;32m'
NC='\033[0m'
HID='\033[8m'

answer=''

function prompt() {
    local PROMPT=$1
    local INPUT=''
    local DUMMY=''
    printf " "
    while true; do
        printf "\r${WH}${PROMPT} ${BL}${INPUT}"
        IFS= read -rsn1 chr
        if [[ "$chr" == "" ]]; then
            break;
        elif [[ $chr == $'\033' ]]; then
            read -sn1 DUMMY
            read -sn1 DUMMY
        elif [[ "$chr" =~ ^[A-Za-z0-9_\ ]$ ]]; then
            INPUT+="${chr}"
        elif [[ "$chr" == $'\177' ]]; then
            printf "\b \b"
            INPUT="${INPUT%?}"
        fi
    done
    printf "\r${GR}${PROMPT} ${BL}${INPUT} \n"
    answer=${INPUT}
}

function promptYN() {
    local PROMPT=$1
    local SELECTED=1
    printf "${WH}${PROMPT} ${BL}[Y/N] "
    while true; do
        read -rsn1 yn
        case $yn in
            [Yy]* ) SELECTED=1; break;;
            [Nn]* ) SELECTED=0; break;;
        esac
    done
    yn=("No" "Yes")
    printf "\r${GR}${PROMPT} ${BL}${yn[$SELECTED]}     \n"
    answer=${yn[$SELECTED]}
}

function promptList() {
    local ARGS=$*
    local PROMPT=$1
    local LIST=(${ARGS:${#PROMPT}})
    local SELECTED=0
    printf "${CUROFF}${WH}${PROMPT}\n"
    while true; do
        for IDX in ${!LIST[@]}; do
            if [ ${SELECTED} -eq ${IDX} ]; then
                printf " ${BL}❯ ${LIST[$IDX]}     \n"
            else
                printf "   ${NC}${LIST[$IDX]}     \n"
            fi
        done
        read -rsn1 esc
        if [[ $esc == "" ]]; then
            break;
        elif [[ $esc == $'\033' ]]; then
            read -sn1 bra
            read -sn1 typ
        fi
        key="$esc$bra$typ"
        if [ ${SELECTED} -gt 0 ] && [ "${key}" == $'\033'[A ]; then
            SELECTED=$((${SELECTED}-1))
        elif [ ${SELECTED} -lt $((${#LIST[@]}-1)) ] && [ "${key}" == $'\033'[B ]; then
            SELECTED=$((${SELECTED}+1))
        fi
        printf "\033[${#LIST[@]}A"
    done

    printf "\033[${#LIST[@]}A"
    for IDX in ${!LIST[@]}; do
        printf "                                 \n"
    done
    printf "${CURON}\033[$((${#LIST[@]}+1))A"
    printf "${GR}${PROMPT} ${BL}${LIST[$SELECTED]}       \n"
    answer=${LIST[$SELECTED]}
}


trap "stty echo; printf '${CURON}${NC}\n'; exit" 2

projectName='Untitled'
author=''
projecType='Generic'
addons=()
serverType=''

printf "${WH}Welcome to the ASAPP Front-End Challenge\n\n"
printf "${NC}Let's get you setup for the challenge.\n\n"
printf "${YL}To begin, please answer the following questions:\n\n"

promptYN "Do you have any experience with React?"

if [ $answer == "Yes" ]; then
    projecType='React'
    printf "${NC}Great, let's get you setup with a React base project then.\n\n"
    list=("Redux" "MobX" "Other")
    promptList "Do you have experience with Redux, MobX or any other state management library?" "${list[@]}"

    if [ ! $answer == "Other" ]; then
        printf "${NC}Nice, we'll set ${answer} for you.\n          \n"
        addons+=($answer)
    else
        printf "${NC}Nice, we'll let you set that up.\n          \n"
    fi
    list=("SASS" "LESS" "Pure CSS" "Other")
    promptList "How about any experience with a CSS framework?" "${list[@]}"

    if [ ! $answer == "Other" ]; then
        printf "${NC}Okay, we'll set that up ${answer} for you too.\n          \n"
        addons+=($answer)
    else
        printf "${NC}Okay, we'll let you set that one up.\n          \n"
    fi

    promptYN "Do you want to build your own server? This is completely optional"
    if [ $answer == "Yes" ]; then
        list=("Node.JS" "Python" "Other")
        promptList "What server language are you most familiar with?" "${list[@]}"

        if [ ! $answer == "Other" ]; then
            printf "${NC}Great, we'll include ${answer} as the backend\n          \n"
            serverType=$answer
        else
            printf "${NC}Okay, you'll let you have to that up.\n          \n"
        fi
    fi

else
    list=("Angular" "Ember" "Other")
    promptList "That's okay, what JavaScript framework/library are familiar with?" "${list[@]}"
    if [ ! $answer == "Other" ]; then
        projecType=$answer
        printf "${GR}Okay, we can get you setup with an ${answer} base project\n         \n"
    else
        printf "${GR}We can setup you up with a generic NPM project, but you'll need to add your own components\n       \n"
    fi

fi

prompt "What would you like to call your project?"
projectName=$answer
prompt "What's your name?"
author=$answer


printf "${NC}Alright, give us a moment while we set up your project challenge...\n"

if [[ $projectType == "React" ]]; then
    sh -c "$(curl -fsSL ${BASEURL}/react.sh) \"$projectName\" \"$author\" \"$projectType\" \"${addons[@]} \"$serverType\""
elif [[ $projectType == "Angular" ]]; then
    sh -c "$(curl -fsSL ${BASEURL}/angular.sh) \"$projectName\" \"$author\" \"$projectType\""
elif [[ $projectType == "Ember" ]]; then
    sh -c "$(curl -fsSL ${BASEURL}/ember.sh) \"$projectName\" \"$author\" \"$projectType\""
else
    sh -c "$(curl -fsSL ${BASEURL}/generic.sh) \"$projectName\" \"$author\" \"$projectType\""
fi

node -e "$(curl -fsSL ${BASEURL}/package.js) \"$*\""

printf "${GN}You're all set to start the challenge.\n\n"
printf "${YL}To run the project type ${PK}\`npm start\`${NC}\n"
printf "${YL}When you're finished, run ${PK}\`npm run package\`${YL} to package your project to send to us.\n\n"
printf "Don't forget to update your README.md\n\n"
printf "Good Luck!\n\n"