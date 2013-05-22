%% @author jacy
%% @doc @todo Add description to logic.


-module(logic).

%% ====================================================================
%% API functions
%% ====================================================================
-export([fall_velocity/2, fall_velocity_v2/2]).

fall_velocity(Planemo, Distance) when Distance >= 0 -> case Planemo of
earth -> math:sqrt(2 * 9.8 * Distance);
moon -> math:sqrt(2 * 1.6 * Distance);
mars -> math:sqrt(2 * 3.71 * Distance) % no closing period!
end.

fall_velocity_v2(Planemo, Distance) when Distance >= 0 -> Temp = case Planemo of
earth -> 9.8;
moon -> 1.6;
mars -> 3.71
end, % note comma - function isn't done yet
math:sqrt(2 * Temp * Distance).
%% ====================================================================
%% Internal functions
%% ====================================================================