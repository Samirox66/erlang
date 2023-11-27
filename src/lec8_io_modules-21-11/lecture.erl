-module(lecture).
-import(demo, [double/1]).
-export([start/0]).
-include("person.hrl").

start() ->
    io:format("~p~n", [double(2)]),
    io:format("~p~n",[#person{name="Gosha", age=42}]),
    A = io:get_line("Day mne chislo: "),
    io:format("Ty dal mne chislo ~p~n", [A]),
    B = io:get_chars("Teper' ya zaberu u tebya 3 simvola: ", 3),
    io:format("Vot eti simvoli ~p~n", [B]),
    file().

file() ->
    {ok, File} = file:open("Newfile.txt",[read]),
    Txt = file:read(File,1024 * 1024), 
    io:fwrite("~p~n",[Txt]).
