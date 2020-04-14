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

