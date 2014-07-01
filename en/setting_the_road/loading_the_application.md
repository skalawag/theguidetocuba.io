Loading the Application
=======================

In this section, we'll see how the *app.rb* file initializes the
application. This file is important in the boot process because it
defines everything the application needs in order to run. We'll walk
step by step through this file so you understand everything that happens
under the hood.

First, we require the gems we'll use in this project.

```ruby
require "cuba"
require "hache"
require "mote"
...
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
```

To load these values into our environment, we read them from the *.env*
file when starting the server. Then, we use the `ENV` object to access
them. The `fetch` method will raise an error if a configuration is not
present.

The next part is where we connect Cuba with its friends. We'll have a
closer look later.

```ruby
Ohm.redis = Redic.new(DATABASE_URL)

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
