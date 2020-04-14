#!/bin/sh
source config.sh

clear() {
	rm "$file_captcha" "$captcha_jpg" "$file_html"
}

