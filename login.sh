#!/bin/bash

file="credentials.txt"
user="$(head -1 $file | head -c -1)"
pass="$(tail -1 $file | head -c -1)"

curl https://projecteuler.net/captcha/show_captcha.php?0 \
	--cookie-jar cookies -o captcha.png -s

read -p "Enter captcha:" cap

curl https://projecteuler.net/sign_in \
	--cookie cookies  -L -o /dev/null -s \
	-d "username=$user&password=$pass&captcha=$cap&sign_in=Sign+In"
