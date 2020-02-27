{-# OPTIONS_GHC -O2 -llvm #-}

import Data.Char

tris = take 300 $ scanl (+) 1 [2..]  -- t_n = (n/2)(n+1)

wordscore xs = sum $ map (subtract 64 . ord) xs

sol megalist = 
    length [ wordscore a | a <- megalist,
                           elem (wordscore a) tris ]

main = do
	f <- readFile "pe42_words.txt"
	let words = read $ "[" ++ f ++ "]"
	print $ sol words