{-# OPTIONS_GHC -O2 -llvm #-}

-- OBJECTIVE: To write and optimize a working totient funtion (Euler)

-- Basic

tot x = (length . filter (\a -> gcd x a == 1)) [1..x]


