-module(crossring).

-export([start/3]).

-export([create/3, loop_nx/4, loop/2]).

% El proceso original creará dos anillos quedando él mismo como nexo entre ambos
start(NumProc, NumMsg, Message) ->
	Half = NumProc div 2,
	% Si NumProc es par, un anillo tendrá un proceso de más (pues hay un nexo común)
	if	NumProc rem 2 =:= 0 ->
			Even = 1;
		NumProc rem 2 =/= 0 ->
			Even = 0
	end,
	FstRingNext = spawn(?MODULE, create, [self(), Half-1, NumMsg]),
	% El segundo anillo se lleva el proceso extra, de haberlo
	SndRingNext = spawn(?MODULE, create, [self(), Half-1+Even, NumMsg]),
	% El nexo recibe los mensajes el doble de veces que los demás procesos
	loop_nx(Message, FstRingNext, SndRingNext, 2*NumMsg),
	ok.
	
% El último proceso en crearse tiene por receptor el proceso original (el nexo)
create(NxPid, 1, NumMsg) ->
	loop(NxPid, NumMsg),
	ok;
create(NxPid, NumProc, NumMsg) ->
	Next = spawn(?MODULE, create, [NxPid, NumProc-1, NumMsg]),
	loop(Next, NumMsg),
	ok.

%% El primero tiene la peculiaridad de que debe empezar enviando mensajes en lugar de recibiendo
loop_nx(Message, FstRingNext, SndRingNext, NumMsg) ->
	% Si el NumMsg es par, el mensaje entra en el primer anillo
	if	NumMsg div 2 =:= 0 ->
			FstRingNext ! {msg, Message};
	% Si es impar, el mensaje debe entrar en el segundo anillo
		NumMsg div 2 =/= 0 ->
			SndRingNext ! {msg, Message}
	end,
	receive
		{msg, Message} ->
			if NumMsg =:= 1 ->
				ok;
			   NumMsg > 1 ->
				loop_nx(Message, FstRingNext, SndRingNext, NumMsg-1)
			end;
		Other ->
			io:format("Process ~p received some kind of weird message ~s!~n", [self(), Other])
	end.

% Este bucle no cambia con respecto a un anillo normal
loop(Next, NumMsg) ->
	receive
		{msg, Message} ->
			Next ! {msg, Message},
			if NumMsg =:= 1 ->
				ok;
			   NumMsg > 1 ->
				loop(Next, NumMsg-1)
			end;
		Other ->
			io:format("Process ~p received some kind of weird message ~s!~n", [self(), Other])
	end.
