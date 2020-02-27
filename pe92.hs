#!/usr/bin/env runhaskell
{-# OPTIONS_GHC -O2 -llvm #-}

digitSqSum 0 = 0
digitSqSum x = let (d, m) = x `divMod` 10 in m^2 + digitSqSum d


f 1 = 1
f 89 = 89
f x = f $ digitSqSum x

n = filter (/=89) $ map f [1..10000000]

main = do
	print $ 10000000 - length n

-- OTHER IDEAS:-
	
-- My approach was to compute the numbers abcdefg where a<=b<=c<=d<=e<=f<=g, and for each of them, if number 89 was found in the chain, add the multinomial coefficient for that number to the sum ((A+B+C+...)!/(A!*B!*C!*...) where A is the number of 1's, B is the number of 2's etc.). It took about a second to compute.
	
-- Well, say you have the number 1123345, also all permutation of this number produces the same chain, so no need to check them. I used the (A+B+C+...)!/(A!*B!*C!*...) formula to calc the number of permutations for a specific number. For the number above, it would have been (2+1+2+1+1)!/(2!*1!*2!*1!*1!). Did that explain it better? Excuse my bad english.

-- There's actually no need to store huge lists or to have to cycle through each number from 1 to 10^7.

-- After a single iteration of the "sum squares of digits" step the number is guaranteed to be less than or equal to 9^2*7 = 567.
-- 
-- Now for each number n <= 567 that ends its cycle with 89 the question becomes: "How many numbers below 10^7 have the sum of the squares of their digits equal to n?"
-- 
-- I assume this is what Snerd did to work out the answer for a googol.

