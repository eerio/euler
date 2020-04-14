These are my solutions to the Project Euler exercises

Also, there are my scripts to automatically log into
the website, fetch problems and submit answers. The
captcha has to be solved by user (maybe I'll add some
OCR later, for now I want these scripts to be limited,
but reliable), but it's still pretty convenient to use

Installation:
Dependencies: imagemagick, jp2a, moreutils, curl

If you want to use the login function, put your creds
to credentials.txt using the following format:
"LOGIN\nPASSWORD"

Otherwise, log into Project Euler using your browser
and use its developer tools to find the headers of
requests sent (including the cookie with your session
ID) and copy them into headers.txt


How to test:
1. fetch some questions

$ get_question 7
By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see that the 6th prime is 13.
What is the 10 001st prime number?

2. fetch account tab - it should be a generic html doc with options like 'Sign in' etc
$ get_account_tab
Vim: Reading from stdin...

3. login
4. fetch account tab again - there SHOLD be your info
5. give some stupid answers to a few questions

Usage notes:
You have to source the functions from ./util file
by `. util` executed in the root dir of this repo

Make sure to use `get_submit_token $prob_n` only on
problems you haven't answered yet - there's no submit
token for already answered problems. It doesn't break
anything, but no output might suggest that you aren't
logged in or the script doesn't work, whereas probably
it just couldn't have worked

If you're not sure if you're logged in, try to fetch
the /account tab using `fetch_account_tab`. After taking
a look at the fetched HTML, you should be able to tell.

You can either {use some casual browser headers in
the `headers.txt` file (ex. these provided in this repo)
AND a cookie in `cookies`} OR you can pass the cookie
through a correct header. All the scripts should work
properly regardless of the option, but the default one
here is normal headers + a cookie

Examples:

$ .
$ get_question 2
Each new term in the Fibonacci sequence is generated 
by adding the previous two terms. By starting with 1 
and 2, the first 10 terms will be:
1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ... 
By considering the terms in the Fibonacci sequence 
whose values do not exceed four million, find the sum 
of the even-valued terms.


$ submit_answer
Type problem number:11
Type answer:666
<HERE COMES AN ASCII-ART CAPTCHA!>
Solve captcha:42069
Incorrect!

