%% @author jacy
%% @doc @todo Add description to my_gen_server.


-module(my_gen_server).
-behavior(gen_server). % Using the gen_server behavior

%% Declare macros using -define. Macros are simple text replacements. 
%% This declaration tells the compiler that any time it encounters ?SERVER, it should replace it with ?MODULE. 
%% ?MODULE is a built-in macro that always refers to the name of the module it appears in. 
%% In this case, that means it will be processed into my_gen_server
-define(SERVER, ?MODULE). 

-import(myio,[println/1]).
-export([start_link/0, demo/0]). % custom api functions
-export([init/1,handle_call/3,handle_cast/2,handle_info/2,terminate/2,code_change/3]). % gen_server callbacks

-record(state,{count=0}). % define a record has only one field

%% ====================================================================
%% gen_server callback functions
%% ====================================================================
init([]) -> println("init"), {ok, #state{}}. % Set up the process, triggered by gen_server:start_link()

%% Handle synchornous calls, triggered by gen_server:call()
handle_call(Request, _From, State) ->
		Reply = {ok,fall_velocity(Request)},
		NewState = #state{count = State#state.count + 1},
		{reply,Reply, NewState}.

%% Handle asynchornous calls, triggered by gen_server:cast()
handle_cast(_Msg, State) ->
		io:format("handle_cast: so far, caculated ~w velocities ~n",[State#state.count]),
		{noreply, State}.
	
handle_info(_Info, State) -> println("handle_info"), {noreply, State}. % Deals with non-opt messages, triggered by random messages

terminate(_Reason, _State) -> println("terminate"), ok. % triggered by failure or shutdown singal from supervisor

code_change(_OldVsn, State, _Extra) ->  println("code_change"), {ok, State}. % Swich out codes without losing state, triggered by sytem libaries for code upgrades
%% ====================================================================
%% API functions
%% ====================================================================

%% The first argument, a tuple, opens with an atom that must be local or global, depending on whether you want the name of the process
%% registered just with the local Erlang instance or with all associated nodes.
start_link() -> gen_server:start_link({local, ?SERVER}, ?MODULE, [ ],[ ]). % Call only once when debug in shell

%% call start_link in advance, modify and  recompile to test the code_change.
demo() -> 
	println(gen_server:call(?MODULE, 20)), % trigger call back: handle_call
	println(gen_server:call(?MODULE, 40)), % trigger call back: handle_call
	println(gen_server:call(?MODULE, 60)), % trigger call back: handle_call
	println(gen_server:cast(?MODULE, {})), % trigger call back: handle_cast
end_demo.

%% ====================================================================
%% Internal functions
%% ====================================================================
fall_velocity(Distance) -> math:sqrt(2 * 9.1 * Distance).

