#!/bin/bash

read -s -p "Enter Password: " password
encrypted_pass=$password
7z e -p$encrypted_pass $1

