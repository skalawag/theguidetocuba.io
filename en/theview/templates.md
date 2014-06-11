Templates
=========

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

![hello](../assets/hello2.png)

You changed the content of the home page!
