#!/bin/bash

file="credentials.txt"
out_file="response.html"

user="$(head -1 $file | head -c -1)"
pass="$(tail -1 $file | head -c -1)"

curl https://projecteuler.net/captcha/show_captcha.php?0 \
	--cookie-jar cookies -o captcha.png -s

./view_captcha.sh

read -p "Enter captcha:" cap

curl https://projecteuler.net/sign_in \
	--cookie cookies  -L -o $out_file -s \
	-d "username=$user&password=$pass&captcha=$cap&sign_in=Sign+In"

if grep -q "Sign in successful" $out_file; then
	echo "Sign in successful"
	exit 0
else
	echo "Something went wrong. Look at the content of $out_file"
	exit 1
fi
