#!/bin/sh

if [ "$#" -ne 2 ]; then
	echo "Usage: ./builder.sh <github-repo> <docker-image>"
	exit 1
elif [ "$1" != "" ]; then
	echo "Cloning the repository ...."
	git clone "$1"
	if [ $? -ne 0 ]; then
		echo "Failed to clone repository"
		exit 1
	else
		echo "Repository cloned successfully into $(basename "$1" .git)"
		cd "$(basename "$1" .git)"
	fi

else 
	echo "please try again"
fi
