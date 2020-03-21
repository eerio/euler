#!/bin/sh

curl https://projecteuler.net/problem=$1 -s \
	| sed -n '/<div class="problem_content"/,/<\/div>/p' \
	| sed '1d; $d' \
	| sed 's/<[^>]*>//g'

