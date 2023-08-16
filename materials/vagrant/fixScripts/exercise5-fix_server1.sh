#!/bin/bash
#add fix to exercise5-server1 here
sudo sed -i '$a\    StrictHostKeyChecking no' /etc/ssh/ssh_config
runuser -l vagrant -c "ssh-keygen -t rsa -N '' -f ~/.ssh/id_rsa"