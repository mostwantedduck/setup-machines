#!/bin/bash

sudo apt -y update
sudo apt -y install iptables-persistent netfilter-persistent python3-pip steghide rlwrap exiftool jq nim python3-virtualenv libxml2-dev libxslt1-dev

sudo systemctl disable network-manager.service
echo -en "\n\nauto eth0\niface eth0 inet dhcp\nauto eth1\niface eth1 inet static\n\taddress 192.168.10.100\n\tnetmask 255.255.255.0" | sudo tee -a /etc/network/interfaces
sudo service networking restart

sudo sed -i "s/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g" /etc/sysctl.conf

sudo iptables -t nat -A POSTROUTING -o tun0 -j MASQUERADE
sudo netfilter-persistent save
sudo systemctl enable netfilter-persistent.service

wget -q https://packages.microsoft.com/config/ubuntu/19.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo apt -y update
sudo apt -y install apt-transport-https
sudo apt -y update
sudo apt -y install dotnet-sdk-3.1 dnsutils
rm packages-microsoft-prod.deb

# CHANGE IT
sudo chown -R daniel:daniel /opt

git clone --recurse-submodules https://github.com/ZeroPointSecurity/Covenant.git /opt/Covenant
git clone https://github.com/rbsec/dnscan.git /opt/dnscan
git clone https://github.com/chinarulezzz/spoofcheck /opt/spoofcheck
git clone https://gist.github.com/superkojiman/11076951 /opt/namemash; sudo chmod +x /opt/namemash/namemash.py
git clone https://github.com/byt3bl33d3r/SprayingToolkit.git /opt/SprayingToolkit
git clone https://github.com/FortyNorthSecurity/Egress-Assess.git /opt/Egress-Assess
git clone https://github.com/pentestmonkey/windows-privesc-check /opt/windows-privesc-check
git clone https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite /opt/privilege-escalation-awesome-scripts-suite
git clone https://github.com/AonCyberLabs/Windows-Exploit-Suggester /opt/Windows-Exploit-Suggester
git clone https://github.com/mzet-/linux-exploit-suggester /opt/linux-exploit-suggester
git clone https://github.com/jondonas/linux-exploit-suggester-2 /opt/linux-exploit-suggester-2
git clone https://github.com/PowerShellMafia/PowerSploit /opt/PowerSploit
git clone https://github.com/internetwache/GitTools /opt/GitTools
git clone https://github.com/maurosoria/dirsearch /opt/dirsearch
git clone https://github.com/rebootuser/LinEnum /opt/LinEnum
git clone https://github.com/diego-treitos/linux-smart-enumeration /opt/linux-smart-enumeration
git clone https://github.com/byt3bl33d3r/OffensiveNim.git /opt/OffensiveNim
git clone https://github.com/samratashok/nishang.git /opt/nishang
git clone https://github.com/phra/PEzor.git /opt/PEzor
git clone https://github.com/3gstudent/Worse-PDF.git /opt/Worse-PDF
git clone https://github.com/dafthack/MailSniper.git /opt/MailSniper
git clone https://github.com/fox-it/BloodHound.py.git /opt/BloodHound.py
git clone https://github.com/quentinhardy/msdat.git /opt/msdat
git clone https://github.com/infosecn1nja/MaliciousMacroMSBuild.git /opt/MaliciousMacroMSBuild
git clone https://github.com/FSecureLABS/wePWNise /opt/wePWNise
git clone https://github.com/BloodHoundAD/BloodHound.git /opt/BloodHound
git clone https://github.com/NetSPI/PowerUpSQL.git /opt/PowerUpSQL

mkdir /opt/binaries

curl https://github.com/jpillora/chisel/releases/download/v1.7.6/chisel_1.7.6_linux_amd64.gz -o /opt/binaries/chisel_1.7.6_linux_amd64.gz
curl https://github.com/jpillora/chisel/releases/download/v1.7.6/chisel_1.7.6_windows_amd64.gz -o /opt/binaries/chisel_1.7.6_windows_amd64.gz
curl https://github.com/DominicBreuker/pspy/releases/download/v1.2.0/pspy32 -o /opt/binaries/pspy32
curl https://github.com/DominicBreuker/pspy/releases/download/v1.2.0/pspy64 -o /opt/binaries/pspy64
curl https://github.com/gentilkiwi/mimikatz/releases/download/2.2.0-20210531/mimikatz_trunk.zip -o /opt/binaries/mimikatz_trunk.zip


tee -a /opt/update-repos.sh > /dev/null <<EOT
#! /usr/bin/env bash
find /opt -type d -depth 1 -exec echo git --git-dir={}/.git --work-tree=$PWD/{} status \;
EOT

chmod +x /opt/update-repos.sh

sudo gem install evil-winrm

sudo systemctl enable ssh.service

cd /opt/SprayingToolkit
sudo virtualenv -p /usr/bin/python venv
source venv/bin/activate
sudo pip3 install -r requirements.txt

cd /opt/spoofcheck
sudo virtualenv -p /usr/bin/python venv
source venv/bin/activate
sudo pip3 install -r requirements.txt

reboot
