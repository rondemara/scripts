#!/bin/bash

password=`zenity --password --title "Enter Encryption Password:"`
passwordagain=`zenity --password --title "Enter Encryption Password Again:"`

if [ $password == $passwordagain ]; then
   encrypted_pass=$password
   7z a -mhe=on -p$encrypted_pass $1.enc $1
   rm -f $1
else
   zenity --error --text="Password is incorrect."
fi


