import Data.Array.Unboxed

primesSA = 2 : prs
  where 
    prs = 3 : sieve prs 3 []
    sieve (p:ps) x fs = [i*2 + x | (i,e) <- assocs a, e] 
                        ++ sieve ps (p*p) fs'
     where
      q     = (p*p-x)`div`2                  
      fs'   = (p,0) : [(s, rem (y-q) s) | (s,y) <- fs]
      a     :: UArray Integer Bool                                   -- Using Unboxed Array module
      a     = accumArray (\ b c -> False) True (1,q-1)
                         [(i,()) | (s,y) <- fs, i <- [y+s, y+s+s..q]]


tot x = (length . filter (\a -> gcd x a == 1)) [1..x]

f n = (fromIntegral n) / (fromIntegral (tot n))
g n = (n,f n)
h n = not $ elem n (takeWhile (<=n) primesSA)

f2 x (_,y) = x == y  

a =  ((map f) . filter (h)) [2..1000000]
b =  ((map g) . filter (h)) [2..1000000]

-- 2*3*..13 = 270270 *3 = 810810 (f= 5.21354)