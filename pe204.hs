{-# OPTIONS_GHC -O2 -llvm #-}

import Data.Array.Unboxed    -- For primesSA
import Data.List (nub)

primesSA = 2 : prs
  where 
    prs = 3 : sieve prs 3 []
    sieve (p:ps) x fs = [i*2 + x | (i,e) <- assocs a, e] 
                        ++ sieve ps (p*p) fs'
     where
      q     = (p*p-x)`div`2                  
      fs'   = (p,0) : [(s, rem (y-q) s) | (s,y) <- fs]
      a     :: UArray Int Bool                                   -- Using Unboxed Array module
      a     = accumArray (\ b c -> False) True (1,q-1)
                         [(i,()) | (s,y) <- fs, i <- [y+s, y+s+s..q]]
     

-- Generalized Hamming number of type n if it has no prime factor greater than n.
-- How many of type 100 such that <10^9?

g n = map floor $ map (flip logBase (10^9)) $ map fromIntegral n

soup = takeWhile (<100) primesSA
max_pow = g soup
soup2 = concat $ zipWith replicate max_pow soup
soup3 = g $ nub [x*y|x<-soup2,y<-soup2, x*y<10^9]

f s 1 = s
f s n = (nub $ filter (<(10^9)) [(x^n)*y|x<-s,y<-s,x*y<10^9]) ++ f s (n-1)


main = do
	print $ length$nub $ filter (<(10^9)) $ f soup 5 ++ f (take 18 soup) 6 ++ f (take 11 soup) 8 ++ f (take 7 soup) 5