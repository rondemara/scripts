#!/bin/bash
read -s -p "Enter Password: " password
echo ""
read -s -p "Enter Password again: " passwordagain
echo ""

if [ $password == $passwordagain ]; then
   encrypted_pass=$password
   7z a -mhe=on -p$encrypted_pass $1.enc $1
   rm -f $1
else
   echo "Passwords do not match..."
fi


