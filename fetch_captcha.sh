#!/bin/bash
file_cookie="cookies"
file_headers="headers.txt"
file_captcha="captcha.png"
euler="https://projecteuler.net"

curl -s "$euler/captcha/show_captcha.php?" \
	-H @"$file_headers" --cookie "$file_cookie" -o "$file_captcha"
