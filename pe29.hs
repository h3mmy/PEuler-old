{-# OPTIONS_GHC -O2 -llvm #-}

-- 2<= a,b <= 100
-- combinations of a^b in order with dups removed.

import Data.Array.Unboxed

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

psq = [x^y|y<-[2..6], x<- [2,3,5,7,11]] 


main = do
	print $ psq
	print $ "HI"