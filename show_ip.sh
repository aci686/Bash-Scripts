#!/bin/sh

#

__author__="Aaron Castro"
__author_email__="aaron.castro.sanchez@outlook.com"
__copyright__="Aaron Castro"
__license__="MIT"

usage() {
	echo "[I] Usage: $0 [-s | --show ] [-d | --device] [-h | --help]"
}

show_ifaces() {
	ip add | grep mtu | awk -F: '{print $2}' | awk '{$1=$1};1'
}

show_inet_address() {
	ip add show dev $1 | grep "inet" | grep -v "inet6" | awk '{print $2}' | awk -F'/' '{print $1}'
}

if [ $# -eq 0 ]; then
	usage
	exit
fi

while [ "$1" != "" ]; do
	case $1 in
		-s | --show ) show_ifaces; exit ;;
		-d | --device ) show_inet_address $2; exit ;;
		-h | --help ) usage; exit ;;
	*) usage; exit 1
	esac
done

ip add show dev $2 | grep "inet" | grep -v "inet6" | awk '{print $2}' | awk -F'/' '{print $1}'
