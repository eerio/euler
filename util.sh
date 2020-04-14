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

