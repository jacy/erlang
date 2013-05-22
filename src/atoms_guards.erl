%% @author jacy
%% @doc @todo Add description to atoms_demo.


-module(atoms_guards).

%% ====================================================================
%% API functions
%% ====================================================================
-export([fall_velocity/2,absolute_value/1,tuple/1,tuple/2,tuple/3]).

%% Separated with semicolons, they are treated as choices—selected by pattern-matching—rather than duplicate definitions.
fall_velocity(earth, Distance) when Distance >= 0 -> math:sqrt(2 * 9.8 * Distance); 
fall_velocity(earth, Distance) when Distance < 0 -> test_guards; 
fall_velocity(moon, Distance) when Distance >= 0 -> math:sqrt(2 * 1.6 * Distance); 
fall_velocity(mars, Distance) when Distance >= 0 -> math:sqrt(2 * 3.71 * Distance);
%%Underscore matches anything for the pattern match, and never binds to a variable, so can not use it on the right side.
%%So can use fall_velocity(what_ever, 50)
fall_velocity(_, Distance) -> math:sqrt(2 * 9.8 * Distance).

%%Tuple Param Version 1

tuple({earth,Distance}) when Distance >= 0 -> math:sqrt(2 * 9.8 * Distance); 
tuple({earth,Distance}) when Distance < 0 -> test_guards.

%%Tuple Param Version 2
tuple(_,Where)  -> fall_velocity(element(1,Where),element(2,Where)).
%%Tuple Param Version 3
tuple(_,_, Where) -> {Planemo, Distance} = Where, fall_velocity(Planemo, Distance).


absolute_value(Number) when Number < 0 -> -Number; 
absolute_value(0) -> 0;
absolute_value(Number) -> Number.


%% ====================================================================
%% Internal functions
%% ====================================================================


