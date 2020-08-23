-- Project Euler Problem 5
-- 2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any remainder.

-- What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?

ta_da :: Integer
ta_da = foldl lcm 2 [3..20]

main :: IO ()
main = do print ta_da