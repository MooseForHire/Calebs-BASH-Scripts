#!/bin/bash

# Variables
domainName=$(hostname | awk -F . '/fmde/ {print $2;}')
todaysDate=$(date)

# Check for valid kerberos ticket
if ! klist -s
	then
    	echo "kerberos ticket not valid; please run command: kinit"
    	exit 1
    else
        echo "Valid kerberos ticket. Continuing..."
        echo -e "\n"
fi

# Check for locked users
echo -e "These users are LOCKED on $domainName as of $todaysDate: \n"
ipa user-find --all --sizelimit=200 | awk -v RS= '/krbloginfailedcount: 3/ {print $5;}'
echo -e "\n"

# Manage user - This user does not have to be in the list above.
read -p 'Please enter user to manage: ' userName
PS3='Choose an action: '
options=("Show number of failed logins" "Unlock user" "Change password" "Quit" )
select opt in "{$options[@]}"
do
    case $opt in
        "Show number of failed logins")
            ipa user-status $userName | grep -E 'Server|Failed'
            ;;
        "Unlock user")
            ipa user-unlock $userName
            ;;
        "Change Password")
            ipa user-mod $userName --password
            ;;
        "Quit")
            break
            ;;
        *) echo "Invalid option $REPLY";;
    esac
done
