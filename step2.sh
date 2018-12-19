#!/bin/bash

# create lxc containers for ONOS

onos/onos-lxc.sh

# install ONOS

onos/onos-install.sh

# copy lxc-related scripts to HOME

cp bin/* ~

# build an ONOS package

cd ~
onos-package

# push SSH keys

onos-push-keys $OC1
onos-push-keys $OC2
onos-push-keys $OC3

# add onos configurations to the configuration of each containter

cat ~/lxc-controller/onos/lxc/onos1 | sudo tee -a /var/lib/lxc/onos1/config
cat ~/lxc-controller/onos/lxc/onos2 | sudo tee -a /var/lib/lxc/onos2/config
cat ~/lxc-controller/onos/lxc/onos3 | sudo tee -a /var/lib/lxc/onos3/config

# start ONOS containers

~/lxc-start.sh

# do things in manual

echo
echo "Attach to each onos instance (~/lxc-attach.sh onos{1,2,3})"
echo "Add 'ubuntu ALL=NOPASSWD:ALL' at the end of /etc/sudoers"
echo "Install Oracle Java 8 (see ~/lxc-controller/onos/java-install.sh)"
echo
echo "$ stc teardown"
echo "$ stc setup"
echo
