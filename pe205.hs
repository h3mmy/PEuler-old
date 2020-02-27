{-
Peter has nine four-sided (pyramidal) dice, each with faces numbered 1, 2, 3, 4.
Colin has six six-sided (cubic) dice, each with faces numbered 1, 2, 3, 4, 5, 6.

Peter and Colin roll their dice and compare totals: the highest total wins. The result is a draw if the totals are equal.

What is the probability that Pyramidal Pete beats Cubic Colin? Give your answer rounded to seven decimal places in the form 0.abcdefg
-}

-- import qualified Data.Map as M
import Control.Arrow
import qualified Data.List as L
import Control.Monad
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
   

-- count = M.fromListWith (+) . map (, 1)
frequency :: Ord a => [a] -> [(Int,a)] 
frequency = map (length &&& head) . L.group . L.sort

p = Prelude.map sum $ replicateM 9 [1,2,3,4]
c = Prelude.map sum $ replicateM 6 [1,2,3,4,5,6]

f n = ((fst. head ). filter (\x -> snd x == n))

-- (1/(4^9)*(6^6))[p_36 * (c_35 + c_34 + .. c_6) + p_35 * (c_34 + ..) + .. p_9 * (c_9 + ..c_6)]

sol = foldl1 (+) [ (f y $ frequency p) * (foldl1 (+) [f x $ frequency c | x <- [6..(y-1)]]) | y <-[9..36]]

