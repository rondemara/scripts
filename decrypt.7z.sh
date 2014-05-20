#!/bin/bash

read -s -p "Enter Password: " password
encrypted_pass=`(echo '$password' | sha256sum) | awk '{print $1}'`
7z e -p$encrypted_pass $1

