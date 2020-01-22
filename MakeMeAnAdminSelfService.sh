{\rtf1\ansi\ansicpg1252\cocoartf2511
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\margl1440\margr1440\vieww26380\viewh14980\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 #!/bin/bash\
\
###############################################\
# This script will provide temporary admin    #\
# rights to a standard user right from self   #\
# service. First it will grab the username of #\
# the logged in user, elevate them to admin   #\
# and then create a launch daemon that will   #\
# count down from 30 minutes and then create  #\
# and run a secondary script that will demote #\
# the user back to a standard account. The    #\
# launch daemon will continue to count down   #\
# no matter how often the user logs out or    #\
# restarts their computer.         #\
#                                               #\
# Originally written by Jamf.  Edited code to use $4 #\
# and to display the amount of minutes back to the user. #\
# This will allow you to change $4 and make it any amount #\
# of time and the user will see the minutes automatically    #\
###############################################\
\
#############################################\
# find the logged in user and let them know #\
#############################################\
\
currentUser=$(who | awk '/console/\{print $1\}')\
echo $currentUser\
\
osascript \\\
  -e "on run(argv)" \\\
  -e 'display dialog "You now have administrative rights for " & item 1 of argv & " minutes. DO NOT ABUSE THIS PRIVILEGE..." buttons \{"Make me an admin, please"\} default button 1' \\\
  -e "end" \\\
  -- "$(($4 / 60))"\
  \
#########################################################\
# write a daemon that will let you remove the privilege #\
# with another script and chmod/chown to make 			#\
# sure it'll run, then load the daemon					#\
#########################################################\
\
#Create the plist\
sudo defaults write /Library/LaunchDaemons/removeAdmin.plist Label -string "removeAdmin"\
\
#Add program argument to have it run the update script\
sudo defaults write /Library/LaunchDaemons/removeAdmin.plist ProgramArguments -array -string /bin/sh -string "/Library/Application Support/JAMF/removeAdminRights.sh"\
\
#Set the run inverval to run every 7 days\
sudo defaults write /Library/LaunchDaemons/removeAdmin.plist StartInterval -integer $4\
\
#Set run at load\
sudo defaults write /Library/LaunchDaemons/removeAdmin.plist RunAtLoad -boolean yes\
\
#Set ownership\
sudo chown root:wheel /Library/LaunchDaemons/removeAdmin.plist\
sudo chmod 644 /Library/LaunchDaemons/removeAdmin.plist\
\
#Load the daemon \
launchctl load /Library/LaunchDaemons/removeAdmin.plist\
sleep 10\
\
#########################\
# make file for removal #\
#########################\
\
if [ ! -d /private/var/userToRemove ]; then\
	mkdir /private/var/userToRemove\
	echo $currentUser >> /private/var/userToRemove/user\
	else\
		echo $currentUser >> /private/var/userToRemove/user\
fi\
\
##################################\
# give the user admin privileges #\
##################################\
\
/usr/sbin/dseditgroup -o edit -a $currentUser -t user admin\
\
########################################\
# write a script for the launch daemon #\
# to run to demote the user back and   #\
# then pull logs of what the user did. #\
########################################\
\
cat << 'EOF' > /Library/Application\\ Support/JAMF/removeAdminRights.sh\
if [[ -f /private/var/userToRemove/user ]]; then\
	userToRemove=$(cat /private/var/userToRemove/user)\
	echo "Removing $userToRemove's admin privileges"\
	/usr/sbin/dseditgroup -o edit -d $userToRemove -t user admin\
	rm -f /private/var/userToRemove/user\
	launchctl unload /Library/LaunchDaemons/removeAdmin.plist\
	rm /Library/LaunchDaemons/removeAdmin.plist\
	log collect --last $(($4 / 60))m --output /private/var/userToRemove/$userToRemove.logarchive\
fi\
EOF\
\
exit 0}