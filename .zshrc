export ZSH="$HOME/.oh-my-zsh"
export PATH="/home/m1l0js/.cargo/bin:/usr/local/go/bin:/usr/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/home/m1l0js/.fzf/bin:/usr/local/go/bin:/usr/share/:/usr/sbin"
ZSH_THEME="robbyrussell"
plugins=(git)
source $ZSH/oh-my-zsh.sh

# plugins=(
# 	zsh-autosuggestions
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
	files=("acme-challenge" "ai-plugin.json" "amphtml" "apple-app-site-association" "apple-developer-merchantid-domain-association" "appspecific" "ashrae" "assetlinks.json" "atproto-did" "autoconfig/mail" "browserid" "brski" "caldav" "carddav" "change-password" "cmp" "coap" "com.apple.remotemanagement" "core" "csaf" "csaf-aggregator" "csvm" "dat" "did-configuration.json" "did.json" "discord" "dnt" "dnt-policy.txt" "dots" "ecips" "edhoc" "enterprise-network-security" "enterprise-transport-security" "est" "genid" "gpc" "gpc.json" "gs1resolver" "hoba" "host-meta" "host-meta.json" "hosting-provider" "http-opportunistic" "idp-proxy" "jmap" "keybase.txt" "knx" "looking-glass" "masque" "matrix" "mercure" "mta-sts.txt" "mud" "nfv-oauth-server-configuration" "ni" "nodeinfo" "nostr.json" "oauth-authorization-server" "ohttp-gateway" "open-resource-discovery" "openid-configuration" "openorg" "openpgpkey" "oslc" "pki-validation" "posh" "private-token-issuer-directory" "probing.txt" "pubvendors.json" "pvd" "rd" "related-website-set.json" "reload-config" "repute-template" "resourcesync" "sbom" "security.txt" "ssf-configuration" "sshfp" "statements.txt" "stun-key" "tdmrep.json" "thread" "time" "timezone" "tor-relay" "tpcd" "traffic-advice" "trust.txt" "uma2-configuration" "void" "webfinger" "webweaver.json" "wot" "xrp-ledger.toml" "robots.txt" "sitemap.xml" "humans.txt")
	# Iterate through each file in the array
    for file in "${files[@]}"; do
        echo -e "[+] Checking for ${file}"
        # Use curl to download the file
        curl -O -Ss "https://${target}/${file}"
		local filename=$(basename "${file}")
		if [ ! -s "$filename" ]; then
			#echo -e "[!] $filename is empty. Deleting the file."
			rm "$filename"
		elif grep -q '<title>Error 404 (Not Found)!!1</title>' "$filename"; then
           	#echo "[!] 404 error found in ${filename}. Deleting the file."
			rm "$filename"
       	fi
    done
}
