#!/usr/bin/env python

# Importing modules

# Global vars
patterns = {"IIII":"IV", "VVVV":"XX", "XXXX":"XL", "LLLL":"CC", "CCCC":"CD", "DDDD":"MM"}
mm = []
# Defining functions

def unfold(f, x):    # Yes, I'm spoiled by Haskell This solution would be much more optimal
    while True:
        w, x = f(x)
        yield w

numerals = (("M", 1000), ("CM", 900), ("D", 500), ("CD", 400),
("C", 100),("XC", 90),("L", 50),("XL", 40), ("X", 10), ("IX", 9), ("V", 5), 
("IV", 4), ("I", 1))

def romanize(n):
    roman = []
    for ltr, num in numerals:
        (k,n) = divmod(n, num)
        roman.append(ltr*k)
    return "".join(roman)

numeral_map = zip(
    (1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1),
    ('M', 'CM', 'D', 'CD', 'C', 'XC', 'L', 'XL', 'X', 'IX', 'V', 'IV', 'I')
)

def int_to_roman(i):
    result = []
    for integer, numeral in numeral_map:
        count = int(i / integer)
        result.append(numeral * count)
        i -= integer * count
    return ''.join(result)

def roman_to_int(n):
    n = unicode(n).upper()

    i = result = 0
    for integer, numeral in numeral_map:
        while n[i:i + len(numeral)] == numeral:
            result += integer
            i += len(numeral)
    return result

def process_line(x):
    """Reduce string to Roman Minimal Form"""
    i = 0
    o = 0
    x = x.strip()
    i += len(x)
    x = x[::-1]
    for p in patterns.keys():
        if p in x:
            x = x.replace(p, patterns[p][::-1])
    o += len(x)
    m = i-o
    mm.append(m)
    return x[::-1]

def mF(f_in, f_out):
    """Read the file run process line write to outfile"""
    
    fcin = open(f_in, 'r')
    fcout = open(f_out, 'w')
    
    for line in fcin:
        fcout.write(process_line(line) + '\n')

    fcin.close()
    fcout.close()

def main():
    """main function"""
    #mF('roman.txt', 'roman2.txt')
    f = open('roman.txt', 'r')
    ix = 0
    ox = 0
    for line in f:
        line = line.strip()
        ix+=len(line)
        line = int_to_roman(roman_to_int(line))
        ox+=len(line)
    
    f.close()
    print ix-ox
# Run main program

main()
#print sum(mm)