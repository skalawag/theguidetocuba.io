Managing Dependencies
=====================

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

```
$ gem install gs
$ gem install dep
```

Before installing the dependencies of this project, you need a gemset.
Creating one is as easy as typing:

```
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

```
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

```
$ dep install
```

This simply does a `gem install` for each dependency on the list. **dep**
also has features for adding and removing dependencies. To read more about
**dep**, visit their [home page](http://twpil.github.io/dep/).
