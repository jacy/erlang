%% @author jacy
%% @doc @todo Add description to process_link.


-module(process_link).

%% ====================================================================
%% API functions
%% ====================================================================
-compile(export_all).
-import(myio, [println/1]).



%% If you send a message that doesn’t match a pattern at the receiving process, nothing will happen (for now at least). 
%% Sending a message that gets through the pattern matching but creates an error will halt the process where the error occurred

%% When a process crashes (e.g. failure of a BIF or a pattern match) Exit Signals are sent to all 
%% processes to which the failing process is currently linked.
%% Say A create B with spawn_link, then A -> B,If B exist, A gets notices.
p_create_link_p() ->
	process_flag(trap_exit,true), % IMPORTANT ! Make it possible to Receive the exit notice,otherwise process gets killed at the same time.
	Pid2 = spawn_link(process_link, error_receive, []), %% Link Pid2 to Pid1
	Pid2 ! "Send Msg",
	handle_error_receive().

error_receive() ->
		receive Num -> println(Num * 2),
				error_receive() end.

handle_error_receive() ->
	receive 
		{'EXIT', Pid, Reason} -> io:format("oooooooooooooooooops ~p died because of ~p ooooooooooooooops~n",[Pid, Reason]),
			handle_error_receive(); % If receive Exist singal from linked process, ignore it and loop receive service.
		Msg -> io:format("Receive Msg: ~p ~n ", [Msg]), handle_error_receive() end.

demo_link() ->
	Pid1 = spawn(process_link, p_create_link_p, []),
	Pid1 ! "deliberate not number".


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

