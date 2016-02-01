#!/bin/sh

check_public_ip(){
	#check if the number of argument is one.
	if [ "$#" -ne 1 ] 
	then
		echo "invalid function call" >/dev/stderr
		exit -1
	fi
	
	#fetch the ip addr from a web service
	pubip=$(curl $1 2>/dev/null)
	
	#check the IP if it is valid
	if [[ $pubip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]
	then
		:
	else
		pubip="badip"
	fi
	
	#report the public ip result
	echo "$pubip $1"
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
check_public_ip curlmyip.com

#check IPv6
#check_public_ip v6.ident.me
#check_public_ip ipv6.icanhazip.com



