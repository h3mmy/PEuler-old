#!/usr/bin/env runhaskell
{-# OPTIONS_GHC -O2 -llvm #-}
import Data.Array.Unboxed
import qualified Data.List as L
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
   
-- Relevant stuff
					 
pl2 = map (^2) . map toInteger . takeWhile (<10000000) $ primesSA
sqrs = [x^2| x<-[4,5..]]
f n = n^2 -3*n -1

-- Computed stuff

ens = map (`div` 2) . filter (\x -> rem x 2 == 0) . map (\y -> 3 + (squareRoot y)) . filter (\t -> and [rem (t-13) 4 == 0, t `elem` takeWhile (<(t+1)) pl2]) $ sqrs   -- Finding n's

-- isPMultiple p n = rem n p == 0

sol = [(squareRoot x,y)| x<-pl2, y <-[head [i|i<-ens, rem i x == 0]..x]]
			   
--solution = foldl' (+) 0 . take 664579 -- There are 664579 primes below 10^7

-- Defining a faster fold function
foldl' f z []     = z
foldl' f z (x:xs) = let z' = z `f` x 
                    in seq z' $ foldl' f z' xs

-- Main still takes forever :(

main = do
	putStrLn $ show $ L.nub $ take 66 sol
	