#!/usr/bin/env runhaskell

import Data.Char

p2 = [2^x | x <- [1..]]

sumd n = foldl1 (+) (map digitToInt (show n))

main = do
	--print (take 1000 p2)
	print $ last $ map (sumd) (take 1000 p2)