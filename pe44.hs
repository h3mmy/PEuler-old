{-# OPTIONS_GHC -O2 -llvm #-}


pents = scanl (+) 1 [3*n+1| n<-[1..]]

isPent n = (af == 0) && ai `mod` 6 == 5
  where (ai, af) = properFraction . sqrt $ 1 + 24 * (fromInteger n)

combsWithRep :: Int -> [a] -> [[a]]
combsWithRep k xs = combsBySize xs !! k
 where
   combsBySize = foldr f ([[]] : repeat [])
   f x next = scanl1 (\z n -> map (x:) z ++ n) next

fun [x,y] = [x+y,y-x]
gun [x,y] = if (isPent x && isPent y) then True else False

sol = filter gun $ map fun $ combsWithRep 2 (takeWhile (<100000000) pents)


main = do
	putStrLn "Format: [[SUM, DIFFERENCE],..]"
	print $ sol