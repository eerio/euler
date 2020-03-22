#!/bin/bash
source config.sh

result=$(curl "$euler/problem=$1" \
	--compressed -s -H @"$file_headers" --cookie "$file_cookies" \
	| sed 's/.*name=\"submit_token\" value=\"\([0-9a-z]*\)\".*/\1/p' -n)

if [ -z "$result" ]
then
	echo "Either you're logged out or have already solved this problem"
	exit 1
else
	echo "$result"
	exit 0
fi

