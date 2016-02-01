#!/bin/bash

check_public_ip(){
	# check if the number of argument is one.
	if [ "$#" -ne 1 ] 
	then
		echo "invalid function call" >/dev/stderr
		exit -1
	fi
	
	# fetch the ip addr from a web service
	pubip=$(curl $1 2>/dev/null)
	
	# check the IP if it is valid
	if [[ $pubip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]
	then
		:
	else
		pubip="badip-"$pubip
	fi
	
	# report the public ip result
	echo "$pubip $1"
}

# set a variable that the delimiter is a space
public_ip_web="
ipecho.net/plain
icanhazip.com
ipv4.icanhazip.com
ident.me
v4.ident.me
http://smart-ip.net/myip
whatismyip.akamai.com
tnx.nl/ip
myip.dnsomatic.com
ip.appspot.com
curlmyip.com "

# It is necessary to export the bash function
# parallel is to build and execute shell command lines from stdin in parallel
echo $helloworld
export -f check_public_ip
echo $public_ip_web| parallel -d " " check_public_ip {} 2>/dev/null

# check IPv6
# check_public_ip v6.ident.me
# check_public_ip ipv6.icanhazip.com



