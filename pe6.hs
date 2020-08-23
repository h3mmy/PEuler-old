-- Project Euler Problem 6

-- Find the difference between the sum of the squares of the first one hundred natural numbers and the square of the sum.

a :: [Integer]
a = [x^2 | x <- [1..100]]
b :: Integer
b = (sum[1..100])^2

main :: IO ()
main = do print b