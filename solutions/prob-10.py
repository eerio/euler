from sympy import isprime

found = 0
s = 0
p = 0
while p < 2000000:
    if isprime(p):
        found += 1
        s += p
    p += 1
print(s)
