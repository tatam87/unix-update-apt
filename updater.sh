#!/bin/bash
declare -a servers=("place" "your" "hosts" "here");
read -p 'If you want to update all mpass servers press 1, for specific server press 2: ' connection
if [ $connection == 1 ] ;
	then
	echo "----------------"
	printf "\033[0;33mWarning!!! This script will update the os system\033[0m\n"
	printf "Username:\t\t$USER\n"
	read -p 'Please provide the user of the remote hosts: ' remoteuser
	echo "----------------"
	read -p 'Please provide the remote ssh port: ' sshport
	for i in ${servers[@]}
		do 
		read -p "Do you want to skip $i (y/n): " skip 
		# skipfilled = ${skip:=y}
		echo "----------------"
		if [ ${skip:=y} == 'y' ] ; then 
			continue
		fi
		echo "----------------"
		echo "You are about to update: $i"
		echo "----------------"
		ssh "${remoteuser:=ubuntu}"@"$i" -p"${sshport:=22}" "sudo apt-get update && sudo apt-get dist-upgrade -y && sudo apt-get autoremove -y && sudo apt-get autoclean && exit"
	done
	printf "all done\n"
elif [ $connection == 2 ] ; 
	then 
	echo "----------------"
	read -p 'Please provide the hostname you want to connect: ' hostname
	echo "----------------"
	read -p 'Please provide the username of the host you want to connect: ' remoteuser
	echo "----------------" 
	read -p 'Please provide wich port to try connection for SSH: ' sshport
	ssh -tt "${remoteuser:=ubuntu}"@$hostname -p"${sshport:=22}" "sudo apt-get update && sudo apt-get dist-upgrade -y && sudo apt-get autoremove -y && sudo apt-get autoclean && exit"
	echo "----------------"
	printf "all done\n"
else
	echo "Not a valid choice. Now exiting"
fi
