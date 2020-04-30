Main file: ./euler

There are my scripts to automatically log into
the website, fetch problems and submit answers. The
captcha has to be solved by user (maybe I'll add some
OCR later, for now I want these scripts to be limited,
but reliable), but it's still pretty convenient to use

Note: you can use all of the functions from terminal,
no need to use GUI even for Captcha, since it'll be
displayed as an ASCII-art

Installation:
Dependencies: imagemagick, jp2a, curl

If you want to use the login function, put your creds
to credentials.txt using the following format:
"LOGIN\nPASSWORD"

Otherwise, log into Project Euler using your browser
and use its developer tools to find the headers of
requests sent (including the cookie with your session
ID) and copy them into headers.txt

The default way is using headers with session ID stripped
(e.g. these provided in this repo) + a valid cookie (e.g.
obtained by running `euler login`)
 
How to test:
1. fetch some questions
$ ./euler prob 7
2. fetch account tab - it should be a generic html doc
   with options like 'Sign in' etc
$ ./euler account
3. sign in to Project Euler
$ ./euler login
4. fetch account tab again - there SHOLD be some settings to set etc.
5. give some stupid answers to a few questions and check if you get to a point
   where it tells you that the answer is invalid (or even valid if you're
   lucky enough :p)
$ ./euler submit

Usage notes:

If you're not sure if you're logged in, try to fetch
the /account tab using `./euler account`. After taking
a look at the fetched HTML, you should be able to tell.

You can either {use some casual browser headers in
the `headers.txt` file (ex. these provided in this repo)
AND a cookie in `cookies`} OR you can pass the cookie
through a correct header. All the scripts should work
properly regardless of the option, but the default one
here is normal headers + a cookie

Examples:

$ ./euler prob 2
Each new term in the Fibonacci sequence is generated 
by adding the previous two terms. By starting with 1 
and 2, the first 10 terms will be:
1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ... 
By considering the terms in the Fibonacci sequence 
whose values do not exceed four million, find the sum 
of the even-valued terms.


$ ./euler submit
Type problem number:11
Type answer:666
<HERE COMES AN ASCII-ART CAPTCHA!>
Solve captcha:42069
Incorrect!

