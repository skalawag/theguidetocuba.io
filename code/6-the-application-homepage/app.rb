require "cuba"
require "mote"
require "mote/render"

Cuba.plugin(Mote::Render)

Cuba.define do
  on root do
    render("home")
  end
end
