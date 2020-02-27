-- I feel mocked
#!/usr/bin/env runhaskell

-- Here is the whole Fib Sequence
fibs = 1 : 1 : zipWith (+) fibs (tail fibs)
-- Here, 'a' is a list comprehension of all the even elements of fibs less than four million
a = [x|x<- takeWhile (<4000000) (tail(fibs)), x`mod`2==0] -- Using tail to leave the first 1 hanging as per Requirement
-- Now to just sum a and get it over with
-- Do it ghci as 'sum a'