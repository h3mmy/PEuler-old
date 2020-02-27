#!/usr/bin/env runhaskell

factorCount number = factorCount' number isquare 1 0 - (fromEnum $ square == fromIntegral isquare)
    where square = sqrt $ fromIntegral number
          isquare = floor square

factorCount' :: Int -> Int -> Int -> Int -> Int
factorCount' number sqrt candidate0 count0 = go candidate0 count0
  where
  go candidate count
    | candidate > sqrt = count
    | number `rem` candidate == 0 = go (candidate + 1) (count + 2)
    | otherwise = go (candidate + 1) count

nextTriangle index triangle
    | factorCount triangle > 1000 = triangle
    | otherwise = nextTriangle (index + 1) (triangle + index + 1)

main = print $ nextTriangle 1 1

-- Program goes above the actual answer. Find culprit. Potentially picking the number of over 1000 divisors instead of 500. But what do I know, right?