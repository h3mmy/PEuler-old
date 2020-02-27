#!/usr/bin/env runhaskell

import Data.Array.Unboxed    -- For primesSA
import Data.Maybe as M

hlim = 1000000

    -- Prime number generator (For producing the first few million primes)
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

-- Odd composite numbers
-- ocn = [ x | x <- M.catMaybes $ zipWith (\a b -> if a==b then Nothing else Just a) [1,3..] primesSA]  Indices...
ocn = [x| x <- [3,5..hlim],x `notElem` takeWhile (< hlim) primesSA]

-- Square numbers

sqrs = [x^2 | x <- [1..hlim]]

fun n = if n `elem` [p+2*s| p <- takeWhile (<n) primesSA,s <- takeWhile (<(n`div`2)) sqrs]
	 then Nothing
	 else Just n

-- Main

main = do
	-- putStrLn $ show $ take 1 $ M.catMaybes $ map fun ocn
	putStrLn $ show $ head $ M.catMaybes $ map fun ocn