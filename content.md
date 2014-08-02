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
- [openredis](https://openredis.com)
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

# 3. Setting Up the Project

By following the next chapters, you are going to build a Twitter clone called
*Frogger*.

The first thing you need to do is to create the project folder. You can create
it by writing the following command in your terminal:

```no-highlight
$ mkdir frogger
```

Afterwards, switch to the project folder:

```no-highlight
$ cd frogger
```

> NOTE: From now on, all the command line instructions shown in this book
must be executed in this directory.

# 4. Up and Running

This first chapter focuses on the bare minimum you need to know to work
with Cuba. We'll learn some of the core concepts walking through the
creation of the classical "Hello World" application.

## 4.1. What's Cuba?

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

## 4.2. Hello Frogger!

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
    res.write("Hello Frogger!")
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
    res.write("Hello Frogger!")
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
*"Hello Frogger!"*.

## 3.4. Introduction to Rack

As we mentioned earlier, Cuba is built on top of Rack ... but what is Rack?

Rack deals with HTTP requests. It provides a minimal interface between web
servers supporting Ruby and Ruby frameworks. Without Rack, Cuba would have
to implement its own handler for each web server.

![rack](/img/book/rack.png)

To run the hello world application you used `rackup`, one of the tools
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

# 5. Managing Dependencies

In every web application, there are common tasks that you need to do
(e.g authenticate users or query a database). Libraries are useful for
not reinventing the wheel, and in Ruby they are often referred to as
*gems*.

Ruby uses [Rubygems](https://rubygems.org/) to distribute them and to
ease the installation. Installing Cuba was as easy as typing
`gem install cuba` in the command line.

Even though Rubygems is useful when installing gems, it has its
limitations. Unfortunately, it installs all gems globally. This means
that if you have different versions of a gem installed, you have to
make sure that you require the right version for your project.

We need a way to keep track of the dependencies and install the right version
of each one. This is where tools like [gs](https://github.com/soveran/gs) and
[dep](https://github.com/cyx/dep) come to the rescue.

## 5.1. gs

With gs you can create a *gemset* for each project. A gemset is an isolated
space to install gems. By providing each project with their own gemset, you
can be sure that the right version of a gem is loaded.

To install gs, do:

```no-highlight
$ gem install gs
```

Creating a new gemset is as easy as typing:

```no-highlight
$ gs init
```

This command creates a directory `.gs` and starts a shell session. In this
session, all gems will be installed locally in the `.gs` folder.

## 5.2. dep

Now that we created a gemset, you will use *dep* to keep track of the project
dependencies.

dep uses a `.gems` file to list the required gems with their version
number. This file will be created automotically the first time you add a
gem to the list.

To add Cuba to this list, use:

```no-highlight
$ dep add cuba
```

This fetches the latest version of the gem and adds it to yours `.gems` file.
Let's have a look at what the file looks like after adding the Cuba gem:

```no-highlight
cuba -v 3.1.1
```

To install the listed gems in the `.gs` folder, do:

```no-highlight
$ dep install
```

To check that they're installed, use:

```no-highlight
$ dep
dep: all cool
```

If all is cool, you're good to go!

# 6. The Application Homepage

It's time to replace the greeting message with a nice homepage. To do that, we
need to change the code to return HTML. It can be written like this:

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

This approach can get very messy, especially when you need to generate content
dinamically (e.g. a user's timeline), or parts of the HTML are repeated on every
page (e.g. a navigation menu). Therefore we separate it into *views*, which are
template files that gets converted to HTML and sent back to the browser.

In this chapter, you'll learn how to use [mote](https://github.com/soveran/mote),
a minimal template engine to render views.

## 6.1 Mote

Mote is a fast template engine that allows us to put Ruby code into any
plain text document, like HTML.

Mote recognizes two tags to evaluate Ruby code: `%` and `{{}}`.
The difference between them is that while the `%` tag only evaluates
the code, the `{{}}` tag also prints the result to the template.

Imagine that your template looks like this:

```html
% gems = ["rack", "cuba", "mote"]

<ul>
% gems.sort.each do |gem|
  <li>{{ gem }}</li>
% end
</ul>
```

The generated result will be:

```html
<ul>
  <li>cuba</li>
  <li>mote</li>
  <li>rack</li>
</ul>
```
