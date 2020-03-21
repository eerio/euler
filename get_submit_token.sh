#!/bin/bash
curl -s -H @headers.txt https://projecteuler.net/problem=$1 --compressed \
	| sed 's/.*name=\"submit_token\" value=\"\([0-9a-z]*\)\".*/\1/p' -n
