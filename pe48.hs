#!/usr/bin/env runhaskell

s = [x^x | x <- [1..1000]]

q = [1,2..1000]

g m = filter (>9999999999) m

h i j = zip i (replicate (length i) j)

fun :: [Int] -> Int -> [(Int,Int)]
fun iL jT
	| length iL == 1 = [(iL!!0,(jT+1))]
	| length (g iL) == 0 = fun (drop (1) (zipWith (*) ((drop jT) q) iL)) (jT+1)
	| otherwise = (h (g iL) (jT+1))++(fun (drop (1) (zipWith (*) ((drop jT) q) iL)) (jT+1))


-- Main

main = do
	print (fun q 0)
	print (foldl1 (+) s)
	

