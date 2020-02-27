#!/usr/bin/env runhaskell
{-# OPTIONS_GHC -O2 -llvm #-}

import Data.Array.Unboxed
import Data.Char (digitToInt)
import qualified Data.List as L

lx = log 10
oom :: Double -> Int
oom n = round $ log n /lx 


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

tcc = takeWhile (<10^6) primesSA

-- rotate :: [a] -> [a]
-- rotate [] = []
-- rotate n = if length n == 1 then n else tail n ++ [head n]

-- cs x = take (length y) $ iterate rotate y where y = show x
cs x = init (zipWith (++) (L.tails y) (L.inits y)) where y = show x -- alternate version
q n = map (\a -> read a :: Int) n

cg z = (q . cs) z


is_cc nl = all (`elem` takeWhile (<x) primesSA) (tail nl) where x = 10^(length nl)

find_count acc p [] = acc
find_count acc p (x:xs) = if p x then find_count (acc+1) p xs else find_count acc p xs

-- Let's reduce tcc as well

tcc2 = filter (\a-> not $ any even $ map digitToInt $ show a) tcc      --- OMG this made it so much faster. Should also exclude 5

-- sol = filter (is_cc . cg) tcc2

main = do
	print $ find_count 1 (is_cc . cg) tcc2  -- The 1 is to offset the subtraction of 2
	
	-- Figure out how to remove the circular primes and have a fall-through effect. Maybe a zip?
	
	
	
--Someone else's solution:
-- import Data.Char (digitToInt)
-- import Data.List
-- import Math.NumberTheory.Primes
-- 
-- 
-- main = print . length . filter isCircularPrime . takeWhile (< 1000000) . map fromIntegral $ primes
--     where
--         isCircularPrime = all isPrime . map fromIntegral . rotations
-- 
-- rotations :: Int -> [Int]
-- rotations x =
--     let len = length (show x)
--     in  take len . map (read :: String -> Int) . iterate (\(c:cs) -> cs ++ [c]) . show $ x


---

-- ans35 = length . map fst . filter (\(_, bv) -> bv == True) . zip candidatePrimes 
--                . map (all (`elem` candidatePrimes)) . map rotations $ candidatePrimes
--   where candidatePrimes = primesUpTo 999999
--         rotations n = map read . map (\x -> (drop x n') ++ (take x n')) $ [0..(length n' - 1)]
--         n' = show n