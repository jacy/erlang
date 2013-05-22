%% @author jacy
%% @doc @todo Add description to strings.


-module(strings).

%% ====================================================================
%% API functions
%% ====================================================================
-export([print/0,term/0,chars/0,line/0]).

print() ->
	X = "He said: \" I Hate You ! \" \n",
	Y = "Whatever ! ~n",
	io:format(X ++ Y),
	io:format(string:concat(X,Y)),
	io:format("text"=="text").

term() -> Input = io:read("what {planemo,distance} ? >>"),
		  io:format(Input),
		  In = element(2,Input),
		  io:format("get Input:~w ~n",["" ++ In]),
		  io:format("isTuple:~w ~n",["" ++ is_tuple(In)]).

chars() -> io:format("Which planemo are you on ? ~n"),
		   io:format("1. Earth ~n"),
		   io:format("2. Earth's Moon ~n"),
		   io:format("3. Mars ~n"),
		   io:get_chars("Which? >",1). % get_chars can not work in eclipse console.

line() -> get_planemo().
%% ====================================================================
%% Internal functions
%% ====================================================================
get_planemo() ->
	io:format("Where are you ? ~n"),
	io:format("	1. Earth ~n"),
	io:format("	2. Earth's Moon ~n"),
	io:format("	3. Mars ~n"),
	Answer = io:get_line("Which? >"),
	Value = hd(Answer), % pulls the first chacter from a string or list.strings are list of numbers, so can instead call lists:nth(1,Answer).
	char_to_planemo(Value).

char_to_planemo(Char) ->
%% Three different ways of testing the character.
	if
		[Char] == "1" -> earth; % put square brackets around Char then can compare it to a string.
		Char == $2 -> moon; % $2 is the value for the character 2.
		Char == 51 -> mars % character value 51 corresponds to character 3.
	end.