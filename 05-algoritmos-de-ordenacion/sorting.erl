-module(sorting).

-export([quicksort/1, mergesort/1]).

quicksort([]) ->
	[];
quicksort([Hd | []]) ->
	[Hd];
quicksort([Hd | Tl]) ->
	Menores = quicksort(lists:filter(fun(X) -> X =< Hd end, Tl)),
	Mayores = quicksort(lists:filter(fun(X) -> X  > Hd end, Tl)),
	lists:append(Menores, [Hd | Mayores]).
	
mergesort([]) ->
	[];
mergesort([Hd | []]) ->
	[Hd];
mergesort(List) when length(List) > 1 ->
	{List1, List2} = lists:split(length(List) div 2, List),
	ms_ordering([], mergesort(List1), mergesort(List2)).
	
%% -----------------------------------------------
%%	Realiza a fusión das dúas metades dunha lista
%% -----------------------------------------------	

ms_ordering(Res, [], []) ->
	lists:reverse(Res);
ms_ordering(Res, [], List) ->
	lists:append(lists:reverse(Res), List);
ms_ordering(Res, List, []) ->
	lists:append(lists:reverse(Res), List);
ms_ordering(Res, [Hd1 | Tl1], [Hd2 | Tl2]) ->
	if Hd1 =< Hd2 ->
		ms_ordering([Hd1 | Res], Tl1, [Hd2 | Tl2]);
	   true ->
	    ms_ordering([Hd2 | Res], [Hd1 | Tl1], Tl2)
	end.
