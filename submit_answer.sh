#!/bin/bash

cookie_file="cookies"
file="response.html"

read -p "Type problem number:" prob

if [ $? -eq 1 ]; then
	echo "Unable to get a submit token"
	exit 1
fi

read -p "Type answer:" ans

tok=$(./get_submit_token.sh $prob)
./fetch_captcha.sh
read -p "Solve captcha:" cap


data="guess_$prob=$ans&submit_token=$tok&captcha=$cap"

echo $data

curl https://projecteuler.net/problem=$prob \
	-H @headers.txt --cookie $cookie_file \
	-d $data \
	--compressed -Ls -o $file

if grep -q "<p>Sorry, but the answer you gave appears to be incorrect.</p>" $file; then
	echo "Incorrect!"
	exit 1
elif grep -q "<p>Congratulations, the answer you gave to problem $prob is correct.</p>" $file; then
	echo "Correct!"
	exit 1
elif grep -q "An error occurred whilst trying to submit your guess<br>Please try again" $file; then
	echo "An error occured :("
	exit 1
elif grep -q '<div id="message" class="noprint">The confirmation code you entered was not valid</div>' $file; then
	echo "Invalid captcha"
	exit 1
else
	echo "Unknown error. Check $file and look what's going on"
fi

