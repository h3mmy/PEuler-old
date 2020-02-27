#!/usr/bin/env runhaskell

import Control.Monad (nub)

isPandigital n = nub q == length q where q = show n
