#!/usr/bin/env runhaskell
{-# OPTIONS_GHC -O2 -llvm #-}

-- A handful of VERY useful code.
-- If you can make it more effficient, do it!

-- Importing modules

--import Data.Array          -- For when you don't want the unboxed array module in primesSA
import Data.Array.Unboxed    -- For primesSA


-- Constants
phi = ((1+ sqrt 5) / 2)


-- Common sequence generators

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
     
	 -- Prime number generator (Using the Tree Folding Method with wheel optimization) Needs -fno-cse flag to GHC
-- primesTMWE = [2,3,5,7] ++ _Y ((11:) . tail . gapsW 11 wheel . joinT3 . hitsW 11 wheel)
--  
-- gapsW k (d:w) s@(c:cs) | k < c     = k : gapsW (k+d) w s
--                        | otherwise =     gapsW (k+d) w cs      -- k==c
-- hitsW k (d:w) s@(p:ps) | k < p     =     hitsW (k+d) w s
--                        | otherwise = scanl (\c d->c+p*d) (p*p) (d:w) 
--                                        : hitsW (k+d) w ps      -- k==p 
-- joinT3 ((x:xs): ~(ys:zs:t)) = x : union xs (union ys zs)    
--                                    `union` joinT3 (pairs t)  
-- wheel = 2:4:2:4:6:2:6:4:2:4:6:6:2:6:4:2:6:4:6:8:4:2:4:2:
--         4:8:6:4:6:2:4:6:2:6:6:4:2:4:6:2:6:4:2:4:2:10:2:10:wheel
	                 
	 -- A sequence of triangular numbers
tris = scanl (+) 1 [2..]

	 -- The Fibonacci series
fibs = 1 : 1 : zipWith (+) fibs (tail fibs)
bfibs :: Integer -> Integer
bfibs n = round $ ((phi^n - (1-phi)^n) / sqrt 5)   -- Maxes out at something (n=1474; 308 digits)


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
   
-- Factorial implementation

factorial 0 = 1
factorial n = n * factorial (n-1)

-- combinations
choose n 0 = 1
choose 0 k = 0
choose n k = choose (n-1) (k-1) * n `div` k

-- permutations
permute n 0 = 1
permute 0 k = 0
permute n k = permute (n-1) (k-1) * n

-- sum of the digits of a number
digitSum 0 = 0
digitSum x = let (d, m) = x `divMod` 10 in m + digitSum d

-- Collatz series upto n [Not the most efficient]
collatz 1 = [1]
collatz n
    | even n    = n : collatz (n `div` 2)
    | otherwise = n : collatz (3*n + 1)

-- Factorization section

	-- Generate a list of divisors for a number          
gend a = [x|x<-[1..a], rem a x == 0]      -- VERY Brute force. Use for small datasets only.

    -- Generate a list of prime factors for a number
pfactor 1 = []
pfactor n = let divisors = dropWhile ((/= 0) . mod n) [2 .. ceiling $ sqrt $ fromIntegral n]
           in let prime = if null divisors then n else head divisors
              in (prime :) $ pfactor $ div n prime



