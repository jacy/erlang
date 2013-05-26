%% @author jacy
%% @doc @todo Add description to erros_handle.


-module(myerrors).

%% ====================================================================
%% API functions
%% ====================================================================
-compile(export_all).
-import(myio, [println/1]).
verbose(Op1, Op2) ->
	try println("---verbose----"),Op1 / Op2 of
		Result -> Result % Matching the variable Result will put that value in Result.
	catch 
		error:Error -> {error, Error} 
	end.

%% The atom error will match the class or exception type of the error (which can be error, throw, or exit), 
%% and the variable Error will collect the details of the error

concise(Op1, Op2) ->
	try println("---consice----"), Op1 / Op2
	catch 
		error:Error -> {error, Error}
	after 
		println("The code in an after clause is guaranteed to run whether the attempted code succeeds or fails"),
		io:format("It doesn’t affect the return value of the clause howerver ~n"),
		'try to return an atom instead the return value in catch should be fail'
	end.
catch_custom_excp() ->
	try throw_exception()
	catch
		throw:Exception -> {caught, Exception}; % catch custom exception
		error:Error -> {found, Error}
	end.

log_errors() ->
	error_logger:info_msg("Info Msg ~p",['same as io:format.']),
	error_logger:warning_msg("Warning Msg ~p",['have bad smeth. ']),
	error_logger:error_msg("Error Msg ~p ~n",['show errors here']),
	end_logging.

throw_exception() -> throw({jacyExce,"For Test"}). % throw custom exception
%% ====================================================================
%% Internal functions
%% ====================================================================


