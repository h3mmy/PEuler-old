#!/usr/bin/env runhaskell
{-# OPTIONS_GHC -O2 -llvm #-}

import Data.Map

pythTrips = [(a,b,c) | c <- [2..], b <- [2..c-1], a <- [2..b-1], a^2 + b^2 == c^2]    -- All the pythogorean triples (Brute force)
checkT c t = (((\(x,y,z) -> x+y+z) t) <= c)  -- Checks if the sum of the triple t is less than or euqal to c
pytr = takeWhile (checkT 1000) pythTrips     -- The pythagorean triples with sums under or equal to 1000
sa = [ ((\(x,y,z)->x+y+z) d,1) | d <- pytr ] -- A set of tuples (sum, 1 pythTrip) for the relevant triples

sortAndGroup assocs = fromListWith (++) [(k, [v]) | (k, v) <- assocs] -- Make associative list and groupBy

fsa = sortAndGroup sa -- Organized sa

f k v = length v

lfsa = mapWithKey f fsa

fsa2 = toList lfsa

newfs = sortAndGroup $ Prelude.map (\(a,b)->(b,a)) fsa2

main = do
	print $ maxView newfs