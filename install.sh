#!/bin/bash
#Instagram: @bhikan_deshmukh
#Creadit: github.com/thelinuxchoice

trap 'echo exiting cleanly...; exit 1;' SIGINT SIGTSTP

checkroot() {
    if [[ "$(id -u)" -ne 0 ]]; then
        printf "\e[1;77mPlease, run this program as root!\n\e[0m"
        exit 1
    fi
}

install_package() {
    package=$1
    if ! command -v "$package" > /dev/null 2>&1; then
        printf "\e[1;92mInstalling %s, please wait...\n\e[0m" "$package"
        apt-get update > /dev/null
        if apt-get -y install "$package" > /dev/null; then
            printf "\e[1;92m%s installed successfully!\n\e[0m" "$package"
        else
            printf "\e[1;91m%s could not be installed. Please install it manually.\n\e[0m" "$package"
            exit 1
        fi
    else
        printf "\e[1;92m%s is already installed.\n\e[0m" "$package"
    fi
}

# Check if running as root
checkroot

# Install required packages
install_package tor
install_package openssl
install_package curl

printf "\e[1;92mAll requirements are installed!\n\e[0m"