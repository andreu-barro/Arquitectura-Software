-module(create).

-export([create/1, reverse_create/1]).

create(N) when N > 0 ->
	create_rec(N, []);
create(_) ->
	[].
	
reverse_create(N) when N > 0 ->
	reverse_rec([], create_rec(N, []));
reverse_create(_) ->
	[].
	
create_rec(1, List) ->
	[1 | List];
create_rec(N, List) ->
	create_rec(N-1, [N | List]).
	
reverse_rec(List, [Hd | []]) ->
	[Hd | List];
reverse_rec(List, [Hd | Tl]) ->
	reverse_rec([Hd | List], Tl).
