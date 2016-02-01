#!/bin/sh

check_public_ip(){
    echo "check public IP by site:$1"
    curl $1
    echo "\n--------------------------------\n"
}

check_public_ip ipecho.net/plain
check_public_ip icanhazip.com
check_public_ip ipv4.icanhazip.com
check_public_ip ident.me
check_public_ip v4.ident.me
check_public_ip http://smart-ip.net/myip
check_public_ip whatismyip.akamai.com
check_public_ip tnx.nl/ip
check_public_ip myip.dnsomatic.com
check_public_ip ip.appspot.com
check_public_ip ip.telize.com
check_public_ip curlmyip.com


#check IPv6
#check_public_ip v6.ident.me
#check_public_ip ipv6.icanhazip.com



