-- Project Euler Problem 3

--The prime factors of 13195 are 5, 7, 13 and 29.

--What is the largest prime factor of the number 600851475143 ?

-- Importing Module(s) for Prime Number Generator using a modified Sieve
import Data.Array
-- import Data.Array.Unboxed
 
primesSA :: [Integer]
primesSA = 2 : prs
  where 
    prs = 3 : sieve prs 3 []
    sieve (p:ps) x fs = [i*2 + x | (i,e) <- assocs a, e] 
                        ++ sieve ps (p*p) fs'
     where
      q     = (p*p-x)`div`2                  
      fs'   = (p,0) : [(s, rem (y-q) s) | (s,y) <- fs]
      -- a     :: UArray Int Bool
      a     = accumArray (\ b c -> False) True (1,q-1)
                         [(i,()) | (s,y) <- fs, i <- [y+s, y+s+s..q]]

-- Defining a couple of functions from scratch. This code was written in the ancient times without readily available math modules
(^!) :: Num a => a -> Int -> a
(^!) x n = x^n
 
squareRoot :: Integer -> Integer
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

b :: [Integer]
b = [ x | x<- takeWhile (<squareRoot(600851475143)) primesSA ,600851475143 `mod` x == 0]

main :: IO ()
main = do print b
