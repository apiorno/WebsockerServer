ws_server
=====

Erlang websocket server using Cowboy library.

Build & start
-----

    $ rebar3 shell

Testing
-----

To open a client connection, from a web browser execute:

```
    (()=>{
    window.a = new WebSocket("ws://localhost:8080/ws?num=3");
    a.onopen = event => console.log("socket opened");
    a.onclose = event => console.log("socket closed");
    a.onmessage = event => console.log("message received from server: "+event.data);
    })();
```

Then execute:

```
    a.send(5);
```

Finally, you can close the connection from the server or from the client executing:

```
    a.close();
```