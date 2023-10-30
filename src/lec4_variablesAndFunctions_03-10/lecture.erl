-module(lecture).
-export([start/0]).

start() ->
    comparison(),
    comparison_with_underlining(),
    safe_unsafe(),
    closing(),
    functions().

comparison() ->
    {Element, Element, X} = {1,1,2},
    io:fwrite("Element = ~p\n", [Element]),
    io:fwrite("X = ~p\n", [X]),
    
    {Element2, Element2, X2} = {1,2,3},
    io:fwrite("Element = ~p\n", [Element2]),
    io:fwrite("X = ~p\n", [X2]).

comparison_with_underlining() ->
    {A, _, [B|_], {B}} = {abc, 23, [22, 23], {22}},
    io:fwrite("A = ~p\n", [A]),
    io:fwrite("B = ~p\n", [B]),
    
    {A1, _int, [B1|_int], {B1}} = {aaa, 3, [2, 3], {2}},
    io:fwrite("A1 = ~p\n", [A1]),
    io:fwrite("B1 = ~p\n", [B1]).

safe_unsafe() ->
    Safe = safe(1),
    io:fwrite("~p", [Safe]),
    
    % Unsafe = unsafe(2),
    % io:fwrite("~p", [Unsafe]).
    
    Preferred = preferred(2),
    io:fwrite("~p", [Preferred]).

safe(X) ->
    case X of
        1 -> Y = 12;
        _ -> Y = 196
    end,
    X+Y.
    
% unsafe(X) -> 
%     case X of 
%         1 -> Y = true;
%         _ -> Z = two
%         end, 
%     Y.
    
preferred(X) ->
    Y = case X of
        1 -> 12;
        _ -> 196
        end,
    X+Y.

closing() ->
    Mike = hello("Mike"),
    Mike("Hello"),
    Kolya = hello("Kolya"),
    Kolya("Bye").
    
hello(Name) ->
    fun(Hi) -> io:fwrite("~s, ~s! \n", [Hi, Name]) end.

functions() ->
    A = area({circle, 2}),
    io:fwrite("A = ~p", [A]).

area({square, Side}) ->
    Side * Side ;
area({circle, Radius}) ->
    math:pi() * Radius * Radius ;
area({triangle, A, B, C}) ->
    S = (A + B + C)/2,
    math:sqrt(S*(S-A)*(S-B)*(S-C));
area(_Other) ->
    {error, invalid_object}.