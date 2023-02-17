#cloud-config
debug:
 verbose: true
cloud_init_modules:
- migrator
- seed_random
- write-files
- growpart
- resizefs
- set_hostname
- update_hostname
- update_etc_hosts
- users-groups
- ssh
- runcmd
- write_files
users:
 - name: "ubuntu"
 sudo: ['ALL=(ALL) NOPASSWD:ALL']
 groups: sudo
 shell: /bin/bash
 ssh_authorized_keys:
 - "${public_key}"
 expire: False
disable_root: true
timezone: "Europe/Moscow"
package_update: false
manage_etc_hosts: localhost
fqdn: "${hostname}"
runcmd:
- sudo apt-get -y update
- git clone https://github.com/arcegor/jupyter
- chmod 777 virtual/startHub.sh
- sudo bash ./virtual/startHub.sh