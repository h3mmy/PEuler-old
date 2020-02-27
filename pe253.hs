{-# OPTIONS_GHC -O2 -llvm #-}

-- A sequence of triangular numbers
tris = scanl (+) 1 [2..]

-- Factorial implementation

factorial 0 = 1
factorial n = n * factorial (n-1)

-- combinations
choose n 0 = 1
choose 0 k = 0
choose n k = choose (n-1) (k-1) * n `div` k

-- permutations
permute n 0 = 1
permute 0 k = 0
permute n k = permute (n-1) (k-1) * n

combsWithRep :: Int -> [a] -> [[a]]
combsWithRep k xs = combsBySize xs !! k
 where
   combsBySize = foldr f ([[]] : repeat [])
   f x next = scanl1 (\z n -> map (x:) z ++ n) next
{-
[1,2,3,4,5,6,7,8,9,10]
[1]-[3..][5..10]
[1..5][..8][10]
NS-
(M-1)..(n-M) elems
  -}  