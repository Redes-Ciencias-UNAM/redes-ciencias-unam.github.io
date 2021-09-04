#!/usr/bin/env bash
# https://stackoverflow.com/a/36296872

# Get data
echo -n "Email    (shown)  :	"
read    email
echo -n "Password (hidden) :	"
read -s password
echo

# Output encoded string
echo -ne "\0${email}\0${password}" | base64
