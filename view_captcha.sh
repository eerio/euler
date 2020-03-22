#!/bin/bash
convert captcha.png captcha.jpg
jp2a ./captcha.jpg -z --color --chars='..00xx@@'
