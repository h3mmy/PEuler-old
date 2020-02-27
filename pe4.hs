#!/usr/bin/env runhaskell

isPal :: Int -> Bool
isPal x = (show x) == (reverse (show x))

a = [100,101..999]
b = [x*y|x<-a,y<-a, isPal (x*y)]
