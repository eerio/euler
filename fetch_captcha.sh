#!/bin/bash
source config.sh

curl -s "$euler/captcha/show_captcha.php?" \
	-H @"$file_headers" --cookie "$file_cookies" -o "$file_captcha"
