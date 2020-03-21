These are my solutions to the Project Euler exercises

Also, there are my scripts to automatically download 
and submit problems. The captcha has to be solved by 
user (maybe I'll add some OCR later, for now I want 
these scripts to be limited but reliable), but it's 
still pretty convenient to use

fetch_captcha.sh and get_submit_token.sh are just two 
auxiliary scripts


Installation:
Make sure to run `chmod +x` for all of the scripts

Examples:

$ ./get_question.sh 2
Each new term in the Fibonacci sequence is generated 
by adding the previous two terms. By starting with 1 
and 2, the first 10 terms will be:
1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ... 
By considering the terms in the Fibonacci sequence 
whose values do not exceed four million, find the sum 
of the even-valued terms.


$ ./submit_answer.sh
Type problem number:11
Type answer:666
Solve captcha:42069
Incorrect!

