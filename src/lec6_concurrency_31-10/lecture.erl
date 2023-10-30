-module(lecture).
-export([start/0]).

start() ->
    goSpawn(),
    messages(),
    test(),
    go_register().

goSpawn() ->
    io:format("Entering spawn function~n"),
    G = fun(X) -> timer:sleep(10), io:format("~p~n", [X]) end,
    [spawn(fun() -> G(X) end) || X <- lists:seq(1,10)].

messages() ->
    self() ! hello,
    flushPrint().

flushPrint() ->
    receive
        M -> 
            io:format("Shell got ~p~n",[M]),
            flush()
    after 0 ->
        ok
    end.

test() ->
    test_messages("test1, empty", []),

    test_messages("test2, 1 message, match",
                  [{msg, 1}]),

    test_messages("test3, 1 message, not match",
                  [msg1]),

    test_messages("test4, 3 messages, all match",
                  [{msg, 1}, {msg, 2}, {msg, 3}]),

    test_messages("test5, 3 messages, all not match",
                  [msg1, msg2, msg3]),

    test_messages("test6, 4 messages, some match, some not match",
                  [{msg, 1}, msg2, {msg, 3}, msg4]),

    test_messages("test7, 4 messages, some match, some not match",
                  [msg1, {msg, 2}, msg3, {msg, 4}]),

    ok.

test_messages(TestName, Messages) ->
    io:format("~n### ~ts~ntest_messages: ~p~n", [TestName, Messages]),
    flush(),
    [self() ! Msg || Msg <- Messages],

    io:format("call receive~n"),
    Res = receive
              {msg, M} -> {msg, M}
          after 100 -> timeout
          end,
    io:format("after receive got: ~p~n", [Res]),
    [{messages, Left}] = process_info(self(), [messages]),
    io:format("left in mailbox: ~p~n", [Left]),
    ok.

flush() ->
    receive
        _ -> flush()
    after 100 -> ok
    end.

go_register() ->
    io:format("~nregistered: ~p~n", [registered()]),
    register(erl_console, self()),
    io:format("~nregistered: ~p~n", [registered()]),
    io:format("~nnew proccess: ~p~n", [whereis(erl_console)]),
    io:format("~ncurrent proccess: ~p~n", [self()]),
    unregister(erl_console),
    io:format("~nregistered: ~p~n", [registered()]).