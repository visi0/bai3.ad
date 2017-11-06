%% @author Lukas


-module(ssort).

%% ====================================================================
%% API functions
%% ====================================================================
-export([selectionS/1, insertionS/1]).



insertionS([]) -> [];
insertionS([E]) -> [E];
insertionS([T|H]) -> insertionS([T],H).

insertionS(SL,[]) -> SL;
insertionS(SL,[T|H]) -> insertionS(compare(T,SL), H).

compare(Ele, []) -> [Ele];
compare(Ele, [T|H]) when T >= Ele -> [Ele,T|H];
compare(Ele,[T|H]) -> [T| compare(Ele,H)].

%% -------------------------------------------------------------------------------------
selectionS([]) -> [];
selectionS(UnsL) -> 
		Min = min(UnsL),
		[Min] ++ selectionS(delete(UnsL,Min)).

%%Findet das kleinste Element in der Liste und gibt dieses wieder.
min([H|T]) -> min_(H, [H|T]).
min_(E, []) -> E;
min_(E, [H|T]) when H < E -> min_(H, T);
min_(E, [_H|T]) -> min_(E, T).

%%Löscht das ein Element aus der Liste und gibt diese wieder.
delete([], _) -> [];
delete([E|T], E) -> T;
delete([H|T],E) -> [H] ++ delete(T,E).