%% @author jacy
%% @doc @todo Add description to simple_supervisor.


-module(simple_supervisor).
-behaviour(supervisor).
%% ====================================================================
%% Supervisor callbacks
%% ====================================================================
-export([init/1]). % required callbacks of supervisor
-export([start_link/0]).

init([]) ->
	%% The RestartStragegy of one_for_one tells OTP that it should create a new child process every time 
	%% a process that is supposed to be permanent fails.You can also go with one_for_all, which terminates and restarts 
	%% all of the processes the supervisor oversees when one fails, or rest_for_one, which restarts the process 
	%% and any processes that began after the failed process had started.
	RestartStragegy = one_for_one,
	
	%% The next two values define how often the worker processes can crash before terminating the supervisor itself.
	%% In this case, it’s one restart every five seconds.
	MaxRestarts = 1,
	MaxSecondsBetweenRestarts = 5,
	SupFlags = {RestartStragegy, MaxRestarts, MaxSecondsBetweenRestarts},
	
	Restart = permanent,
	Shutdown = 2000,
	Type = worker,
	Proc = {my_gen_server,{my_gen_server, start_link,[]}, Restart, Shutdown, Type, [my_gen_server]},
	
	{ok, {SupFlags, [Proc]}}.
%% ====================================================================
%% API functions
%% ====================================================================

start_link() ->
	supervisor:start_link({local,?MODULE}, ?MODULE, []).

%% ====================================================================
%% Internal functions
%% ====================================================================


