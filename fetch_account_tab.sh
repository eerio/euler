#!/bin/bash
file_headers="headers.txt"
file_cookies="cookies"
euler="https://projecteuler.net"

curl "$euler/account" \
	--compressed -sH @"$file_headers" --cookie "$file_cookies" \
	| vim -

