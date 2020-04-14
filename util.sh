#!/bin/sh
source config.sh

clear() {
	rm "$file_captcha" "$captcha_jpg" "$file_html"
}

view_captcha() {
	convert "$file_captcha" "$captcha_jpg"
	jp2a "$captcha_jpg" -z --color --chars='..00xx@@'
}

fetch_captcha() {
	curl -s "$euler/captcha/show_captcha.php?" \
		-H @"$file_headers" --cookie "$file_cookies" -o "$file_captcha"
}

get_account_tab() {
	curl "$euler/account" \
	        --compressed -sH @"$file_headers" --cookie "$file_cookies" \
		| vim -
}

get_question() {
	curl "$euler/problem=$1" -s \
	        | sed -n '/<div class="problem_content"/,/<\/div>/p' \
		| sed '1d; $d' \
		| sed 's/<[^>]*>//g'
}

get_submit_token() {
	result=$(curl "$euler/problem=$1" \
		--compressed -s -H @"$file_headers" --cookie "$file_cookies" \
		| sed 's/.*name=\"submit_token\" value=\"\([0-9a-z]*\)\".*/\1/p' -n)
	
	if [ -z "$result" ]
	then
	        echo "Either you're logged out or have already solved this problem"
		exit 1
	else
		echo "$result"
		exit 0
	fi
}

login() {
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
}

submit_answer() {
	read -p "Enter problem number:" prob
	tok=$(./get_submit_token.sh $prob)
	if [ $? -eq 1 ]; then
		echo "Unable to get a submit token"
		exit 1
	fi

	read -p "Enter answer:" ans

	fetch_captcha()
	view_captcha()
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
}

