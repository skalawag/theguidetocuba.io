Rack & Roll!
============

As we mentioned earlier, Cuba is built on top of Rack ... but what is Rack?

Rack deals with HTTP requests. It provides a minimal interface between web
servers supporting Ruby and Ruby frameworks. Without Rack, Cuba would have
to implement its own handler for each web server.

![rack](../assets/rack.png)

You didn't notice yet but we already used Rack. We used `rackup`, one of
the tools that comes with Rack, to run our **"Hello Cuba!"** application.

To use `rackup`, you need to supply a config file (by convention it uses
the *.ru* extension). This file connects the Rack interface with our
application through the `run` method. This method receives an object that
returns a Rack response. In our case, that object is our Cuba application:

```ruby
run(Cuba)
```

`rackup` also figures out which server you have available. When we
executed `rackup config.ru`, it fired up *WEBrick*, a web server
built into Ruby by default.

```
$ rackup config.ru
[2014-05-06 23:37:23] INFO  WEBrick 1.3.1
...
```

To read more about Rack, visit their home page: <http://rack.github.io/>.
