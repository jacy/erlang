%% @author jacy
%% @doc @todo Add description to simple_recursion.


-module(simple_recursion).

%% ====================================================================
%% API functions
%% ====================================================================

% Greate than >= or Less than =< 
-export([count_down/1,count_down_v2/1, countup/1, factorial/1,factorial_tail_recursion/1]).

count_down(Num) when Num > 0 -> io:format("~w!~n",[Num]),count_down(Num - 1);
count_down(_) -> io:format("blastoff!~n").

count_down_v2(Num)  -> if Num > 0 -> io:format("~w!~n",[Num]),count_down(Num - 1);
						  Num =< 0 -> io:format("blastoff!~n")
					   end.

countup(Num) -> countup(1,Num).

factorial(Num) when Num > 1 -> Num * factorial(Num -1);
factorial(_) -> 1.

factorial_tail_recursion(Num) -> factorial(1, Num).
%% ====================================================================
%% Internal functions
%% ====================================================================
countup(Count,Num) when Count =< Num -> io:format("~w!~n",[Count]),countup(Count+1,Num);
countup(_,_) -> io:format("finished!~n").

factorial(Sum,Num) when Num > 1 -> factorial(Sum * Num,Num -1);
factorial(Sum, _) -> Sum.