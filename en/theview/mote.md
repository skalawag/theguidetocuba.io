Mote
====

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
