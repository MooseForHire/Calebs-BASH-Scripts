#!/bin/bash

# Add new users. MUST BE ROOT!
PS3='Which domain will this user belong to? '
options=("domain1" "domain2" "domain3" "Quit" )
select opt in "{$options[@]}"
do
    case $opt in
        "domain1")
            homeDir1=/path/to/dir/
            read -p 'Enter Username:' userName
            read -p 'Enter First Name:' firstName
            read -p 'Enter Last Name:' lastName
            read -p 'Enter Email:' userEmail
            ipa user-add $userName --first=$firstName --last=$lastName --email=$userEmail --password --shell=/bin/bash --homedir=$homeDir1
            cp -R /etc/skel/.[a-z]* $homeDir1
            ipa user-show $userName
            break
            ;;
        "domain2")
            homeDir2=/path/to/dir/
            read -p 'Enter Username:' userName
            read -p 'Enter First Name:' firstName
            read -p 'Enter Last Name:' lastName
            read -p 'Enter Email:' userEmail
            ipa user-add $userName --first=$firstName --last=$lastName --email=$userEmail --password --shell=/bin/bash --homedir=$homeDir2
            cp -R /etc/skel/.[a-z]* $homeDir2
            ipa user-show $userName
            break
            ;;
        "domain3")
            homeDir3=/path/to/dir/
            read -p 'Enter Username:' userName
            read -p 'Enter First Name:' firstName
            read -p 'Enter Last Name:' lastName
            read -p 'Enter Email:' userEmail
            ipa user-add $userName --first=$firstName --last=$lastName --email=$userEmail --password --shell=/bin/bash --homedir=$homeDir3
            cp -R /etc/skel/.[a-z]* $homeDir3
            ipa user-show $userName
            break
            ;;
        "Quit")
            break
            ;;
        *) echo "Invalid option $REPLY";;
    esac
done
