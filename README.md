# test_connection

A Puppet task to test connectivity over a specific port

## Description

This module provides a simple task that will try to connect to a specific port on a specific host

## Example

Checking if a server can reach a valid server over a valid port.

`bolt task run test_connection --targets localhost server=google.com port=443`

```properties
Started on localhost...
Finished on localhost:
  {
    "result": {
      "connected": true,
      "details": {
        "server": "google.com",
        "port": 443
      }
    }
  }
Successful on 1 target: localhost
Ran on 1 target in 0.13 sec
```

Checking if a server can reach an invalid server.

`bolt task run test_connection --targets localhost server=invalid_server.com port=443`

```properties
Started on localhost...
Failed on localhost:
  getaddrinfo: Name or service not known
Failed on 1 target: localhost
Ran on 1 target in 0.15 sec
```

Checking if a server can reach a valid server over a port that is closed.

`bolt task run test_connection --targets localhost server=google.com port=22`

```properties
Started on localhost...
Failed on localhost:
  Unable to reach google.com over port 22
Failed on 1 target: localhost
Ran on 1 target in 21.16 sec
```