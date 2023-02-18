#!/bin/bash

sudo apt-get update

sudo apt install openvpn easy-rsa

sudo make-cadir /etc/openvpn/easy-rsa

cd /etc/openvpn/easy-rsa

sudo ./easyrsa init-pki

sudo ./easyrsa build-ca

sudo ./easyrsa gen-req myservername nopass

sudo ./easyrsa gen-dh

sudo ./easyrsa gen-req myservername nopass

sudo ./easyrsa sign-req server myservername

cp pki/dh.pem pki/ca.crt pki/issued/myservername.crt pki/private/myservername.key /etc/openvpn/

sudo ./easyrsa gen-req myclient1 nopass

sudo ./easyrsa sign-req client myclient1

pki/ca.crt

pki/issued/myclient1.crt

sudo cp /usr/share/doc/openvpn/examples/sample-config-files/server.conf.gz /etc/openvpn/myserver.conf.gz

sudo gzip -d /etc/openvpn/myserver.conf.gz