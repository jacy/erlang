%% @author jacy
%% @doc @todo Add description to myprocess.


-module(myprocess).

%% ====================================================================
%% API functions
%% ====================================================================
-compile(export_all).
-import(myio, [println/1]).

report() -> 
		receive Msg -> 
		io:format("Receive ~p ~n", [Msg]) end,
		report().

report(Count) -> 
		receive Msg -> 
		io:format("Rreceive #~p: ~p ~n", [Count, Msg]) end,
		report(Count + 1).

report_v2(Count) ->
	NewCount = receive Msg ->  
				io:format("Receive #~p: ~p ~n", [Count, Msg]),
				Count + 1
	end,
	report_v2(NewCount). % Since receive is waitting until a message is sent, so no dead loop happens.

process() ->
	%% spawn parms : module name, function name, param for function
	Pid = spawn(myprocess,report,[1]), % Once you have the process spawned, you can send a message to that pid
	Pid ! hello_from_pid, % send message
	%% Register(Alias, Pid) Registers the process Pid with the name Alias.
	register(process1, Pid), % register process to name process1
	process1 ! hello_from_process_registered,
	
	%%% If you want to see which processes are registered, you can use the regs() shell command.
	GetProcess1 = whereis(process1),
	unregister(process1),
	println(whereis(process1)), % gets 'undefined' for it gets unregisted alrealdy.
	GetProcess1 ! "Still there ?", % have nothing to do with process1,which has been unregisterd.
	end_process.

hi_back() -> 
	%% Multi receive clauses
	receive 
		{From, Msg} -> % clause with 2 elements of tuple.
			io:format("Receive msg from hi_back(), trying to get back to sender.~n"),
			From ! "Got your msg:" ++ Msg,
			hi_back();
		{Msg} -> io:format("Got Msg with no sender info: ~p ~n", [Msg]), % clause with only 1 element of tuple.
		hi_back()
	end.

ping_pong() ->
	Pid_send = spawn(myprocess,report,[1]),
	Pid_response = spawn(myprocess,hi_back,[]),
	
	Pid_response ! {Pid_send, "First Try :) "},
	Pid_response ! {"Second try anonymous!"},
	end_ping_pong.
	
%% ====================================================================
%% Internal functions
%% ====================================================================
