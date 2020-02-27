#!/usr/bin/env runhaskell

h (x,y) = ( 5000-0.005*(x*x+y*y+x*y)+12.5*(x+y) ) * exp( -abs(0.000001*(x*x+y*y)-0.0015*(x+y)+0.7) )

fmin = h 1400 1400 -- ?

r = [(x,y)| x<-[0,1..1600], y<-[0,1..1600]]

q (x,y) = x*(x-1500)+y*(y-1500)+700000

m (x,y) = 5000((10000-x^2+2500*x)+y(y+x+2500))

a = (200,200)
b = (1400,1400)
s1 = map h r
s2 = map q r
s3 = map m r

main = do
	print s1
	

-- Solution is 2531.205 for shortest path b/w a and b at a constant MINIMUM height
