#!/bin/bash

if [[ $(whoami) != root ]]; then
	echo "This script must be run with root privileges. Exiting..."
	exit 1
fi

if [[ -z $1 ]]; then
	echo "Missing argument. Exiting..."
	echo ""
	echo "Usage:"
	echo "  $(basename $0) <package_list>"
	exit 2
fi

PKG_LIST=$(cat $1 | sed -e 's/#.*$//' -e '/^$/d')


dnf install $PKG_LIST
#for i in $PKG_LIST; do
	#dnf install $i
#done
