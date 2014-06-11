Rack & Roll!
============

Como mencionamos anteriormente, Cuba está construido sobre Rack ... qué
es *Rack*?

Rack se ocupa de las peticiones HTTP, proporcionando una mínima interface
entre los servidores web que soportan Ruby y los diferentes frameworks
hechos en Ruby. Sin Rack, Cuba tendría que implementar su propio código
para soportar los diferentes servidores web.

![rack](../assets/rack.png)

Talvez no te diste cuenta, pero ya hemos usado Rack. Usamos `rackup`,
una de las herramientas que vienen con Rack, para correr nuestra primera
aplicación.

Para utilizar `rackup`, es necesario proporcionar un archivo de
configuración (por convención se usa la extensión *.ru*). Este archivo
conecta la interface de Rack con nuestra aplicación a través del método
`run`. Este método recibe un objecto que retorna una respuesta de Rack.
En nuestro caso, este objeto es nuestra aplicación Cuba.

```ruby
run(Cuba)
```

`rackup` también sabe que servidores se encuentran disponibles. Cuando
nosotros ejecutamos `rackup config.ru`, éste lanzó *WEBRick*, el servidor
web que Ruby trae por defecto.

```
$ rackup config.ru
[2014-05-06 23:37:23] INFO  WEBrick 1.3.1
...
```

Para saber más sobre Rack, visita la página web del proyecto:
<http://rack.github.io>.
