#/bin/bash

usage() {
	echo "usage: $0 [[[-e ] [-d]] | [-h]]"
}

enable_login() {
	echo "Enabling root login from SSH..."
	sed -i 's/#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config
	systemctl restart ssh
	echo "[OK]"
	exit
}

disable_login() {
	echo "Disabling root login from SSH..."
	sed -i 's/PermitRootLogin yes/#PermitRootLogin yes/' /etc/ssh/sshd_config
        systemctl restart ssh
	echo "[OK]"
	exit
}

##### Main
interactive=

if [ $# -eq 0 ]; then
	usage
	exit
fi

if [ $(id -u) != 0 ]; then
	echo "Being root is mandatory..."
	exit
fi

while [ "$1" != "" ]; do
	case $1 in
		-e | --enable ) enable_login ;;
		-d | --disable ) disable_login ;;
		-h | --help ) usage; exit ;;
	*) usage; exit 1
	esac
done	
