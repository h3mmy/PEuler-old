#!/usr/bin/env runhaskell

fibs = 1 : 1 : zipWith (+) fibs (tail fibs)

-- f n x = sum $ zipWith (*) (take n fibs) (map (x^) $ take n [1..])

-- Factorial 

factorial :: (Num a, Eq a) => a -> a
factorial 0 = 1
factorial n = n * factorial (n-1)

mN = factorial (15)

-- n = (10^15)

-- f7 a b = rem a b



f n x = ((fibs !! n)*(x^(n+2)) + (fibs !! (n+1))*(x^(n+1)) - x)

