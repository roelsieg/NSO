#!/bin/bash
#
# Remove reference to obsolete PuppetLabs repository
# Update to latest release
#
cat <<EOM
NSO installation script
==================================
This script updates your system, installs additional APT and PIP
packages, and installs NSO (possibly with SAE)
The script was adapted for and tested on Ubuntu 20.04. Do not use it
on earlier versions of Ubuntu. Within this repo this means using:
'ansible.vm.box = "ubuntu/focal64"'in the Vagrantfile
NOTE: the script is set to abort on first error. If the installation
completed you're probably OK even though you might have seen errors
during the installation process.
==================================
EOM
set -e
#
# Comment the next line if you want to have verbose installation messages
#
QUIET="-qq"
REPLACE="--ignore-installed --upgrade"
echo "Update installed software to latest release (might take a long time)"
sudo apt-get $QUIET update
#
# Install missing packages
#
echo "Install missing packages (also a pretty long operation)"
sudo apt-get $QUIET install python-setuptools ifupdown python3-pip >/dev/null
echo "Install nice-to-have packages"
sudo apt-get $QUIET install git ack-grep jq tree sshpass colordiff >/dev/null
# Install some NSO needed packages
echo "Install NSO missing packages"
sudo apt-get $QUIET install ant xsltproc >/dev/null
#
# Install Ansible and NAPALM dependencies
#
echo "Install Python development and build modules"
sudo apt-get $QUIET install build-essential python3-dev libffi-dev >/dev/null
sudo apt-get $QUIET install python
#
# Install Python components
#
echo "Install baseline Python components"
sudo pip3 install $REPLACE $QUIET pyyaml httplib2 pysnmp
sudo pip3 install $REPLACE $QUIET jinja2 six bracket-expansion netaddr
#
#
echo "Install optional Python components"
sudo pip3 install $REPLACE $QUIET yamllint textfsm jmespath jxmlease jinja2

echo "Install SAE Python dependencies"
echo ".. paramiko netmiko"
sudo pip3 install $QUIET paramiko
sudo pip3 install $QUIET netmiko
echo ".. future requests"
sudo pip3 install $QUIET future
sudo pip3 install $QUIET requests

# Make sure that the file "nso-5.3.linux.x86_64.signed.bin" is place in the provision folder
# sh provision/nso-5.3.linux.x86_64.signed.bin --skip-verification
sh provision/nso-5.5.linux.x86_64.signed.bin --skip-verification
# sh nso-5.3.linux.x86_64.installer.bin $HOME/nso-5.3
# sh nso-5.3.linux.x86_64.installer.bin /opt/ncs
sh nso-5.5.linux.x86_64.installer.bin /opt/ncs
# source $HOME/nso-5.3/ncsrc
# ncs-setup --dest $HOME/ncs-run
# cd $HOME/ncs-run/
source /opt/ncs/ncsrc
# Install SAE (download not available)
# tar -xvf provision/nso-5.2.3.6-cisco-sae-core-fp-2.2.0.tar.gz /provision
# provision/nso-5.2.3.6-cisco-sae-core-fp-2.2.0/local-install/local-install.sh /opt/ncs

ncs-setup --dest /opt/ncs-run
# cd /opt/ncs-run/
cd /opt/ncs/examples.ncs/datacenter/datacenter
make stop clean all start
# ncs version installed
ncs --version
# /opt/ncs/bin/ncs_cli -u admin
# http://127.0.0.1:8080/login.html
