-module(lecture).
-export([start/0]).

start() ->
    printCase(),
    if_expression(),
    guard().

printCase() ->
    B = convert(monday),
    io:fwrite("Day ~p from 7~n", [B]),
    A = [1, 2, 3],
    Len = listlen(A),
    io:fwrite("Len = ~p\n", [Len]),
    Len_with_case = listlen_with_case(A),
    io:fwrite("Len_with_case = ~p~n", [Len_with_case]).


listlen([]) -> 0;
listlen([_|Xs]) -> 1 + listlen(Xs).


listlen_with_case(Y) ->
    case Y of
        [] -> 0;
        [_|Xs] -> 1 + listlen(Xs)
    end.

    
convert(Day) ->
    case Day of
        monday -> 
            B = 1 + 1,
            io:fwrite("B = ~p\n", [B]),
            1;
        tuesday -> 2;
        wednesday -> 3;
        thursday -> 4;
        friday -> 5;
        saturday -> 6;
        sunday -> 7
    end.

if_expression() ->
 io:fwrite("test_if(5) = ~p\n", [test_if(5)]),
    io:fwrite("test_if(0) = ~p\n", [test_if(0)]),
    io:fwrite("test_if(1) = ~p\n", [test_if(1)]).
    
test_if(X) ->
    if
        X < 1 -> smaller;
        X > 1 -> greater;
        true -> equal
    end.

guard() ->
    io:fwrite("factorial(5) = ~p\n", [factorial(5)]),
    io:fwrite("factorial_guard(5) = ~p\n", [factorial_guard(5)]),
    io:fwrite("my_add(4, 5) = ~p\n", [my_add(4, 5)]).
    
my_add(X, Y) when not (((X > Y) or not (is_atom(X))) and (is_atom(Y) or (X == 3.4))) ->
    X+Y.
    
factorial(0) -> 1;
factorial(N) -> N * factorial (N - 1 ).

factorial_guard(N) when N > 0 ->
    N * factorial_guard(N - 1);
factorial_guard(0) -> 1.
