-module(echo).

-export([start/0, stop/0, print/1]).

-export([loop/0]).

-define(ECHO, ?MODULE).

start() ->
	register(?ECHO, spawn(?MODULE, loop, [])),
	ok.
	
stop() ->
	?ECHO ! stop,
	catch unregister(?ECHO),
	ok.
	
print(Term) ->
	?ECHO ! {print, Term},
	ok.
	
	
loop() ->
	receive
		{print, Term} ->
			io:format("~s~n", [Term]),
			loop();
		stop ->
			ok;
		_ ->
			loop()
	
	end.
