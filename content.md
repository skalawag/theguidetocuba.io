<img src="/img/cover.png" style="border: 1px solid black; width: 400px;"/>

This book is a work in progress and is licensed under the
[CC BY-NC-SA 4.0 license](http://creativecommons.org/licenses/by-nc-sa/4.0/).

# 1. Introduction

The Guide to Cuba will teach you how to create a Ruby web
application from scratch using Cuba. Cuba is a micro framework
written by Michel Martens ([@soveran](https://twitter.com/soveran)).
It is open source, and you can have a look at the code
[here](https://github.com/soveran/cuba).

Some Ruby frameworks can be bloated and offer functionality you don't
need. We'll teach you how to use Cuba together with small and simple Ruby
libraries to customize your stack. By applying this minimalist philosophy
you achieve more flexibility, less complexity and maintainable code.

Here's a list of pages that uses Cuba for inspiration:

- [AT&T’s M2X](https://m2x.att.com)
- [Educabilia](http://educabilia.com)
- [Open Redis](https://openredis.com)
- [jobs.punchgirls.com](https://jobs.punchgirls.com)
- [Redis homepage](http://redis.io)

# 2. Assumptions

This book is intended for everyone who wants to get started with Cuba.
It's recommended to have some basic knowledge of the Ruby programming
language. If this is the first time you hear about Ruby, we encourage
you to take this tutorial to get up to speed: <http://tryruby.org/>.

In order to try out the examples of the book, you need to have some
prerequisites installed:

* Ruby 2.0 or newer. You can get the latest Ruby from the
  [Ruby download page](https://www.ruby-lang.org/en/downloads/).

* The [Redis](http://redis.io) database. If you don't have Redis installed,
  you can follow the instructions in the [Redis download page](http://redis.io/download).

You can find the code examples [here](https://github.com/frodsan/theguidetocuba.io/tree/gh-pages/code).
They have all been tested on OSX and Linux.

# 3. Up and Running

This first chapter focuses on the bare minimum you need to know to work
with Cuba. We'll learn some of the core concepts walking through the
creation of the classical "Hello World" application.

## 3.1. What's Cuba?

Cuba is one of the lightest option when it comes to web development
in Ruby. Here are some core attributes that are worth mentioning:

* It's incredibly small, 174 lines of code. This simplicity by design
  makes Cuba easy to understand and debug, and very stable (no major
  changes since 2012).

* Like most web frameworks in Ruby, Cuba is built on top of Rack, a Ruby
  webserver interface. Because of this, we have the benefits of existing
  libraries and a variety of web servers for free. Don't worry if you don't
  understand what Rack is just yet, we'll discuss it later.

* Cuba does one thing and does it well, handle HTTP requests. This gives us
  the freedom to choose the appropiate tools for the job at hand. This book
  will introduce other libraries that share the same design philosophy.

* It is fast? [Yes, it is](https://github.com/luislavena/bench-micro).

## 3.2. Hello Cuba!

To get started, use the `gem` command to install Cuba:

```no-highlight
$ gem install cuba
```

Now that Cuba is installed, it's easy to create an application. Open
your text editor of preference and create a file called `app.rb` with
the following code:

```ruby
require "cuba"

Cuba.define do
  on root do
    res.write("Hello, Cuba!")
  end
end
```

Then create another one called `config.ru` with the contents shown below:

```ruby
require "./app"

run(Cuba)
```

You already have a functional Cuba application! To see it in action, you
need to start a web server. You can do this by typing `rackup config.ru`
in the command line.

![rackup](/img/book/rackup.png)

> **NOTE:** To stop the web server, hit `Ctrl+C` in the terminal window
where it's running. To verify that the server has stopped you should see
your command prompt cursor again.

Now open the browser and navigate to <http://localhost:9292> to see the
greeting message:

![hello](/img/book/hello.png)

## 3.3. Breaking Down the Syntax

Now that you know how to build a minimal application, let's take a deeper
look at the syntax.

First, you load the Cuba gem to access its functionality.

```ruby
require "cuba"
```

Then you can see four methods that appear in most Cuba applications:

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

* `res` handles the server response. In this case, you use the `write`
  method to set the response body with the greeting message.

When you enter <http://localhost:9292/>, the application checks if the
accessed path is the root. Since this evaluates to `true`, it prints
*"Hello, Cuba!"*.

## 3.4. Introduction to Rack

As we mentioned earlier, Cuba is built on top of Rack ... but what is Rack?

Rack deals with HTTP requests. It provides a minimal interface between web
servers supporting Ruby and Ruby frameworks. Without Rack, Cuba would have
to implement its own handler for each web server.

![rack](/img/book/rack.png)

To run the **"Hello Cuba!"** application you used `rackup`, one of the tools
that comes with Rack.

To use `rackup`, you need to supply a `config.ru` file. This file connects
the Rack interface with the application through the `run` method. This method
receives an object that returns a Rack response. In this case, that object is
the Cuba application:

```ruby
run(Cuba)
```

`rackup` also figures out which server you have available. When we
use `rackup`, it fires up *WEBrick*, a web server built into Ruby
by default.

```no-highlight
$ rackup config.ru
[2014-05-06 23:37:23] INFO  WEBrick 1.3.1
...
```

You can read more about Rack visiting their home page:
<http://rack.github.io/>.

# 4. Setting Up the Project

Now that we known the basics of Cuba and Rack, we're ready to put it to work.
By following the next chapters, you are going to build a Twitter clone called
*Frogger*.

## 4.1 Managing Dependencies

## 4.2 Shotgun

## 4.3 Making a Basic Task

# 5. The Application Homepage

Something that we didn't see in the last chapter is that it's also easy to
render a piece of HTML with Cuba. If you change the above example and add a
`<h1>` header like this:

```ruby
require "cuba"

Cuba.define do
  on root do
    res.write("<h1>Hello, Cuba!</h1>")
  end
end
```

Restart the server, refresh the page and you'll see the greeting displayed
as a HTML header.

![hello2](/img/book/hello2.png)

Suppose you have to write a big chunk of HTML code. It can be written
like this:

```ruby
Cuba.define do
  on root do
    res.write("
      <html>
        <body>
          <!-- ... -->
        </body>
      </html>
    ")
  end
end
```

The problem with this approach is that it's hard to reuse parts of the HTML
that every page uses, for example a navigation menu or a footer. Therefore, we
separate it into *views*, which are templates that gets converted to HTML and
sent back to the browser.

In this chapter, you'll learn how to use [Mote](https://github.com/soveran/mote),
a minimal template engine to render views.
