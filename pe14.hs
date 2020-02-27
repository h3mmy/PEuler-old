#!/usr/bin/env runhaskell

import Data.List

collatzSeq :: Int -> [Int]
collatzSeq a
	| a == 1 = [1]
	| rem a 2 == 0 = a : collatzSeq (a `div` 2)
	| otherwise = a : collatzSeq (succ (3*a))

lcseq :: Int -> Int
lcseq a = length $ collatzSeq a

lst = fmap (lcseq) [1..1000000]

numl = 525 `elemIndex` lst -- 525 is max lst. The answer is the [accepted answer-1]{Why? I'm not sure yet}