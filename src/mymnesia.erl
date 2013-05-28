%% @author jacy
%% @doc @todo Add description to mymnesia.


-module(mymnesia).

%% ====================================================================
%% API functions
%% ====================================================================
-compile(export_all).
-include("myrecords.hrl").
-import(myio,[println/1]).

	%% You should consider shifting from ETS (and DETS) tables to the Mnesia database if:
	%•	You need to store and access data across a set of nodes, not just a single node. 
	%•	You don’t want to have to think about whether you’re going to store data in memory or on a disk or both. 
	%•	You need to be able to roll back transactions if something goes wrong. 
	%•	You’d like a more approachable syntax for finding and joining data. 
	%•	Management prefers the sound of “database” to the sound of “tables”.


%% If you want to store data on disk, you need to give Mnesia some information. 
%% Before you turn Mnesia on, you need to create a database, using the mnesia:create_schema/1 function.

setup() ->
	%% You’ll see a new directory with a name like Mnesia.nonode@nohost.
	%% Initially, it holds a LATEST.LOG file and a schema.DAT file.
	%% The node() function just returns the identifier of the node you’re on
	mnesia:create_schema([node()]), % Store schema data in the directory where you are when you start it

	mnesia:start(), % Unlike ETS and DETS, which are always available, you need to turn Mnesia on

	mnesia:create_table(person,[{attributes, record_info(fields,person)}]),
end_setup.

%% Like ETS, Mnesia’s basic concept of a table is a collection of records. 
%% It also offers set, ordered_set,and bag options,j but doesn’to offer duplicate_bag.
tables() ->
	setup(),
	F= fun() -> 
		mnesia:write(#person{name="Jacy",age=1, description=bbbj}),
		mnesia:write(#person{name="name_B",age=5}),
		mnesia:write(#person{name="name_C",age=10})
	end,
%% Mnesia will restart the transaction if there is other activity blocking it, so the code may get executed repeatedly 
%% before the transaction happens. Because of this, do not include any calls that create side effects to the function 
%% you’ll be passing to mnesia:transaction, and don’t try to catch exceptions on Mnesia functions within a transaction. 
%% If your function calls abort, the transaction will be rolled back, returning a tuple beginning with aborted instead of atomic.
	mnesia:transaction(F),
	println(mnesia:table_info(person, all)),
	println(mnesia:transaction(fun() -> mnesia:read(person,"Jacy") end)),
end_Tables.


%% ====================================================================
%% Internal functions
%% ====================================================================


