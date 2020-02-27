#!/usr/bin/env runhaskell

{-# OPTIONS_GHC -O2 -llvm #-}

-- Project Euler #13: Work out the first ten digits of the sum of one-hundred 50-digit numbers, specified in pe13.data


{--
import qualified System.IO
import qualified Data.List as L
import qualified Data.Char as C

main = do
	-- raw <- readFile "pe13.data"
	-- writeFile "pe13.data.T" (unlines $ L.transpose $ lines raw)
	
	raw <- readFile "pe13.data.T"
	let digit_list = map C.digitToInt (lines raw)
	print digit_list
	
-- sumdigits :: [a] -> Int
sumdigits a = map $ foldr (+) 0 a
--}

main = do xs <- fmap (map read . lines) (readFile "pe13.data")
          print . take 10 . show . sum $ xs