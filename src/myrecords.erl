%% @author jacy
%% @doc @todo Add description to myrecords.


-module(myrecords).

%% ====================================================================
%% API functions
%% ====================================================================
-compile(export_all).
-include("myrecords.hrl").
-import(myio,[println/1]).

%% ou can also declare records directly in the shell with the rd/2 function, 
%% but if you’re doing anything more than just poking around, it’s easier to
%% have them in a more reliable formal imported declaration. You can call rl/0
%% if you want to see what records are defined, or rl/1 if you want to see how a specific record is defined


demo() ->
	Johnson = #person{name ="Johnson"},
	Admin = #user{name="David", password=111},
	%% 1. use . to access record entries
	io:format("name=~p,age=~p,description=~p ~n", [Johnson#person.name,Johnson#person.age,Johnson#person.description]),

	%% 2. use pattern match to access record entries
	#user{name=Match_name,password=Match_pwd} = Admin, 
	io:format("name=~p,password=~p ~n", [Match_name, Match_pwd]),
	
	%% create a new record based on the values of an old one
	Diy_Admin = Admin#user{name="Lina"},
	println(Diy_Admin),
	end_demo.

%% pattern match against records
match(#person{} = T) ->
	io:format("name=~p,age=~p,description=~p ~n", [T#person.name,T#person.age,T#person.description]),
	end_match.
	
match_v2(Person) -> case Person of
		#person{name="Lina"} -> println("Catch you ^_^");
		#person{name="Jacy"} -> println("Jacy, please run away /\\/\\")
		end,
	end_match.

match_v3(#person{name=N, description=D} = T) ->
	io:format("name=~p,age=~p,description=~p ~n", [N,T#person.age,D]),
	end_match.
	

%% ====================================================================
%% Internal functions
%% ====================================================================


