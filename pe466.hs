#!/usr/bin/env runhaskell
{-# OPTIONS_GHC -O2 -llvm #-}


import Data.List (nub)



g m n = 1:[ i*j | i <- [2..n], j <- [1..m]]

main = do
	print $ length $ nub $ g 64 (10^16)


