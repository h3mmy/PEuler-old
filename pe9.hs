#!/usr/bin/env runhaskell

q = [[a,b,c]| a <- [1..500], b <- [1..a], let c = (1000 -b -a), a^2 +b^2 == c^2]
