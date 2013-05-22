%% @author jacy
%% @doc @todo Add description to lists.


-module(mylists).

%% ====================================================================
%% API functions
%% ====================================================================
-export([demo/0,head_tail/0]).
-import(myio, [println/1]).

%% The elements can be of any type, including numbers, atoms, tuples, strings, and other lists. 
demo() -> 
	Ints = [1,2,3,4,5],
	Mixs = [atoms, "Strings", {tuple_Name, tuple_Value}, Ints],
	[1, X, Y] = [1, 3, Mixs], % Pattern match with list, in this case X matches 3 while Y gets Mixs.
	println(X),
	println(Y),
	println(lists:append(Ints,Mixs)),
	println(Ints ++ Mixs), % The ++ operator is right associative, which can change the order of the resulting list when you append multiple lists.
	println(lists:flatten(Mixs)),
	println(lists:seq(1,10)), % seq function of lists is useful.
	println(lists:seq($A,$Z)),
	endAtom. % Convert List of List to elements of List.

head_tail() ->
	Ints = [1,2],
	[H1 | T1] = Ints,
	println(H1),
	println(T1),
	[H2 | T2] = T1,
	println(H2),
	println(T2), % T2 gets Empty list
	endHeadTail.
%% ====================================================================
%% Internal functions
%% ====================================================================