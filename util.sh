#!/bin/sh
source config.sh

clear() {
	rm "$file_captcha" "$captcha_jpg" "$file_html"
}

view_captcha() {
	convert "$file_captcha" "$captcha_jpg"
	jp2a "$captcha_jpg" -z --color --chars='..00xx@@'
}

