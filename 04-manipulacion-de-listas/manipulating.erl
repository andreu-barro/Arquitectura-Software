-module(manipulating).

-export([filter/2, reverse/1, concatenate/1, flatten/1]).

filter([], _) ->
	[];
filter(List, N) ->
	reverse(filter_rec([], List, N)).

reverse([Hd | []]) ->
	[Hd];
reverse([Hd | Tl]) ->
	reverse_rec([], [Hd | Tl]);
reverse(_) ->
	[].
	
concatenate([]) ->
	[];
concatenate(Lists) ->
	concatenate_rec([], Lists).

flatten([]) ->
	[];
flatten(Lists) ->
	flatten_rec([], Lists).

%% ----------------------------------------
	
filter_rec(List, [], _N) ->
	List;
filter_rec(List, [Hd | Tl], N) when Hd =< N ->
	filter_rec([Hd | List], Tl, N);
filter_rec(List, [Hd | Tl], N) when Hd > N	->
	filter_rec(List, Tl, N).
	
reverse_rec(List, [Hd | []]) ->
	[Hd | List];
reverse_rec(List, [Hd | Tl]) ->
	reverse_rec([Hd | List], Tl).
	
concatenate_rec(List, []) ->
	reverse(List);
concatenate_rec(List, [[] | Lists]) ->
	concatenate_rec(List, Lists);
concatenate_rec(List, [[Hd | Tl] | Lists]) ->
	concatenate_rec([Hd | List], [Tl | Lists]).
	
flatten_rec(List, []) ->
	reverse(List);
flatten_rec(List, [[] | Lists]) ->
	flatten_rec(List, Lists);
flatten_rec(List, [Hd | Tl]) when is_list(Hd) =:= true ->
	flatten_rec(List, [hd(Hd) | [tl(Hd) | Tl]]);
flatten_rec(List, [Hd | Tl]) when is_list(Hd) =:= false ->
	flatten_rec([Hd | List], Tl).
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
