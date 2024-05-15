#!/bin/bash

sudo apt update -y
sudo apt install python3 python3-pip seclists pipx  curl dnsrecon enum4linux feroxbuster gobuster impacket-scripts nbtscan nikto nmap onesixtyone oscanner redis-tools smbclient smbmap snmp sslscan sipvicious tnscmd10g whatweb wkhtmltopdf -y
sudo apt install python3-venv -y
python3 -m pip install --user pipx
python3 -m pipx ensurepath
pipx install git+https://github.com/Tib3rius/AutoRecon.git
