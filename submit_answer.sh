#!/bin/bash

cookie_file="cookies"
file="response.html"

read -p "Type problem number:" prob
read -p "Type answer:" ans

tok=$(./get_submit_token.sh $prob)

./fetch_captcha.sh
read -p "Solve captcha:" cap

curl https://projecteuler.net/problem=$prob \
	-H @headers.txt --cookie $cookie_file \
	-d "guess_$prob=$ans&submit_token=$tok&captcha=$cap" \
	--compressed -Ls -o $file

if grep -q "<p>Sorry, but the answer you gave appears to be incorrect.</p>" $file; then
	echo "Incorrect!"
elif grep -q "<p>Congratulations, the answer you gave to problem $prob is correct.</p>" $file; then
	echo "Correct!"
elif grep -q "An error occurred whilst trying to submit your guess<br>Please try again" $file; then
	echo "An error occured :("
fi

