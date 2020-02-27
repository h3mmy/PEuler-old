{-# OPTIONS_GHC -O2 -llvm #-}


a = [10..99]
b =[(x,y)|x<-a,y<-a]

f1 (x,y) = if ((x `mod` 10 == y `div` 10)||(x `mod` 10 == y `mod` 10)||(x `div` 10 == y `div` 10)||(y `mod` 10 == x `div` 10)) then True else False

g1 (x,y) = if x<y then True else False

c = filter g1 $ filter f1 b

f2 n m = [[n `mod` 10, m `div` 10],[n `div` 10, m `div` 10],[n `mod` 10, m `mod` 10],[n `div` 10, m `mod` 10]]

g2 t = toRational (head t) / (last t)

fng (a,b) = map g2 (f2 a b)

main = do
	print $ fng (16,64)