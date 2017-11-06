%% @author Lukas
%% @doc @todo Add description to ksort.


-module(ksort).

%% ====================================================================
%% API functions
%% ====================================================================
-export([qsort/3, msort/1]).


%% ====================================================================
% Fall der Error wirft immer wenn SN = 0, keine Ahnung warum
% ksort:qsort(right,[12,9,4,99,120,1,3,10,1,2,4],0).
qsort(_pivotcase,L,SN) when SN > length(L) -> ssort:selectionS(L);

qsort(left,[H|T], SN) -> 
	{Smaller,Bigger} = qsort_(H,[],[],T),
	qsort(left, Smaller, SN) ++ [H] ++ qsort(left, Bigger, SN);

qsort(middle,L,SN) -> 	
	Pivot = middle(L),
	{Smaller,Bigger} = qsort_(Pivot,[],[],L -- [Pivot]),
	qsort(middle, Smaller, SN) ++ [Pivot] ++ qsort(middle, Bigger, SN);

qsort(right,L,SN) -> 
	Pivot = lists:last(L),
	{Smaller,Bigger} = qsort_(Pivot,[],[],L -- [Pivot]),
	qsort(right, Smaller, SN) ++ [Pivot] ++ qsort(right, Bigger, SN);

qsort(median,L,SN) -> 
	Pivot = median(hd(L), lists:last(L), middle(L)),
	{Smaller,Bigger} = qsort_(Pivot,[],[],L -- [Pivot]),
	qsort(right, Smaller, SN) ++ [Pivot] ++ qsort(right, Bigger, SN);

qsort(random,L, SN) -> 
	Pivot = lists:nth(rand:uniform(1,length(L)+1), L),
	{Smaller,Bigger} = qsort_(Pivot,[],[],L -- [Pivot]),
	qsort(random, Smaller, SN) ++ [Pivot] ++ qsort(random, Bigger, SN).

median(L, R, M) when (L =< R) and (R =< M) -> R;
median(L, R, M) when (M =< R) and (R =< L) -> R;
median(L, R, M) when (L =< M) and (M =< R) -> M;
median(L, R, M) when (R =< M) and (M =< L) -> M;
median(L, R, M) when (M =< L) and (L =< R) -> L.

middle(L) -> lists:nth((1+length(L) div 2), L).

qsort_(_Pivot,Smaller, Bigger,[]) -> {Smaller,Bigger}; 
qsort_(Pivot,Smaller, Bigger,[H|T]) when H < Pivot -> 
	qsort_(Pivot,Smaller ++ [H], Bigger,T);
qsort_(Pivot,Smaller, Bigger,[H|T]) -> 
	qsort_(Pivot,Smaller, Bigger ++ [H],T).

%% ====================================================================
halbe_liste(Laenge) ->
	Laenge_rem_2 = Laenge rem 2, 
	
	if Laenge_rem_2 == 1 ->
		(Laenge div 2)+1;
	true ->
		(Laenge div 2)					
	end.

msort([]) -> 
	[];
	
msort([Element]) -> 
	[Element];

msort(Liste) ->
	{Links, Rechts} = zerlegen(Liste),
	merge({msort(Links), msort(Rechts)}).
	

zerlegen(Liste) ->

	Laenge = length(Liste),
	Laenge_halb = halbe_liste(Laenge),
	lists:split(Laenge_halb, Liste).

merge({Links, []}) -> Links;

merge({[], Rechts}) -> Rechts;

merge({[ElementLinks|RestLinks], [ElementRechts|RestRechts]}) ->
    	if ElementLinks < ElementRechts ->
			[ElementLinks | merge({RestLinks, [ElementRechts|RestRechts]})];
        true -> 
			[ElementRechts | merge({[ElementLinks|RestLinks], RestRechts})]
    end.

		
	