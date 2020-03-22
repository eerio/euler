#!/bin/bash

curl https://projecteuler.net/account \
	--compressed -H @headers.txt --cookie cookies \
	| vim -

