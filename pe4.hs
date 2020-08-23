-- Project Euler Problem 4
-- A palindromic number reads the same both ways. The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 × 99.
--
-- Find the largest palindrome made from the product of two 3-digit numbers.


isPal :: Int -> Bool
isPal x = (show x) == (reverse (show x))

a :: [Int]
a = [100,101..999]

b :: [Int]
b = [x*y|x<-a,y<-a, isPal (x*y)]

sol :: Int
sol = maximum b

-- To increase efficiency we could reverse the ordering before processing, but should be negligble for most modern computers

main :: IO ()
main = do print sol