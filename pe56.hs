#!/usr/bin/env runhaskell

digitSum 0 = 0
digitSum x = let (d, m) = x `divMod` 10 in m + digitSum d

nums = [a^b|a<-[1..99],b<-[1..99], a/=10]

main = do
	print $ maximum $ map digitSum nums
