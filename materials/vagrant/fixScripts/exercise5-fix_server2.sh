#!/bin/bash
#add fix to exercise5-server2 here
#Server2 Fix
sudo sed -i '$a\    StrictHostKeyChecking no' /etc/ssh/ssh_config
sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sudo systemctl restart sshd
runuser -l vagrant -c "ssh-keygen -t rsa -N '' -f ~/.ssh/id_rsa"
sudo apt update && sudo apt install sshpass -y
sshpass -p vagrant ssh-copy-id -i /home/vagrant/.ssh/id_rsa vagrant@192.168.60.10
#Server1 Fix 
runuser -l vagrant -c "ssh vagrant@192.168.60.10 'sudo apt install sshpass -y'"
runuser -l vagrant -c "ssh vagrant@192.168.60.10 'sshpass -p vagrant ssh-copy-id -i /home/vagrant/.ssh/id_rsa vagrant@192.168.60.11'"