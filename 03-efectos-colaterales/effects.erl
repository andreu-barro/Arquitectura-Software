-module(effects).

-export([print/1, even_print/1]).


print(N) when N > 1 ->
	print(N-1),
	io:format("~B ", [N]);
print(_) ->
	io:format("~B ", [1]).
	
even_print(N) when N > 2 andalso N rem 2 =:= 0 ->
	even_print(N-2),
	io:format("~B ", [N]);
even_print(N) when N > 2 andalso N rem 2 =/= 0 ->
	even_print(N-3),
	io:format("~B ", [N-1]);
even_print(2) ->
	io:format("~B ", [2]);
even_print(_) ->
	io:format("").
