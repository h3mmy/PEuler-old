{-# OPTIONS_GHC -O2 -llvm #-}

{-
Let smpf(n) be the smallest prime factor of n.
smpf(91)=7 because 91=7×13 and smpf(45)=3 because 45=3×3×5.
Let S(n) be the sum of smpf(i) for 2 ≤ i ≤ n.
E.g. S(100)=1257.

Find S(10^12) mod 10^9.
-}

import Data.Array.Unboxed


primesSA = 2 : prs
  where 
    prs = 3 : sieve prs 3 []
    sieve (p:ps) x fs = [i*2 + x | (i,e) <- assocs a, e] 
                        ++ sieve ps (p*p) fs'
     where
      q     = (p*p-x)`div`2                  
      fs'   = (p,0) : [(s, rem (y-q) s) | (s,y) <- fs]
      a     :: UArray Integer Bool                                   -- Using Unboxed Array module
      a     = accumArray (\ b c -> False) True (1,q-1)
                         [(i,()) | (s,y) <- fs, i <- [y+s, y+s+s..q]]
                         


-- Assume n is ABSOLUTELY NOT prime. This can be established later by using an input list containing no primes. 
-- Also no even nums because the answer there is simply 2
-- IF the smpf of a p is supposed to be p, then for S(n) we will simply add the sum of p <= n
-- This will be established by testing our algo with the eg.
-- These function OK for generalized input. 
smpf n = head [ p | p <- primesSA, rem n p == 0]

s n = (foldl1 (+) . map smpf) primesSA

f x = rem (x*(10^12 `div` x)) (10^9)
g x y = rem (x + y) 10^9
s2 = (foldl1 g . map f) in_p where
	in_p = takeWhile (<10^8) primesSA
	
-- Now let's optimize them for our input. 
-- 2 <= i <= n will contain p such that p occurs n div p times. 
-- So S(n) = sigma p_1->p_k,(p_i<n,2..) p*(n div p) mod 10^19 
{-
main = do
	print $ (take 10 . map (\x -> 10^27 `div` x)) primesSA -}