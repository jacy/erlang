%% @author jacy
%% @doc @todo Add description to hello_world.
%%All of the code in a module must be contained in functions.

%%% Three percent signs (%%%) means that the comment will be formatted flush left
%%  Two percent signs (%%) means the comment is indented with surrounding code
%   Single percent sign (%) is used for comments on the end of a line


-module(hello_world).

%% ====================================================================
%% API functions
%% ====================================================================
-export([fall_velocity/1,fall_velocity/2]).

fall_velocity(Distance) -> math:sqrt(2 * 9.8 * Distance).
fall_velocity(Distance, TestParam) -> math:sqrt(2 * TestParam * Distance).


%% ====================================================================
%% Internal functions
%% ====================================================================

