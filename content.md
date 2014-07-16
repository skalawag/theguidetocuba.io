# The Guide to Cuba

Francesco Rodríguez & Mayn Ektvedt Kjær

Version 0.1

This book is a work in progresses and is licensed under the
[Creative Commons Attribution Non Commercial Share Alike 4.0 license]
(http://creativecommons.org/licenses/by-nc-sa/4.0/).

## Introduction

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

Assumptions
===========

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

Welcome Aboard
==============

This first chapter focuses on the bare minimum you need to know to work
with Cuba. We'll learn some of the core concepts walking through the
creation of a simple application. After reading this, you will know:

* How to install Cuba.
* Create a **"Hello world!"** application.
* The basic principles behind Cuba.
* The basics of Rack.

What's Cuba?
------------

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

Hello Cuba!
-----------

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

Breaking Down the Syntax
------------------------

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

Rack & Roll!
------------

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

Setting the Road
================

Now that we know the basics of Cuba, we're ready to make our twitter
clone. In this chapter, we'll set the road to start coding the application
and have a look at how Cuba applications looks in the wild.

After reading this chapter, you will know:

* The general layout of a Cuba application.
* How to properly manage project dependencies.
* How the application initializes.

Structuring the Application
---------------------------

With Cuba you have a lot of freedom to choose the architecture
of your application. In this book, we will use a template called
[app](https://github.com/frodsan/app). To start using it, open up
a command line prompt and type:

```no-highlight
$ git clone git@github.com:frodsan/app.git twitter
```

This will create a *twitter* directory with the files and folders for
a minimal functional application.

After the download is completed, switch to the *twitter* directory.

```no-highlight
$ cd twitter
```

From now on, you must execute all the command line instructions from this
directory. For example:

```no-highlight
$ ls
README.md    config.ru    helpers    makefile    public    test
app.rb       filters      mails      models      routes    views
```

This table shows a basic overview of the files and folders that make up
the structure of the application. We'll learn more about these throughout
the rest of this book.

| File/Folder | Purpose
|-------------|--------
| .gems       | A list of the dependencies for the application.
| .env        | Contains a list of sensitive configurations (e.g. the databases url).
| app.rb      | This is the main file that loads all the dependencies, sets the proper configurations and defines the main routes.
| config.ru   | Rack configuration file.
| filters/    | Contains the form validators. Unlike other frameworks, Cuba delegates validation and whitelisting responsibilities to filter objects.
| helpers/    | Helpers are a simple way to extend Cuba's functionality. This folder contains all the helpers for the application.
| mails/      | Contains mail templates used by the application.
| makefile    | This file contains a series of tasks that can be run from the command line.
| models/     | Contains the models for the application.
| public/     | Contains static files accessible to the public (e.g. web browsers). Such as error pages, images, JavaScript and CSS files, etc.
| routes/     | This folder contains  miniature applications that add functionality to the main one.
| test/       | Application tests.
| views/      | Contains the HTML templates for the application.

Managing Dependencies
---------------------

In every web application, there are common tasks that you need to do
(e.g authenticate users or query a database). Libraries are useful for
not reinventing the wheel, and in Ruby they are often referred to as
**gems**.

Ruby uses [Rubygems](https://rubygems.org/) to distribute them and to
ease the installation. Installing Cuba is as easy as typing
`gem install cuba` in the command line.

Even though **Rubygems** is useful when installing gems, it has its
limitations. Unfortunately, it installs all gems globally. It means
that if you have different versions of a gem installed, you have to
make sure that you require the right version for your project.

[Bundler](http://bundler.io/) is one of the most used tools to solve
this problem. It has approximately ~10k lines of code, that's more than
all the dependencies of this project put together. Because of this
complexity, we'll use a different approach in this book.

"The Right Way"
---------------

Back to the original problem, we need a way to keep track of the
dependencies and install the right version of each one. This is where
[gs](https://github.com/soveran/gs) and [dep](https://github.com/cyx/dep)
come to the rescue.

With **gs** you can create a **gemset** for each project. A **gemset**
is an isolated space to install gems. By providing each project with
their own gemset, you can be sure that the right version of a gem is
loaded.

While **gs** handles the gemset, **dep** keeps track of the dependencies
for your project, making sure that all the dependencies are met.

To install **gs** and **dep**, use the `gem install` command:

```no-highlight
$ gem install gs
$ gem install dep
```

Before installing the dependencies of this project, you need a gemset.
Creating one is as easy as typing:

```no-highlight
$ gs init
```

This command does two things. First, it creates a directory `.gs`, where
Rubygems will install the dependencies. Secondly, it starts a shell session
and set the `.gs` folder as the path where Ruby will look for gems.

Now that we created a local gemset, it's time to install the dependencies
for our project. **dep** uses a `.gems` file to keep track of the required
dependencies for the application. This file lists the gems with their
version numbers.

In our application's folder, you will find the `.gems` file that contains
the dependencies we'll use in this book. We'll talk more about each gem
later.

```no-highlight
cuba -v 3.1.1
cutest -v 1.2.1
hache -v 1.1.0
malone -v 1.0.6
mote -v 1.1.2
mote-render -v 1.0.0
ohm -v 2.0.1
rack-protection -v 1.5.3
rack-test -v 0.6.2
scrivener -v 0.2.0
shield -v 2.1.0
shotgun -v 0.9
```

Finally, we need to install the gems by running:

```no-highlight
$ dep install
```

This simply does a `gem install` for each dependency on the list. **dep**
also has features for adding and removing dependencies. To read more about
**dep**, visit their [home page](http://twpil.github.io/dep/).

Up and Running
--------------

Now that we've installed the dependencies, it's time to see how our
minimal application looks.

To get it up and running, we need to create a file with some
configurations. Go to the command line and type `make setup`.

![setup](/img/book/setup.png)

As you can see, this created a file called *.env*. For now, it's enough
for you to know that this file contains sensitive configurations for the
application. We'll discuss this in more detail later.

To see the application in action, type `make server` in the command line.

![shotgun](/img/book/shotgun.png)

Unlike before, we're now using *shotgun* instead of *rackup*. *Shotgun*
is a gem that reloads the application for every request. That's great for
development because we don't need to restart the server every time that
we change the application. Now navigate to <http://localhost:9393/>. You
should see the Cuba welcome page.

![home](/img/book/home.png)

*Shotgun* uses a *config.ru* file just like *rackup*. Let's see what the
*config.ru* file looks like in this template.

```ruby
require "./app"

run(Cuba)
```

This time the definition of the application has been placed in a different
file. This file is called *app.rb* and is the main file of our application.
In the next section, we'll explore this file.

Loading the Application
-----------------------

In this section, we'll see how the *app.rb* file initializes the
application. This file is important in the boot process because it
defines everything the application needs in order to run. We'll walk
step by step through this file so you understand everything that happens
under the hood.

First, we require the gems we'll use in this project.

```ruby
require "cuba"
require "hache"
require "malone"
...
require "rack/protection"
require "scrivener"
```

Then we define some constants that, for example, are used to connect to a
database or to check cookie data integrity. Because these are sensitive
configurations, we use environment variables instead of putting them
directly into the code.

```ruby
APP_KEY = ENV.fetch("APP_KEY")
APP_SECRET = ENV.fetch("APP_SECRET")
DATABASE_URL = ENV.fetch("DATABASE_URL")
MAIL_URL = ENV.fetch("MAIL_URL")
```

To load these values into our environment, we read them from the *.env*
file when starting the server. Then, we use the `ENV` object to access
them. The `fetch` method will raise an error if a configuration is not
present.

The next part is where we connect Cuba with its friends. We'll have a
closer look later.

```ruby
Ohm.redis = Redic.new(DATABASE_URL)
Malone.connect(url: MAIL_URL)

Cuba.plugin(Mote::Render)
Cuba.plugin(Shield::Helpers)

...

Cuba.use(Rack::Protection)
Cuba.use(Rack::Protection::RemoteReferrer)
```

Next, we require the content of the subfolders where we find the core code
of our application. This includes models, filter objects, helpers, etc.

```ruby
Dir["./models/**/*.rb"].each  { |f| require(f) }
Dir["./filters/**/*.rb"].each { |f| require(f) }
Dir["./helpers/**/*.rb"].each { |f| require(f) }
Dir["./routes/**/*.rb"].each  { |f| require(f) }
```

Finally, you should recognize the last part:

```ruby
Cuba.define do
  on root do
    render("home")
  end
end
```

It's almost the same as in our first example, but with one significant
difference: the `render` method. In the next chapter, we'll explain this
method and see how it can be used to render view templates.

The View
========

Suppose you have to write a big chunk of HTML code. You could write it
like this:

```ruby
Cuba.define do
  on root do
    res.write("
      <html>
        <head>
          <!-- ... -->
        </head>
        <body>
          <!-- ... -->
        </body>
      </html>
    ")
  end
end
```

The problem with this approach is that it's hard to reuse parts of the HTML
that every page uses, for example a navigation bar or a footer. Therefore,
we separate it into *views*, which are templates that gets converted to
HTML and sent back to the browser.

In this chapter, you'll learn how to use [Mote](https://github.com/soveran/mote),
a minimal template engine to render *views*.

Mote
----

Mote is a fast template engine that allows us to put Ruby code into any
plain text document, like HTML.

A very simple example is this:

```ruby
require "mote"

template = Mote.parse("The value of pi is {{ Math::PI }}")
template.call
# => The value of pi is 3.141592653589793
```

Mote recognizes two tags to evaluate Ruby code: `%` and `{{}}`.
The difference between them is that while the `%` tag only evaluates
the code, the `{{}}` tag also prints the result to the template.

The next example shows a list of different use cases you may face:

```ruby
% # This is a comment.
% x = 2
% y = 1

<p>The value of x is {{ x }}</p>
<p>The value of y is {{ y }}</p>
<p>The sum of x and y is {{ x + y }}</p>
```

Following the above example, the printed result will be:

```html
<p>The value of x is 2</p>
<p>The value of y is 1</p>
<p>The sum of x and y is 3</p>
```

The next section shows how to integrate Mote with Cuba.

Mote & Cuba
-----------

To use Mote in our application, we have to require the `mote/render` file
and include the `Mote::Render` plugin that comes with it. If we look closely,
this has already been done in the `app.rb` file:

```ruby
require "mote"
require "mote/render"

...

Cuba.plugin(Mote::Render)
```

The `Mote::Render` plugin is provided by the [mote-render](https://github.com/frodsan/mote-render/)
gem, one of the gems we installed in the section [Managing Dependencies](/en/setting_the_road/managing_dependencies.html).

Templates
---------

Now that we have included Mote in our project, it's time to have
a look at the  *view templates*. All view templates are typically
placed in a folder named `views` as shown in the section
[Structuring the Application](/en/setting_the_road/structuring_the_application.html).

If we have a look at the `views` folder in our application, we see two
files, `layout.mote` and `home.mote`. The `layout.mote` is used to
define the main structure of our site. It contains all the elements
that will be repeated on every page rendered by our application, such
as the header and footer.

In our case it looks like this:

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>App</title>
    <link href="/css/styles.css" rel="stylesheet" type="text/css">
  </head>
  <body>
    {{ params[:content] }}
  </body>
</html>
```

Here we define a simple HTML document, with a header and a body.
The header will be the same on all our pages and is therefore
included in the main layout. The content of the body however will differ
and is passed to the layout depending on which page we want to render.

As you can see the content parameter is printed to the template using
the `{{}}` tags, like this: `{{ params[:content] }}`.

Now, have a look at the `home.mote` file. The content of this file is
rendered when displaying the home page of the application. Right now it's
showing an embedded version of the Cuba home page.

```html
<iframe src="http://cuba.is" frameborder="0" height="100%" width="100%">
  You need a Frames Capable browser to view this content.
</iframe>
```

Open the file and replace the content with the following:

```html
<p>Hello Cuba!</p>
```

If you start your server and go to
[localhost:9393](http://localhost:9393), you should see the following
greeting:

![hello](/img/book/hello2.png)

You changed the content of the home page!
