#!/bin/bash
source config.sh

user="$(head -1 $file_credentials | head -c -1)"
pass="$(tail -1 $file_credentials | head -c -1)"

curl "$euler/captcha/show_captcha.php?" \
	--cookie-jar "$file_cookies" -o "$file_captcha" -s

./view_captcha.sh

read -p "Enter captcha:" cap

curl "$euler/sign_in" \
	--cookie "$file_cookies"  -L -o "$file_html" -s \
	-d "username=$user&password=$pass&captcha=$cap&sign_in=Sign+In"

if grep -q "Sign in successful" "$file_html"; then
	echo "Sign in successful"
	exit 0
else
	echo "Something went wrong. Look at the content of $out_file"
	exit 1
fi
