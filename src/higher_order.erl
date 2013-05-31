%% @author jacy
%% @doc @todo Add description to higher_order.


-module(higher_order).

%% ====================================================================
%% API functions
%% ====================================================================
-compile(export_all).
-import(myio, [println/1]).

demo() -> 
	Fall_velocity = fun(Distance) -> math:sqrt(2 * 9.8 * Distance) end,
	println(triple(5,Fall_velocity)),
	println(triple(2, fun(X) -> math:pow(X,10) end)),
	println(triple(2, fun math:cos/1)), %Pass a function from a built-in module
	end_demo.

%% List comprehension: NewList = [Expression || Pattern <- List, Condition1, Condition2, ... ConditionN]
lists() ->
	List = [1,2,3,4],
	Double = fun(X) -> X * 2  end,
	lists:foreach(fun myio:println/1,List), %foreach returns atom ok
	println(lists:map(Double,List)), %create a new list base on List
	%% A list comprehension uses || syntax
	%% Thist can reads "Create a list consisting of squares of a Value, where the Value comes from List.”"
	println([Double(X) || X <- List]), %create a new list base on List
	println([X * X || X <- List]), % Expression on the left doesn’t have to be declared as a function
	GreateThan3 = fun(X) -> X >= 3 end,
	println(lists:filter(GreateThan3, List)),
	println([X || X <- List, X >= 3]), % Same effect with a list comprehension
	println(lists:partition(GreateThan3,List)), % return a tuple that contains the matched items in its first element, and the unmatched items in its second

	println(test_List_with_all_or_any),
	println(lists:all(GreateThan3,List)),
	println(lists:any(GreateThan3,List)),

	println(take_whild_and_drop_whild),
	TestList = [1,2,3,4,5,2,1],
	LessThan4 = fun(X) -> X < 4 end,
	%% Both functions run through a list from head to tail and stop when they reach a value 
	%% for which the function you provide as the first argument returns false.
	println(lists:takewhile(LessThan4,TestList)),
	println(lists:dropwhile(LessThan4,TestList)),
	println(lists:takewhile(GreateThan3,TestList)), % Stop at first element for it return false, so nothing is taken.
	println(lists:dropwhile(GreateThan3,TestList)), % Stop at first element for it return false, so nothing is drop.
	
	%% folding list with accumulator
	Sum= fun(Value,Accumulator)  -> Value + Accumulator end,
	Foldlist = [1,2,3,4,5,6,7,8,9,10],
	InitValue = 0,
	println(lists:foldl(Sum, InitValue, Foldlist)),
	println(lists:foldr(Sum, InitValue, Foldlist)),
	end_lists. 

%% ====================================================================
%% Internal functions
%% ====================================================================
triple(Value, Function) -> 3 * Function(Value).

