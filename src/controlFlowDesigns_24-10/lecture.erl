-module(lecture).
-export([start/0]).

start() ->
    convert(monday).

convert(Day) ->
    A = case Day of
        monday -> 1;
        tuesday -> 2;
        wednesday -> 3;
        thursday -> 4;
        friday -> 5;
        saturday -> 6;
        sunday -> 7
    end,
    io:format("day ~p of 7~n", [A]).
