Mote & Cuba
===========

To use Mote in our application, we have to require the `mote/render` file
and include the `Mote::Render` plugin that comes with it. If we look closely,
this has already been done in the `app.rb` file:

```ruby
require "cuba"
require "mote"
require "mote/render"

...

Cuba.plugin(Mote::Render)
```

The `Mote::Render` plugin is provided by the [mote-render](https://github.com/frodsan/mote-render/)
gem, one of the gems we installed in the section [Managing Dependencies](/en/setting_the_road/managing_dependencies.html).
