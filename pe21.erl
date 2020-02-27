-module(pe21).
-author("Zachariah Aslam - XaC .IM").
-import(tools, [primes/1,isqrt3a/1,isqrt4/1]).

-export([start/0, tamic/1, d/1, pdivs/1]).


pdivs(N) -> lists:concat([[X,(N div X)] || X <- lists:seq(1,(tools:isqrt3a(N))), N rem X == 0]).

d(N) -> lists:sum(lists:delete(N,pe21:pdivs(N))).


tamic(X) ->
	P = pe21:d(X),
	Q = pe21:d(P),
	if Q == X -> io:fwrite("~p, ",[X]);   % Append pair to some list
	true -> timeout
	end.


start() ->
	A = lists:seq(1,10000) -- tools:primes(10000),
	[spawn(pe21,tamic,[X])||X<-A].


% Remember to subtract the perfect numbers because they're not proper 'pairs'. A technicality via PE.