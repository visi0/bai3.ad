%% @author Lukas
%% @doc @todo Add description to testsort.


-module(testsort).

%% ====================================================================
%% API functions
%% ====================================================================
-export([createL/2,testSelectionS/1,testInsertionS/1,testMergeS/1]).




%% Num = Anzahl von Zahlen die in der Liste vorhanden sein solllen.
%% Art = Art der Liste. sort für eien sortierte Liste. rnd für eine Randomliste.
%% resort für eine umgedreht sortierte Liste.
createL(Num, Art) ->
		case Art of
			sort -> util:sortliste(Num);
			rnd -> util:randomliste(Num);
			resort -> util:resortliste(Num)
		end.

testSelectionS(Liste) -> 
	io:fwrite(util:timeMilliSecond()),
	ssort:selectionS(Liste),
	io:fwrite(util:timeMilliSecond()).

testInsertionS(Liste) -> 
	io:fwrite(util:timeMilliSecond()),
	ssort:insertionS(Liste),
	io:fwrite(util:timeMilliSecond()).

testMergeS(Liste) -> 
	io:fwrite(util:timeMilliSecond()),
	ksort:msort(Liste),
	io:fwrite(util:timeMilliSecond()).

