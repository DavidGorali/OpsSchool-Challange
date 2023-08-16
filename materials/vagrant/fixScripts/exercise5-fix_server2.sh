#!/bin/bash
#add fix to exercise5-server2 here
#Server2 Fix
sudo sed -i '$a\    StrictHostKeyChecking no' /etc/ssh/ssh_config
runuser -l vagrant -c "ssh-keygen -t rsa -N '' -f ~/.ssh/id_rsa"
sudo apt update && sudo apt install sshpass -y
sshpass -p vagrant ssh-copy-id -i /home/vagrant/.ssh/id_rsa vagrant@server1
#Server1 Fix 
runuser -l vagrant -c "ssh vagrant@server1 'sudo apt install sshpass -y'"
runuser -l vagrant -c "ssh vagrant@server1 'sshpass -p vagrant ssh-copy-id -i /home/vagrant/.ssh/id_rsa vagrant@server2'"