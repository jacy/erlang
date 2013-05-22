%% @author jacy
%% @doc @todo Add description to combine.


-module(combine).

%% ====================================================================
%% API functions
%% ====================================================================
-import(hello_world, [fall_velocity/1]).


-compile(export_all). %Making all functions available for external calls

height_to_mph(Meters) -> 10000 * fall_velocity(Meters).
%% ====================================================================
%% Internal functions
%% ====================================================================