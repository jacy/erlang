%% @author jacy
%% @doc @todo Add description to login_if.


-module(logic_if).

%% ====================================================================
%% API functions
%% ====================================================================
-export([fall_velocity_v1/2,fall_velocity_v2/2]).

fall_velocity_v1(Planemo, Distance) when Distance >= 0 -> Gravity = case Planemo of
    earth -> 9.8;
    moon ->  1.6;
    mars ->  3.71
end,
Velocity = math:sqrt(2 * Gravity * Distance),
if
    Velocity == 0 -> 'stable';
    Velocity < 5 -> 'slow';
    Velocity >= 5, Velocity < 10 -> 'moving';
    Velocity >= 10, Velocity < 20 -> 'fast';
    Velocity >= 20 -> 'speedy'
end.

fall_velocity_v2(Planemo, Distance) when Distance >= 0 -> Gravity = case Planemo of
    earth -> 9.8;
    moon ->  1.6;
    mars ->  3.71
end,
Velocity = math:sqrt(2 * Gravity * Distance),
Description = if
Velocity == 0 -> 'stable';
Velocity < 5 -> 'slow';
(Velocity >= 5) and (Velocity < 10) -> 'moving'; 
(Velocity >= 10) and (Velocity < 20) -> 'fast'; 
Velocity >= 20 -> 'speedy'
end,
if
(Velocity > 40) -> io:format("Look out below!~n") ;
true -> true end,
  Description.

%% ====================================================================
%% Internal functions
%% ====================================================================


