#!/usr/bin/env runhaskell
{-# OPTIONS_GHC -O2 -llvm #-}

import qualified Data.Set as Set
import Data.Char

has_same_digits:: (Ord a) => [a] -> [a] -> Bool
has_same_digits x y = Set.null $ Set.union (Set.difference (Set.fromList x) (Set.fromList y)) (Set.difference (Set.fromList y) (Set.fromList x))

m2 :: (Num a, Show a) => a -> Bool
m2 x = (has_same_digits (map digitToInt $ show x) (map digitToInt $ show (2*x)))
m3 :: (Num a, Show a) => a -> Bool
m3 x = (has_same_digits (map digitToInt $ show x) (map digitToInt $ show (3*x)))
m4 :: (Num a, Show a) => a -> Bool
m4 x = (has_same_digits (map digitToInt $ show x) (map digitToInt $ show (4*x)))
m5 :: (Num a, Show a) => a -> Bool
m5 x = (has_same_digits (map digitToInt $ show x) (map digitToInt $ show (5*x)))
m6 :: (Num a, Show a) => a -> Bool
m6 x = (has_same_digits (map digitToInt $ show x) (map digitToInt $ show (6*x)))

mp = [a | a <- [1..], m2 a, m3 a, m3 a, m4 a, m5 a, m6 a]


main = do
	print $ head mp