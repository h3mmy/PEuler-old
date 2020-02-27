#!/usr/bin/env runhaskell
{-# OPTIONS_GHC -O2 -llvm #-}

import Data.Array.Unboxed

{-

a^2 +b^2 = N ----  (I)

Z+

define S(N) as sum of all a that are solutions to (I)

Find S(N) for all squarefree N only divisible by primes of the form 4k+1 and <150

-}

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
						 
-- Square root implementation of GNU's multiprecision library

(^!) :: Num a => a -> Int -> a
(^!) x n = x^n
 
squareRoot :: Integer -> Integer  -- ONLY INTEGER ANSWERS
squareRoot 0 = 0
squareRoot 1 = 1
squareRoot n =
   let twopows = iterate (^!2) 2
       (lowerRoot, lowerN) =
          last $ takeWhile ((n>=) . snd) $ zip (1:twopows) twopows
       newtonStep x = div (x + div n x) 2
       iters = iterate newtonStep (squareRoot (div n lowerN) * lowerRoot)
       isRoot r  =  r^!2 <= n && n < (r+1)^!2
   in  head $ dropWhile (not . isRoot) iters

z = [1..37]

f k = 4*k + 1

isp n = n `elem` takeWhile (<=n) primesSA

d = filter isp $ map f z

sq = map (^2) [1..150]

s n = sum $ map squareRoot [a| a <- sq, b <- sq, a < b, a + b == n]

c p = read (show p) :: Integer

nsq m = m `notElem` sq 

dp = map c [x*y|x<-d,y<-d, x /= y]


main = do
	print $ sum $ map s dp
