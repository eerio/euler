#!/bin/bash
source config.sh

convert "$file_captcha" "$captcha_jpg"
jp2a "$captcha_jpg" -z --color --chars='..00xx@@'

./clear.sh

