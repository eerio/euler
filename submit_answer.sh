#!/bin/bash

file_cookies="cookies"
file_html="response.html"
file_captcha="captcha.png"
euler="https://projecteuler.net"
file_headers="headers.txt"

read -p "Enter problem number:" prob
tok=$(./get_submit_token.sh $prob)
if [ $? -eq 1 ]; then
	echo "Unable to get a submit token"
	exit 1
fi


read -p "Enter answer:" ans


./fetch_captcha.sh
./view_captcha.sh
read -p "Enter captcha:" cap
rm "$file_captcha"


data="guess_$prob=$ans&submit_token=$tok&captcha=$cap"

curl "$euler/problem=$prob" \
	-H @"$file_headers" --cookie "$file_cookies" \
	-d "$data" \
	--compressed -Ls -o "$file_html"


if grep -q "<p>Sorry, but the answer you gave appears to be incorrect.</p>" "$file_html"; then
	echo "Incorrect!"
	exit 1
elif grep -q "<p>Congratulations, the answer you gave to problem $prob is correct.</p>" "$file_html"; then
	echo "Correct!"
	exit 1
elif grep -q "An error occurred whilst trying to submit your guess<br>Please try again" "$file_html"; then
	echo "An error occured :("
	exit 1
elif grep -q '<div id="message" class="noprint">The confirmation code you entered was not valid</div>' "$file_html"; then
	echo "Invalid captcha"
	exit 1
else
	echo "Unknown error. Check $file_html and look what's going on"
fi

