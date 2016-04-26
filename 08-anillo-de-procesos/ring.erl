-module(ring).

-export([start/3]).

-export([create/3, loop/2, loop_fst/3]).

start(NumProc, NumMsg, Message) ->
	Next = spawn(?MODULE, create, [self(), NumProc-1, NumMsg]),
	loop_fst(Message, Next, NumMsg),
	ok.
	
% El último proceso en crearse tiene por receptor el proceso original
create(FstPid, 1, NumMsg) ->
	loop(FstPid, NumMsg),
	ok;
create(FstPid, NumProc, NumMsg) ->
	Next = spawn(?MODULE, create, [FstPid, NumProc-1, NumMsg]),
	loop(Next, NumMsg),
	ok.

%% El primero tiene la peculiaridad de que debe empezar enviando mensajes en lugar de recibiendo
loop_fst(Message, Next, NumMsg) ->
	Next ! {msg, Message},
	io:format("Process ~p forwarded the message ~s to process ~p!~n", [self(), Message, Next]),
	receive
		{msg, Message} ->
			io:format("Process ~p received message ~s!~n", [self(), Message]),
			if NumMsg =:= 1 ->
				io:format("---Process ~p received all its messages. It will terminate itself now.~n", [self()]),
				ok;
			   NumMsg > 1 ->
				loop_fst(Message, Next, NumMsg-1)
			end;
		Other ->
			io:format("Process ~p received some kind of weird message ~s!~n", [self(), Other])
	end.

loop(Next, NumMsg) ->
	receive
		{msg, Message} ->
			io:format("Process ~p received message ~s!~n", [self(), Message]),
			Next ! {msg, Message},
			io:format("Process ~p forwarded the message ~s to process ~p!~n", [self(), Message, Next]),
			if NumMsg =:= 1 ->
				io:format("---Process ~p received all its messages. It will terminate itself now.~n", [self()]),
				ok;
			   NumMsg > 1 ->
				loop(Next, NumMsg-1)
			end;
		Other ->
			io:format("Process ~p received some kind of weird message ~s!~n", [self(), Other])
	end.
