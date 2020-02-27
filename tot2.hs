{-# OPTIONS_GHC -O2 -llvm #-}

-- OBJECTIVE: Using purely derived algorithms from first principles. Write an algorithm for the Totient Function (attrib. Euler)
{- NOTES:
 
for factors of x: there is never a need to search past sqrt(x)
Therefore, the largest factor p_k < x^(1/2)
  

-}