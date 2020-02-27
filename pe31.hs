{-# OPTIONS_GHC -O2 -llvm #-}


-- 1,2,5,10,20,50,100,200
-- a,b,c,d, e, f, g,  h
-- # of possible solutions?
--
-- Coefficient of x^200 in the following:
--
-- 1/((1-x)(1-x^2)(1-x^5)(1-x^10)(1-x^20)(1-x^50)(1-x^100))

coins = [1,2,5,10,20,50,100,200]
 
withcoins 1 x = [[x]]
withcoins n x = concatMap addCoin [0 .. x `div` coins!!(n-1)]
  where addCoin k = map (++[k]) (withcoins (n-1) (x - k*coins!!(n-1)) )
 
problem_31 = length $ withcoins (length coins) 200

--

pents = scanl (+) 1 [3*n+1| n<-[1..]]

p :: Int -> Int
p =
	let
	  p' m n
	    | n < 0 = 0
		| n == 0 = 1
		| otherwise = sum [p' i (n-i)| i <- [m..n]]
	in
	  p' 1

main = do
	print $ p (5)