#!/usr/bin/env runhaskell

import Data.List

tris = scanl (+) 1 [2..]

-- FAIL!!! For this dataset, make a better factorization algorithm.

gend :: (Eq a, Integral a) => a -> [a]
gend a = [x|x<-[1..a], rem a x == 0]

solution = head [y | y <- tris, length(gend y) > 500]
sol2 = find ((>500) . length . gend) tris