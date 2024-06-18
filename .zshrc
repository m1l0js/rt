export ZSH="$HOME/.oh-my-zsh"
export PATH="/home/m1l0js/.cargo/bin:/usr/local/go/bin:/usr/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/home/m1l0js/.fzf/bin:/usr/local/go/bin:/usr/share/:/usr/sbin"
ZSH_THEME="robbyrussell"
plugins=(git)
source $ZSH/oh-my-zsh.sh

# plugins=(
#       zsh-autosuggestions
# )

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/sudo/sudo.plugin.zsh
source ~/.zsh/zsh-vim/zsh-vi-mode.plugin.zsh
source ~/.zsh/zsh-autocomplete/zsh-autocomplete.plugin.zsh

# Manual aliases
alias cat='batcat -l java'
alias ll='lsd -lh --group-dirs=first'
alias la='lsd -a --group-dirs=first'
alias l='lsd --group-dirs=first'
alias lla='lsd -lha --group-dirs=first'
alias ls='lsd --group-dirs=first'

# Functions
function mkt(){
    mkdir {nmap,content,exploits,scripts}
}

# Extract nmap information
function extractPorts(){
    ports="$(cat $1 | grep -oP '\d{1,5}/open' | awk '{print $1}' FS='/' | xargs | tr ' ' ',')"
    ip_address="$(cat $1 | grep -oP '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}' | sort -u | head -n 1)"
    echo -e "\n[*] Extracting information...\n" > extractPorts.tmp
    echo -e "\t[*] IP Address: $ip_address"  >> extractPorts.tmp
    echo -e "\t[*] Open ports: $ports\n"  >> extractPorts.tmp
    echo $ports | tr -d '\n' | xclip -sel clip
    echo -e "[*] Ports copied to clipboard\n"  >> extractPorts.tmp
    cat extractPorts.tmp; rm extractPorts.tmp
}
function rmk(){
    scrub -p dod $1
    shred -zun 10 -v $1
}

# Created by `pipx` on 2024-06-04 16:50:30
export PATH="$PATH:/home/s1mb4js/.local/bin"

function install_some_go_tools(){
        go install -v github.com/tomnomnom/anew@latest
}

function install_chisel(){
        git clone https://github.com/jpillora/chisel
        cd chisel
        go build -ldflags "-s -w" .
        upx brute chisel
        mv chisel chisel_file
        cp chisel_file ../
        cd ..
        rm -rf chisel/
        mv chisel_file chisel
        echo -e "[+] Chisel for linux ready"
        wget https://github.com/jpillora/chisel/releases/download/v1.9.1/chisel_1.9.1_windows_amd64.gz
        gunzip -d chisel_1.9.1_windows_amd64.gz
        mv chisel_1.9.1_windows_amd64 chisel.exe
        echo -e "[+] Chisel for windows ready"
        ls -la | grep "chisel"
        file chisel*
        du -hs chisel*
}


function first_scan(){
        if [ -z "$1" ]; then
                echo -e "Error"
                return 1
        fi
        local ip="$1"
        nmap -n -Pn -sS --min-rate 200 -p- --open -vvv  -oG all_ports $ip
        ports="$(cat all_ports | grep -oP '\d{1,5}/open' | awk '{print $1}' FS='/' | xargs | tr ' ' ',')"
        ip="$(cat all_ports | grep -oP '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}' | sort -u | head -n 1)"
        echo -e "\n[*] Extracting information...\n" > extractPorts.tmp
        echo -e "\t[*] IP Address: $ip"  >> extractPorts.tmp
        echo -e "\t[*] Open ports: $ports\n"  >> extractPorts.tmp
        echo $ports | tr -d '\n' | xclip -sel clip
        echo -e "[*] Ports copied to clipboard\n"  >> extractPorts.tmp
        cat extractPorts.tmp; rm extractPorts.tmp
        nmap -n -Pn -sCV -vvv -oN targeted -p $ports $ip
}

function install_winpeas(){
        wget https://github.com/peass-ng/PEASS-ng/releases/download/20240609-52b58bf5/winPEASx64.exe
        mv winPEASx64.exe win.exe
}

function basic_web_gathering(){
        if [ -z "$1" ]; then
                echo -e "Error. No argument provided"
                return 1
        fi
        local target="$1"
        echo -e "[+] Checking for robots.txt"
        curl -O -Ss https://$1/robots.txt
        echo -e "[+] Checking for sitemap.xml"
        curl -O -Ss https://$1/sitemap.xml
        echo -e "[+] Checking for security.txt"
        curl -O -Ss https://$1/security.txt
        curl -O -Ss https://$1/.well-known/security.txt
}
