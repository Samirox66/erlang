-module(lecture).
-export([start/0]).

start() ->
    map(),
    binary(),
    bit_operation(),
    serialize(),
    anonimus(),
    types_cast().

map() ->
    Map1 = #{person => {user, "Bob"}, 2 => {user, "Bill"}},
    io:format("Map1 = ~p~n", [Map1]),
    Map2 = Map1#{3 => {user, "Helen"}},
    io:format("Map2 = ~p~n", [Map2]),
    Map3 = Map2#{person := {user, "Bob Bobovich"}},
    io:format("Map3 = ~p~n", [Map3]),    
    io:format("user of Map3 = ~p~n", [maps:get(person, Map3)]),
    io:format("2 of Map3 = ~p~n", [maps:get(2, Map3)]),
    io:format("3 of Map3 = ~p~n", [maps:get(3, Map3)]).

binary() ->
    Val1 = 512, % 10 00000000
    Val2 = 768, % 11 00000000
    Val3 = 32,  %    00100000
    Bin = <<Val1:32/integer, Val2:16/integer, Val3:8/integer>>,
    io:format("Bin = ~p~n", [Bin]),
    <<Val:32/integer, Rest/binary>> = Bin,
    io:format("Val = ~p~n", [Val]),
    io:format("Val = ~p~n", [Rest]).

bit_operation() ->
    io:format("2#00010 bsl 1 = ~p = 2#00100~n", [2#00010 bsl 1]),
    io:format("2#00010 bsr 1 = ~p = 2#00001~n", [2#00010 bsr 1]),
    io:format("2#10001 bor 2#00101 = ~p = 2#10101~n", [2#10001 bor 2#00101]).


serialize() ->
    Bin = term_to_binary([{user, "Bob"}, {user, "Bill"}]),
    io:format("Bin = ~p~n", [Bin]),
    io:format("Data = ~p~n", [binary_to_term(Bin)]),
    Bin2 = term_to_binary({1,2,3}),
    io:format("Bin = ~p~n", [Bin2]),
    io:format("Data = ~p~n", [binary_to_term(Bin2)]).


anonimus() ->
    Fun1 = fun (X) -> X+1 end,
    io:format("Fun1(2) = ~p~n" ,[Fun1(2)]).

types_cast() ->
    io:format("list_to_integer(\"54\") = ~p~n", [list_to_integer("54")]),
    io:format("integer_to_list(54) = ~p~n", [integer_to_list(54)]),
    io:format("list_to_float(\"54.32\") = ~p~n", [list_to_float("54.32")]),
    io:format("atom_to_list(true) = ~p~n", [atom_to_list(true)]),
    io:format("list_to_bitstring(\"hi there\") = ~p~n", [list_to_bitstring("hi there")]),
    io:format("bitstring_to_list(<<\"hi there\">>) = ~p~n", [bitstring_to_list(<<"hi there">>)]).