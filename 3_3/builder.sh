#!/bin/sh

if [ "$#" -ne 2 ]; then
	echo "Usage: ./builder.sh <github-repo> <docker-image>"
	exit 1
elif [ "$1" != "" ]; then
	echo "Cloning the repository ...."
	git clone "https://github.com/$1.git"
	if [ $? -ne 0 ]; then
		echo "Failed to clone repository"
		exit 1
	else
		echo "Repository cloned successfully into $(basename "$1" .git)"
		cd "$(basename "$1" .git)"
		docker login
		docker build -t "$2" .
		if [ $? -ne 0 ]; then
			echo "Failed to build Docker image"
			exit 1
		else
			echo "Docker image built successfully"
			echo "Pushing Docker image to docker hub..."
			docker push "$2"
			if [ $? -ne 0 ]; then
				echo "Failed to push Docker image"
				exit 1
			else
				echo "Docker image pushed successfully"
			fi
			echo "Build and push process completed successfully"
		fi
	fi

else 
	echo "please try again"
fi
