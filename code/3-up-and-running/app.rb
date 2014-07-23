require "cuba"

Cuba.define do
  on root do
    res.write("<h1>Hello, Cuba!</h1>")
  end
end
