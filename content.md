# The Guide to Cuba

Francesco Rodríguez & Mayn Ektvedt Kjær

Version 0.1

This book is a work in progresses and is licensed under the
[Creative Commons Attribution Non Commercial Share Alike 4.0 license]
(http://creativecommons.org/licenses/by-nc-sa/4.0/).

# 1. Introduction

The Guide to Cuba will teach you how to create a Ruby web
application from scratch using Cuba. Cuba is a micro framework
written by Michel Martens ([@soveran](https://twitter.com/soveran)).
It is open source, and you can have a look at the code
[here](https://github.com/soveran/cuba).

Some Ruby frameworks can be bloated and offer functionality you don't
need. We'll teach you how to use Cuba together
will small and simple Ruby libraries to customize your stack.
By applying this minimalist philosophy you achieve more flexibility,
less complexity and maintainable code.

Here's a list of pages that uses Cuba for inspiration:

- [AT&T’s M2X](https://m2x.att.com)
- [Educabilia](http://educabilia.com)
- [Open Redis](https://openredis.com)
- [jobs.punchgirls.com](https://jobs.punchgirls.com)
- [Redis homepage](http://redis.io)

# 2. Assumptions

This book is intended for everyone who wants to get started with a Cuba
application from scratch, whether you are an experienced programmer or
not. By following this book, we'll build a Twitter clone from scratch.

In order to try out the examples of the book, you need to have some
prerequisites installed:

* Ruby 2.0 or newer. You can get the latest Ruby from the
  [Ruby download page](https://www.ruby-lang.org/en/downloads/).

* The [Redis](http://redis.io) database. If you haven't yet installed Redis, you can
  follow the instructions in the [Redis download page](http://redis.io/download).

* [Git](http://git-scm.com/), the version control system. You can follow the installation
  instructions at the [Installing Git section of Pro Git](http://www.git-scm.com/book/en/Getting-Started-Installing-Git).

> **NOTE:** All the code examples have been tested on OSX and Linux.

# 3. Welcome Aboard

This first chapter focuses on the bare minimum you need to know to work
with Cuba. We'll learn some of the core concepts walking through the
creation of a simple application. After reading this, you will know:

* How to install Cuba.
* Create a **"Hello world!"** application.
* The basic principles behind Cuba.
* The basics of Rack.

## 3.1. What's Cuba?

To begin, let's take a moment to answer *"what is Cuba?"*.

Cuba is a web application micro-framework written in Ruby by
[Michel Martens](https://github.com/soveran). It rides on
[Rack](http://rack.github.io) so we have the benefits of middleware,
Rack libraries, and a variety of web servers for free.

Cuba is minimalist by design (203 lines of code) which makes it
[faster](https://github.com/luislavena/bench-micro#requestssec)
compared to other web frameworks. Also, it doesn’t make assumptions
about the "best" way to do things. That gives us the freedom to choose
the proper tools for the job.

Since Cuba doesn’t ship with all the tools we need to create our example
application, this book will also introduce other libraries that share the
same design philosophy. Together, they make web development simple,
understandable and fun.

## 3.2. Hello Cuba!

Before getting started, we have to install Cuba. Use the `gem` command:

```no-highlight
$ gem install cuba
```

Now that Cuba is installed, it's easy to create a Cuba application. Open
your text editor of preference and create a file called `config.ru` with
the following code:

```ruby
require "cuba"

Cuba.define do
  on root do
    res.write("Hello, Cuba!")
  end
end

run(Cuba)
```

You already have a functional Cuba application! To see it in action, type
`rackup config.ru` in the command line.

![rackup](/img/book/rackup.png)

Now open a browser and navigate to <http://localhost:9292/>. It should
show a greeting message as shown below:

![hello](/img/book/hello.png)

> **NOTE:** To stop the web server, hit `Ctrl+C` in the terminal window
where it's running. To verify the server has stopped you should see your
command prompt cursor again.

As you can see, the syntax is very readable. We'll discuss the details
in the next section.

## 3.3. Breaking Down the Syntax

Now that we know how to build a minimal Cuba application, let's take a deeper
look at the syntax. We can split this example into three parts:

First, we require Cuba to load the gem and get access to
its functionality.

```ruby
require "cuba"
```

Then we can identify four methods that appear in most Cuba
applications: `define`, `on`, `root` and `res`.

```ruby
Cuba.define do
  on root do
    res.write("Hello, Cuba!")
  end
end
```

* `define` allows us to create an application through a block.

* `on` executes a given block if the passed conditions evaluate to `true`.

* `root` returns `true` if the accessed path is the root of the
  application (`"/"` or `""`).

* `res` handles the server response. In this case, we use the `write`
  method to set the response body with the greeting message.

Finally, the last line connects our application with Rack.

```ruby
run(Cuba)
```

Don't worry if you don't understand what Rack is just yet, we'll discuss
it in the next section.

## 3.4. Rack & Roll!

As we mentioned earlier, Cuba is built on top of Rack ... but what is Rack?

Rack deals with HTTP requests. It provides a minimal interface between web
servers supporting Ruby and Ruby frameworks. Without Rack, Cuba would have
to implement its own handler for each web server.

![rack](/img/book/rack.png)

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

```no-highlight
$ rackup config.ru
[2014-05-06 23:37:23] INFO  WEBrick 1.3.1
...
```

To read more about Rack, visit their home page: <http://rack.github.io/>.
