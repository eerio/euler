#!/bin/bash
source config.sh

curl "$euler/account" \
	--compressed -sH @"$file_headers" --cookie "$file_cookies" \
	| vim -

