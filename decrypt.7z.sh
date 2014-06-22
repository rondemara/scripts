#!/bin/bash

#read -s -p "Enter Password: " password
password=`zenity --password --title "Enter Encryption Password:"`
encrypted_pass=$password
7z e -p$encrypted_pass $1

