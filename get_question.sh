#!/bin/sh
euler="https://projecteuler.net"

curl "$euler/problem=$1" -s \
	| sed -n '/<div class="problem_content"/,/<\/div>/p' \
	| sed '1d; $d' \
	| sed 's/<[^>]*>//g'

