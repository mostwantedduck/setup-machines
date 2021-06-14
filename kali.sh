#!/bin/bash

sudo apt -y update
sudo apt -y install iptables-persistent netfilter-persistent python3-pip steghide rlwrap exiftool jq nim

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

sudo git clone --recurse-submodules https://github.com/ZeroPointSecurity/Covenant.git /opt/Covenant
sudo git clone https://github.com/rbsec/dnscan.git /opt/dnscan
sudo git clone https://github.com/chinarulezzz/spoofcheck /opt/spoofcheck; cd /opt/spoofcheck; sudo pip3 install -r requirements.txt
sudo git clone https://gist.github.com/superkojiman/11076951 /opt/namemash; sudo chmod +x /opt/namemash/namemash.py
sudo git clone https://github.com/byt3bl33d3r/SprayingToolkit.git /opt/SprayingToolkit; cd /opt/SprayingToolkit; sudo pip3 install -r requirements.txt
sudo git clone https://github.com/FortyNorthSecurity/Egress-Assess.git /opt/Egress-Assess
sudo git clone https://github.com/pentestmonkey/windows-privesc-check /opt/windows-privesc-check
sudo git clone https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite /opt/privilege-escalation-awesome-scripts-suite
sudo git clone https://github.com/AonCyberLabs/Windows-Exploit-Suggester /opt/Windows-Exploit-Suggester
sudo git clone https://github.com/mzet-/linux-exploit-suggester /opt/linux-exploit-suggester
sudo git clone https://github.com/jondonas/linux-exploit-suggester-2 /opt/linux-exploit-suggester-2
sudo git clone https://github.com/PowerShellMafia/PowerSploit /opt/PowerSploit
sudo git clone https://github.com/internetwache/GitTools /opt/GitTools
sudo git clone https://github.com/maurosoria/dirsearch /opt/dirsearch
sudo git clone https://github.com/rebootuser/LinEnum /opt/LinEnum
sudo git clone https://github.com/diego-treitos/linux-smart-enumeration /opt/linux-smart-enumeration
sudo git clone https://github.com/byt3bl33d3r/OffensiveNim.git /opt/OffensiveNim
sudo git clone https://github.com/samratashok/nishang.git /opt/nishang
sudo git clone https://github.com/phra/PEzor.git /opt/PEzor
sudo git clone https://github.com/3gstudent/Worse-PDF.git /opt/Worse-PDF
sudo git clone https://github.com/dafthack/MailSniper.git /opt/MailSniper
sudo git clone https://github.com/fox-it/BloodHound.py.git /opt/BloodHound.py
sudo git clone https://github.com/quentinhardy/msdat.git /opt/msdat
sudo git clone https://github.com/infosecn1nja/MaliciousMacroMSBuild.git /opt/MaliciousMacroMSBuild
sudo git clone https://github.com/FSecureLABS/wePWNise /opt/wePWNise
sudo git clone https://github.com/BloodHoundAD/BloodHound.git /opt/BloodHound
sudo git clone https://github.com/NetSPI/PowerUpSQL.git /opt/PowerUpSQL

sudo curl https://github.com/jpillora/chisel/releases/download/v1.7.6/chisel_1.7.6_linux_amd64.gz -o /opt/binaries
sudo curl https://github.com/jpillora/chisel/releases/download/v1.7.6/chisel_1.7.6_windows_amd64.gz -o /opt/binaries
sudo curl https://github.com/DominicBreuker/pspy/releases/download/v1.2.0/pspy32 -o /opt/binaries
sudo curl https://github.com/DominicBreuker/pspy/releases/download/v1.2.0/pspy64 -o /opt/binaries
sudo curl https://github.com/gentilkiwi/mimikatz/releases/download/2.2.0-20210531/mimikatz_trunk.zip -o /opt/binaries

sudo gem install evil-winrm

sudo systemctl enable ssh.service

sudo reboot
