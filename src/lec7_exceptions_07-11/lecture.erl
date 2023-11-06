-module(lecture).
-export([start/0, work/1, work_and_crash_one/1]).

start() ->
    try_catch(),
    Data = "Bu",
    io:format("check with try/catch: ~p~n", [check_data_new(Data)]),
    io:format("check without try/catch: ~p~n", [check_data(Data)]),
    link(),
    % run_and_crash(),
    system_run().

try_catch() ->
    try
        1 + some_fun()
    catch
        throw:my_exception:Stacktrace ->
            io:format("My error~n~p~n", [Stacktrace])
    end.

some_fun() ->
    2 + other_fun().
other_fun() ->
    throw(my_exception).

check1_new(_Data) ->
    ok.

check2_new(_Data) ->
    throw(reason2).

check3_new(_Data) ->
    ok.

check_data_new(Data) ->
    try
        check1_new(Data),
        check2_new(Data),
        check3_new(Data)
    catch
        throw:reason1 -> {error, reason1};
        throw:reason2 -> {error, reason2};
        throw:reason3 -> {error, reason3}
    end.

check1(_Data) ->
    ok.

check2(_Data) ->
    {error, "Old Error"}.

check3(_Data) ->
    ok.

check_data(Data) ->
    case check1(Data) of
        ok -> case check2(Data) of
            ok -> case check3(Data) of
                ok -> io:format("Valid data ~p~n", [Data]);
                {error, Reason3} -> {error, Reason3}
            end;
            {error, Reason2} -> {error, Reason2}
        end;
        {error, Reason1} -> {error, Reason1}
    end.

link() ->
    [spawn_link(?MODULE, work, [Id]) || Id <- lists:seq(0, 5)],
    ok.

work(Id) ->
    io:format("~p ~p started~n", [Id, self()]),
    timer:sleep(1000),
    io:format("~p ~p stopped~n", [Id, self()]),
    ok.

run_and_crash() ->
    [spawn_link(?MODULE, work_and_crash_one, [Id]) || Id <- lists:seq(0, 5)],
    ok.

work_and_crash_one(Id) ->
    io:format("~p ~p started~n", [Id, self()]),
    if
        Id == 3 ->
            io:format("~p ~p exiting~n", [Id, self()]),
            exit(for_some_reason);
        true -> ok
    end,
    timer:sleep(1000),
    io:format("~p ~p stopped~n", [Id, self()]),
    ok.

system_run() ->
    spawn(fun system_process/0),
    ok.


system_process() ->
    io:format("~p system process started~n", [self()]),
    process_flag(trap_exit, true),
    spawn_link(fun worker/0),
    receive
        Msg -> io:format("~p system process got message ~p~n", [self(), Msg])
    after 2000 -> ok
    end,
    ok.


worker() ->
    io:format("~p worker started~n", [self()]),
    timer:sleep(500),
    exit(some_reason),
    ok.