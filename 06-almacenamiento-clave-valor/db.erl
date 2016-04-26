-module(db).

-export([new/0, write/3, delete/2, read/2, match/2, destroy/1]).

new() ->
	{dbRef, []}.

write(Key, Value, {dbRef, Data}) ->
	{dbRef, [{Key, Value} | Data]};
write(Key, Value, []) ->
	{dbRef, [{Key, Value} | []]}.

delete(Key, {dbRef, Data}) ->
	delete_rec(Key, Data, []);
delete(_Key, _) ->
	{dbRef, []}.

read(_Key, {dbRef, []}) ->
	{error, instance};
read(Key, {dbRef, [{K, V} | _Tl]}) when Key =:= K ->
	{ok, V};
read(Key, {dbRef, [{K, _V} | Tl]}) when Key =/= K ->
	read(Key, {dbRef, Tl});
read(_Key, _) ->
	{error, instance}.

match(Value, {dbRef, Data}) ->
	match_rec([], Value, Data);
match(_Value, _) ->
	{error, instance}.

destroy(_DbRef) ->
	ok.

%% ------------------------------------

delete_rec(_Key, [], List) ->
	{dbRef, reverse([], List)};
delete_rec(Key, [{K, _V} | Tl], List) when Key =:= K ->
	{dbRef, reverse([], append([], [Tl, List]))};
delete_rec(Key, [{K, V} | Tl], List) when Key =/= K ->
	delete_rec(Key, Tl, [{K, V} | List]).

reverse([], []) ->
	[];	
reverse(List, [Hd | []]) ->
	[Hd | List];
reverse(List, [Hd | Tl]) ->
	reverse([Hd | List], Tl).
	
append(List, []) ->
	reverse([], List);
append(List, [[] | Lists]) ->
	append(List, Lists);
append(List, [[Hd | Tl] | Lists]) ->
	append([Hd | List], [Tl | Lists]).
	
match_rec(Matching, _Value, []) ->
	Matching;
match_rec(Matching, Value, [{K, V} | Data]) when Value =:= V ->
	match_rec([K | Matching], Value, Data);
match_rec(Matching, Value, [{_K, V} | Data]) when Value =/= V ->
	match_rec(Matching, Value, Data).
	










