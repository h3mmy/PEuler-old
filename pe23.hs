{-# OPTIONS_GHC -O2 -llvm #-}

import Data.Array 

totient 1 = 1
totient a = length $ filter (coprime a) [1..a-1]
 where coprime a b = gcd a b == 1


n = 28124
abundant n = totient n - n > n
abunds_array = listArray (1,n) $ map abundant [1..n]
abunds = filter (abunds_array !) [1..n]
 
rests x = map (x-) $ takeWhile (<= x `div` 2) abunds
isSum = any (abunds_array !) . rests

main = do
	print . sum . filter (not . isSum) $ [1..n]
-- Correct is 4179871
-- Code is wrong somewhere