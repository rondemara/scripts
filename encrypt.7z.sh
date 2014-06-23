#!/bin/bash

if [ -t 0 ] ; then  
   in_terminal=1
   read -s -p "Enter Password: " password
   read -s -p "Enter Password Again: " passwordagain
else
   in_terminal=0
   password=`zenity --password --title "Enter Password"`
   passwordagain=`zenity --password --title "Enter Password Again"`
fi



if [ $password == $passwordagain ]; then
   encrypted_pass=$password
   7z a -mhe=on -p$encrypted_pass $1.enc $1
   rm -f $1
else
   if [ in_terminal == 0]; then
      echo "Passwords do not match."
   else
      zenity --error --text="Passwords do not match."
   fi
fi


