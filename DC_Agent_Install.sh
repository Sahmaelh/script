#!/bin/bash

#==============================================================================
#title           : DC_agent_install.sh
#description     : Install Desktop Central Agent / SentinelOne for Linux Distrib
#author		     : Michael Lelon
#date            : 19/11/2021
#version         : 0.2-beta    
#usage		     : bash DC_agent_install.sh
#notes           : Install cifs-utils, unzip, desktopcentral agent, sentinelone agent.
#==============================================================================
 
# Search which distrib need to be used

declare -A osInfo;
osInfo[/etc/debian_version]="apt-get install -y"
osInfo[/etc/alpine-release]="apk --update add"
osInfo[/etc/centos-release]="yum install -y"
osInfo[/etc/fedora-release]="dnf install -y"

for f in ${!osInfo[@]}
do
    if [[ -f $f ]];then
        package_manager=${osInfo[$f]}
    fi
done

# Install cifs-utils for copy linux agent from a Share Server to Local

package="cifs-utils"

${package_manager} ${package}

# Install unzip if it's not basic install

package="unzip"

${package_manager} ${package}

# Mount the sharetemp | Attention you need to know the password of the account that's used to connect the Windows Share Server to the linux
# if you don't know the account password, you need to change the user account
# the user account need access to the share too ;)

sudo mount.cifs //server.intra/source$ /mnt/share -o user=user dom=test.intra ver=3.0

# Create a directory for copy the Desktop Central agent to local linux server

mkdir /home/sources

# Copy the desktopcentral and sentinelone to the directory

cp /mnt/share/DCLinuxAgent.zip /home/sources/DCLinuxAgent.zip
cp /mnt/share/SentinelOne/SentinelAgent_linux_v21_7_3_6.rpm /home/sources/SentinelAgent_linux_v21_7_3_6.rpm
cp /mnt/share/SentinelOne/token.txt /home/sources/token.txt

# Unmount the Share server

umount /mnt/share

# Unzip the file DCLinuxAgent.zip (Desktop Central Agent Linux)

unzip -e DCLinuxAgent.zip

# Change the permissions for the installer file

chmod +x /home/sources/DesktopCentral_LinuxAgent.bin

# Install the Desktop Central Agent

cd /home/sources
./DesktopCentral_LinuxAgent.bin

# Install SentinelOne Linux Agent

rpm -i --nodigest /home/sources/SentinelAgent_linux_v21_7_3_6.rpm

# Associate agent with console by providing the site token

site_token=$(<token.txt)
sudo /opt/sentinelone/bin/sentinelctl management token set $site_token
sudo /opt/sentinelone/bin/sentinelctl control start
sudo systemctl enable sentinelone