#!/bin/bash
curl https://projecteuler.net/problem=$1 \
	--compressed -s -H @headers.txt --cookie cookies \
	| sed 's/.*name=\"submit_token\" value=\"\([0-9a-z]*\)\".*/\1/p' -n \
	| ifne -n echo "Havent you already submitted the answer?"

