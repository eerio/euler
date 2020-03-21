#!/bin/bash
curl -s https://projecteuler.net/captcha/show_captcha.php?0 \
	-H @headers.txt -o captcha.png
