Entendiendo el cógido
=====================

Ahora que sabemos cómo crear una aplicación mínima con Cuba, vamos a
echar un vistazo más profundo al código. Podemos dividir este pequeño
ejemplo en tres partes:

En primer lugar, usamos el método `require` para cargar el código de
Cuba.

```ruby
require "cuba"
```

Luego, podemos identificar cuatro métodos que son muy usados: `define`,
`on`, `root` and `res`.

```ruby
Cuba.define do
  on root do
    res.write("Hello, Cuba!")
  end
end
```

* `define`, como su nombre lo dice, nos permite definir una aplicación
  a través de un *block*.

* `on` ejecuta un *block* determinado si al evaluar las condiciones,
  estas retornan `true`.

* `root` retorna `true` sólo si la ruta a la que se accede es la raíz
  de la aplicación (`"/"` or `""`).

* `res` maneja la respuesta del servidor. En este caso, usamos el
  método `write` para mostrar el mensaje de bienvenida.

Finalmente, la última línea conecta nuestra aplicación con Rack.

```ruby
run(Cuba)
```

No te preocupes si no entiendes qué es Rack ahora, vamos a discutirlo
en la siguiente sección.
