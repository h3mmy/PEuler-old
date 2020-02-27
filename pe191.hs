{-# OPTIONS_GHC -O2 -llvm #-}

combsWithRep :: Int -> [a] -> [[a]]
combsWithRep k xs = combsBySize xs !! k
 where
   combsBySize = foldr f ([[]] : repeat [])
   f x next = scanl1 (\z n -> map (x:) z ++ n) next
   
sol = combsWithRep 10 ["OOO","OAO","OOA","AOO","AAO","OAA","AOA"]

main = do
	print $ length $ sol
