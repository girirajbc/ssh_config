#!/bin/bash
#SSH config - script to add a new host

clear

#Assign the exit status of cat to the check variable, for use in IF statement
cat $HOME/.ssh/config > /dev/null
check=$?

#If ssh config exists, echo start message and continue script. Else, print error message and exit script
if [ ${check} == 0 ]; then
	clear
	echo "Let's add another host to your ssh config file"
else
	clear
	echo "You do not have an ssh config file yet. Create one and rerun this script."
	sleep 2
	clear
	exit 1
fi

#Main script - User Input-------------------------------------------------------

#Ask the user to input the ssh host alias
#You must enter a new name before this variable will be output to any files
read -p "Enter the host name alias: " sshalias
sshalias=${sshalias}
grep -q ${sshalias} $HOME/.ssh/config
check=$? # this assigns the exit code of grep, for use in while loop

#Check the results of grep, if we found that name already exists (grep exit code 0) then we request a new name until the user provides something unique 
while [ ${check} == 0 ]; do
	read -p "Enter the host name alias (It must be new): " sshalias
	sshalias=${sshalias}
	grep -q ${sshalias} $HOME/.ssh/config
	check=$? 
done

#Ask the user for the IP adress of the ssh host
#Be mindful that there are no validity checks here
read -p "Enter IP address or host name: " sshaddress
sshaddress=${sshaddress}

#Ask the user for the ssh port of the new host
#The default is 22, if no vlaue is given, default is used
#If input is given, the default will not be used
#Be mindful that there are no validity checks here
read -p "Enter the ssh port [22]: " sshport
sshport=${sshport:-22}

#Ask the user for the log in user name for the new host
#Be mindful that there are no validity checks here
read -p "Enter the ssh user name: " sshuser
sshuser=${sshuser}

#Confirmation from user and write out to files----------------------------------

#Print out the values that will be added to the config files and ask for confirmation
echo "The following will be added to your ssh config file:"
echo -e "Host ${sshalias}\nHostName $sshaddress\nPort ${sshport}\nUser ${sshuser}\n"
read -p "Is this information correct? Y/N: " confirmation
writeconf=${confirmation}

#Check confirmation input, if y then write new changes out to ssh config
if [ "${writeconf}" == "y" ]; then
	#Make a copy of the current file before we start making additions
	cp $HOME/.ssh/config $HOME/.ssh/config.bak
	#echo out the new host information
	echo -en '\n' >> $HOME/.ssh/config
	echo "Host ${sshalias}" >> $HOME/.ssh/config
	echo -e "\tHostName ${sshaddress}" >> $HOME/.ssh/config
	echo -e "\tPort ${sshport}" >> $HOME/.ssh/config
	echo -e "\tUser ${sshuser}" >> $HOME/.ssh/config
	#Confirm the new host was added 
	echo -e "\nNew host added to ssh config!"
	sleep 2
	clear
else
	echo -e "\nDropping changes. Please run this script again to add new hosts."
	sleep 2
	clear
fi

exit 0

