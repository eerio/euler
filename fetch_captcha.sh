#!/bin/bash
file_cookie=cookies
file_headers=headers.txt
file_captcha=captcha.png

curl -s https://projecteuler.net/captcha/show_captcha.php?0 \
	-H @"$file_headers" --cookie "$file_cookie" -o "$file_captcha"
