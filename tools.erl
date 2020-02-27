-module(tools).
-author("Zachariah Aslam - XaC .IM").

-export([primes/1,isqrt3a/1,isqrt4/1,combos/2,combos/1,d/1,pdivs/1,padl/2,bl/2]).

% Brute-Force Prime dividor list maker (INCLUDES SELF)
pdivs(N) -> lists:concat([[X,(N div X)] || X <- lists:seq(1,(tools:isqrt3a(N))), N rem X == 0]).
d(N) -> lists:sum(sets:to_list(sets:from_list(lists:delete(N,tools:pdivs(N))))).

% method via matt_h

primes(Prime, Max, Primes,Integers) when Prime > Max ->
    lists:reverse([Prime|Primes]) ++ Integers;
primes(Prime, Max, Primes, Integers) ->
    [NewPrime|NewIntegers] = [ X || X <- Integers, X rem Prime =/= 0 ],
    primes(NewPrime, Max, [Prime|Primes], NewIntegers).

primes(N) ->
    primes(2, round(math:sqrt(N)), [], lists:seq(3,N,2)). % skip odds
	
% sqrt binary search

isqrt3a(N) when erlang:is_integer(N), N >= 0 ->
    isqrt3a(N, 1, N).

isqrt3a(N, Low, High) when Low >= High ->
    HighSqr = High * High,
    if
        HighSqr > N ->
            High - 1;
        HighSqr =< N ->
            High
    end;

isqrt3a(N, Low, High) ->
    Mid = (Low + High) div 2,
    MidSqr = Mid * Mid,
    if
        %% This also catches N = 0 or 1
        MidSqr =:= N ->
            Mid;
        MidSqr < N ->
            isqrt3a(N, Mid + 1, High);
        MidSqr > N ->
            isqrt3a(N, Low, Mid - 1)
    end.

% Newton's method for sqrt

isqrt4(0) -> 0;

isqrt4(N) when erlang:is_integer(N), N >= 0 ->
    isqrt4(N, N).

isqrt4(N, Xk) ->
    Xk1 = (Xk + N div Xk) div 2,
    if
        Xk1 >= Xk ->
            Xk;
        Xk1 < Xk ->
            isqrt4(N, Xk1)
    end.
	
 % Seth Ladd's Combination function for Erlang
combos(L) -> combos(L, bit_masks(length(L))).

combos(L, [BH|BT]) ->
  [mask_list(L, BH)|combos(L, BT)];
combos(_, []) -> [].

mask_list([H|T], [BH|BT]) ->
  case (BH) of
    1 -> [H|mask_list(T, BT)] ;
    0 -> mask_list(T, BT)
  end;
mask_list([], []) -> [].

bit_masks(NumColumns) ->
  bit_masks(0, round(math:pow(2, NumColumns))-1, NumColumns).

bit_masks(Max, Max, NumColumns) ->
  [padl(NumColumns, bl(Max))];

bit_masks(X, Max, NumColumns) ->
  [padl(NumColumns, bl(X)) | bit_masks(X+1, Max, NumColumns)].

padl(N, L) when N =:= length(L) -> L ;
padl(N, L) when N > length(L) -> padl(N, [0|L]).

bl(N) -> bl(N, []).

bl(0, Accum) -> Accum;
bl(N, Accum) -> bl(N bsr 1, [(N band 1) | Accum]).