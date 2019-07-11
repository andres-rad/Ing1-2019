Para setear todo hay dos formas:

    1. Abrir la imagen que esta en el repo (en linux64/)
    2. hacer file in de WebClient-Core.st, donde se le agrego un unico método a la clase WebServer (o agregarla a mano) y luego hacer filein de TusLibros-Web.st

Luego, una vez adentro, la clase TusLibrosLocalTester se encarga de levantar un servidor y abrir un cliente, se usa asi:

    a := TusLibrosLocalTester new.

y listo, también se puede ver la implementacion para ver como hacerlo a mano. se puede inspeccionar a para ver el system facade y otros colaboradores en caso de querer debuggear

Usuarios validos
    teo - freund
    andy - radunsky