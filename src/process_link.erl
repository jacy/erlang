%% @author jacy
%% @doc @todo Add description to process_link.


-module(process_link).

%% ====================================================================
%% API functions
%% ====================================================================
-compile(export_all).
-import(myio, [println/1]).


%% When a process crashes (e.g. failure of a BIF or a pattern match) Exit Signals are sent to all 
%% processes to which the failing process is currently linked.
p_create_link_p() ->
	process_flag(trap_exit,true),
	Pid2 = spawn_link(process_link, handle_error_receive, []), %% Link Pid2 to Pid1
	Pid2 ! "Send Msg",
	error_receive().

error_receive() ->
		receive Num -> println(Num * 2),
				error_receive() end.

handle_error_receive() ->
	receive 
		{"EXIT", Pid, Reason} -> io:format("~p died because of ~p ~n",[Pid, Reason]);
		Msg -> println(Msg), handle_error_receive() end.

demo_link() ->
	Pid1 = spawn(process_link, p_create_link_p, []),
	Pid1 ! "deliberate not number". %% Cause Pid1 to exit, which will cause its link process to exit. 


%% ====================================================================
%% Internal functions
%% ====================================================================

%% For Test Only
length(List) -> length(0,List).
length(Length,[]) -> Length;
length(Length,[_ | T]) -> length(Length + 1, T).

%% Reverse
reverse(List) -> reverse(List,[]).
reverse([],New) -> New;
reverse([H|T],New) -> reverse(T, [H | New]).

