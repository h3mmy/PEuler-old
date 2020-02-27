{-
For every real number a>1 is given the sequence ga by:
ga(x)=1 for x<a
ga(x)=ga(x−1)+ga(x−a) for x≥a
G(n)=gn√(n)
G(90)=7564511.

Find ∑G(p) for p prime and 10000000<p<10010000
Give your answer modulo 1000000007.
-}

g :: Integral a => a -> a -> a
g a x
	| x < a = 1
	| x >= a = g a (x-1) + g a (x-a)