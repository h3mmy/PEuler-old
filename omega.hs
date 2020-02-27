{-# OPTIONS_GHC -O2 -llvm #-}

-- OBJECTIVE: Using purely derived algorithms from first principles. Write an algorithm for the Omega Function (attrib. Euler)
-- Omega(x) = number of DISTINCT prime factors of x
-- "Big Omega"(x) = number of TOTAL prime factors of x
{- NOTES:
 
for factors of x: there is never a need to search past sqrt(x)
Therefore, the largest factor p_k < x^(1/2)
  
For n <- P, omega(n) = 1 [ASSUMPTION]

Function is defined for n <- Z AND n>0

For n <- 2Z:
"imprint" is defined using 2^d * k | k > 2
d=2, k=1 => 4
d=1, k=3 => 6
d=3, k=1 => 8
d=1, k=5 => 10
d=2, k=3 => 12
d=1, k=7 => 14
d=4, k=1 => 16
d=1, k=9 --> 3^2 => 18


Potential conjecture involved with the alternating d=1 and for k <- P


For n !<- 2Z:
Cases where n <-P --> trivial
For other non trivial cases
May build "imprints" eg. 3^d * k | k > 3 and build all non-prime odd numbers divisible by 3.  
d=2, k=1 => 9
d=1, k=5 => 15

-}
