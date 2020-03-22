#!/bin/bash

curl https://projecteuler.net/account \
	--compressed -sH @headers.txt --cookie cookies \
	| vim -

