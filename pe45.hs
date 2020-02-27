#!/usr/bin/env runhaskell

import Data.List

every n xs = case drop (n-1) xs of
              (y:ys) -> y : every n ys
              [] -> []

tris = scanl (+) 1 [2..]

pents = scanl (+) 1 [3*n+1| n<-[1..]] -- nifty algebra to figure out this one

hexes = 1:(every 2 $ drop 1 tris) -- Every other triangular number

hexes' = scanl (+) 1 $ drop 1 $ scanl (+) 1 $ repeat 4 -- A self-concocted independent generator using the two base sequences

hexes'' = scanl (+) [5,9..]

solution = head $ intersect (dropWhile (<40756) pents) $ dropWhile (<40756) hexes

-- Evidently Testing for Pentagonality is easier


isPent n = (af == 0) && ai `mod` 6 == 5
  where (ai, af) = properFraction . sqrt $ 1 + 24 * (fromInteger n)
 
problem_45 = head [x | x <- scanl (+) 1 [5,9..], x > 40755, isPent x]

main = do
	print problem_45