#!/usr/bin/env runhaskell
{-# OPTIONS_GHC -O2 -llvm #-}

import Data.Digits (digits)

-- Defining a faster fold function
foldl' f z []     = z
foldl' f z (x:xs) = let z' = z `f` x 
                    in seq z' $ foldl' f z' xs

isreversible :: Integer -> Int
isreversible a = if and . map odd . digits 10 $ (a + (read . reverse . show $ a :: Integer)) then 1 else 0


fun = foldl' (+) 0 . map isreversible

--sol = fun [1000,1001..10^7] -- 73250
--sol2 = fun [10^7..10^8]     --675000
-- Total so far 748250 + 120 = 748370
sol3 = fun [10^8..10^9]


main = do
	--print $ sol
	print $ sol3
