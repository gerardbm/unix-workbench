#!/usr/bin/env bash
# Author : Gerard Bajona
# Date   : 22/02/2019

subdirectories() {
	printf "Guessing Game in Bash\n\n"
	while read -r -p "Include subdirectories? [y/n] " subdirs; do
		if [[ "$subdirs" =~ ^([yY][eE][sS]|[yY])$ ]]; then
			numfiles=$(find . -not -type d -not -path '*/\.*' | wc -l)
			subdirsv="current directory and subdirectories:"
			printf "\033[32m%s \n\n\033[0m" "Ok, subdirectories included!"
			break;
		elif [[ "$subdirs" =~ ^([nN][oO]|[nN])$ ]]; then
			numfiles=$(find . -maxdepth 1 -not -type d -not -path '*/\.*' | wc -l)
			subdirsv="current directory only:"
			printf "\033[32m%s \n\n\033[0m" "Ok, subdirectories excluded!"
			break;
		else
			printf "\033[31m%s \n\033[0m" "Bad answer..."
		fi
	done
}

guessing() {
	printf "Guess the number of files of the %s\n\n" "$subdirsv"
	attempts=1
	while read -r -p "Attempt $attempts → Type a number: " answer; do
		if [[ "$answer" -lt "$numfiles" ]] 2>/dev/null; then
			printf "\033[33m%s \n\n\033[0m" "Too low!"
			attempts=$((attempts + 1))
		elif [[ "$answer" -gt "$numfiles" ]] 2>/dev/null; then
			printf "\033[33m%s \n\n\033[0m" "Too high!"
			attempts=$((attempts + 1))
		elif [ "$answer" -eq "$numfiles" ] 2>/dev/null; then
			printf "\033[32m%s \n\n\033[0m" "Congratulations! You win!"
			printf "Have a nice day ;-)\n"
			exit 0
		else
			printf "\033[31m%s \n\n\033[0m" "Bad answer..."
			attempts=$((attempts + 1))
		fi
	done
}

subdirectories
guessing
