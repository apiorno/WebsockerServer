-module(ws_handler).
-export([init/2,websocket_init/1,websocket_handle/2,websocket_info/2,terminate/3]).
init(Req, State) ->
    io:format("Inside init/2 callback.\n", []),
    #{num := Num} = cowboy_req:match_qs([{num,int}], Req),
    FinalState = maps:put(num, Num, State),
    {cowboy_websocket, Req, FinalState}.

websocket_init(State) ->
    io:format("Inside websocket_init/1 callback.\n", []),
    self() ! log_pid,
    {[{text, "Websocket server connection success!"}], State}.

terminate(TerminateReason, _Req, _State) ->
    io:format("Terminate reason: ~p\n", [TerminateReason]),
    ok.

websocket_info(stop, State) ->
    {stop,State};
websocket_info(log_pid, State) ->
    io:format("PID of Websocket server is ~p.~n", [self()]),
    {ok, State};
websocket_info(Info, State) ->
    {[{text, "From websocket_info: " ++ Info}],State}.

websocket_handle({text,Text}, State) ->
    io:format("Frame received: ~p\n", [Text]),
    Num1 = binary_to_integer(Text),
    #{num := Num2} = State,

    Sum = integer_to_list(Num1 + Num2),
    Product = integer_to_list(Num1 * Num2),

    {[{text, "Sum is:" ++ Sum}, {text, "Product is: " ++ Product}],State}.