%% @author jacy
%% @doc @todo Add description to myets.


-module(myets).

%% ====================================================================
%% API functions
%% ====================================================================
-compile(export_all).
-include("myrecords.hrl").
-import(myio,[println/1]).


%% Every entry in an ETS tables is a tuple (or corresponding record), and one piece of the tuple is designated the key. 
%% By default, ETS tables are sets, but you can specify one of the other options when you create a table.

%%% ETS Types
%% 1) Sets: Can contain only one entry with a given key. This is the default.
%% 2) Ordered sets: Same as a set, but also maintains a traversal order based on the keys. Great for anything you want to keep in alphabetic or numeric order.
%% 3) Bags: Lets you store more than one entry with a given key. However, if you have multiple entries that have completely identical values, they get combined into a single entry.
%% 4) Duplicate bags: Not only lets you store more than one entry with a given key, but also lets you store multiple entries with completely identical values.

%% 1. Every table has a name, but only some can be reached using that name. If you don’t specify named_table, 
%% the name is there but visible only inside the database. You’ll have to use the value returned by ets:new/2 to 
%% reference the table. If you do specify named_table, processes can reach the table as long as they know the name, 
%% without needing access to that return value.

%% 2. The other important option, especially for ETS tables containing records, is the keypos tuple. 
%% By default, ETS treats the first value in a tuple as the key. Using the keypos tuple lets you specify
%% which record value should be the key

%% Use tv:start() to keep track of the table in a separate window
sets() ->
	%% You can set up only one ETS table with the same name. If you call sets() twice, you’ll get an error.
	%% Use f() shell command to clear out any previous tables whild debuging.
	%% Use ets:info/1 to test if a table exist or not.
	PersonTable = ets:new(person,[named_table,{keypos,#person.name}]),
	println(ets:info(PersonTable)), % View table summary.
	
	generate_items(PersonTable),
	println(ets:info(PersonTable)),
	println(ets:tab2list(PersonTable)), % View table details.

	%% Use ets:lookup/2 to look up records
	println(ets:lookup(PersonTable, "name_A")), % Always return a list.
	println(hd(ets:lookup(PersonTable, "name_A"))), % hd() to return head of the list.
	println(ets:lookup(PersonTable, "not_Exists")), % return a empty list.
end_sets.

%% %% ETS can overwrite the value of variable, or change the value of an item in a list.
overide_values() ->
	PersonTable = ets:new(person,[named_table,{keypos,#person.name}]),
	generate_items(PersonTable),
	println(hd(ets:lookup(PersonTable, "name_A"))),
	ets:insert(PersonTable, #person{name="name_A",age=1111,description=new_desc}), % Modify values of name_A
	println(hd(ets:lookup(PersonTable, "name_A"))),
	ets:delete(PersonTable, "name_A"), % Delete item
	println(ets:lookup(PersonTable, "name_A")),
end_overide_values.

%% ====================================================================
%% Internal functions
%% ====================================================================
generate_items(PersonTable) ->
	ets:insert(PersonTable, #person{name="name_A",age=1}),
	ets:insert(PersonTable, #person{name="name_B",age=5}),
	ets:insert(PersonTable, #person{name="name_C",age=10}),
	ets:insert(PersonTable, #person{name="name_D",age=9}),
	ets:insert(PersonTable, #person{name="name_E",age=6}),
	ets:insert(PersonTable, #person{name="name_F",age=7}),
end_generated.