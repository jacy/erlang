%% @author jacy
%% @doc @todo Add description to lists.


-module(mylists).

%% ====================================================================
%% API functions
%% ====================================================================
-compile(export_all). %Making all functions available for external calls
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
	println(lists:flatten(Mixs)), % Convert List of List to elements of List.
	println(lists:seq(1,10)), % seq function of lists is useful.
	println(lists:seq($A,$Z)),
	end_demo.

head_tail() ->
	Ints = [1,2],
	[H1 | T1] = Ints,
	println(H1),
	println(T1),
	[H2 | T2] = T1,
	println(H2),
	println(T2), % T2 gets Empty list
	end_head_tail.

recursion_list([]) -> 0;
recursion_list(List) -> recursion_list(List, 1).

build_list_with_head_tail() ->
	println([1 | [2]]),
	println([1 , 2 | [3] ]),
	println([1 , 2 | 3  ]), % If not braces are wraped, will generate a strange tail.
	end_build_list.

list_funs() ->
	println(lists:reverse([1,2,3])), % reverse lists
	List1 = [1,2,3],
	List2 = [a,b,c],
	TurpleList = lists:zip(List1,List2),
	println(TurpleList), % List1 and List2 must be have same number of items, zip returns a list containing a tuple for each of the items in the original list
	println(lists:unzip(TurpleList)), % The unzip function takes that list of two-component tuples, and splits it out into a tuple containing two lists
	Keylist=[{1,monday},{2,tuesday}],
	%% keystore params: key value, key position in the tuple, a list, a tuple
	println(lists:keystore(2,1,Keylist, {2,tuesday})), % Just return the list if key has exists
	println(lists:keystore(3,1,Keylist, {3,wednesday})), % If key not exists, the new tuple gets added to the list.
	PlaceList = lists:keyreplace(2,1,Keylist, {2,new_wednesday}),
	println(PlaceList), % Replace a value only if it is present, not add a new value to the list.
	println(lists:keyfind(2,1,PlaceList)), % Find value by key, return tuple.
	end_list_funs.

pasal_triangle(Rows) when Rows > 0 ->
	if Rows == 1 -> next_row([0,1,0], 0, []);
	true -> next_row([0,1,0], 0, []) end.

next_row(Initial) -> next_row(Initial, 0, []). 
next_row([], 0 , Final) -> [0 | Final];
next_row([Head | Tail], AddBy, New) -> next_row(Tail,  Head, [Head + AddBy | New]).
%% ====================================================================
%% Internal functions
%% ====================================================================
recursion_list([],Sum) ->Sum;
recursion_list([Head|Tail],Sum) -> recursion_list(Tail,Sum * Head).