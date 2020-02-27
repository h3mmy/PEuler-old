#!/usr/bin/env runhaskell

import Data.Char

sumd n = foldl1 (+) (map digitToInt (show n))

factorial 0 = 1
factorial n = n * factorial (n-1)

