## Preg teoricas de ejs 25-29

### Object Recursion

http://www.industriallogic.com/patterns/P21.pdf

_¿Qué intenta resolver el patrón Object Recursion?_

El patron Object Recursion busca simplificar la implementación de métodos en objetos complejos, separando estos en partes más pequeñas y pasando la responsabilidad de resolver parte del problema a sus partes más simples. La idea se basa en que eventualmente, uno debería llegar a un objeto tan simple que se pueda resolver trivialmente. A través del polimorfismo esta recursión se implementa naturalmente, y permite también abstraer y encapsular el algoritmo aún más, ya que no es necesario conocer los objetos a los cuales se hace recursión.

_Presente un ejemplo (diferente al del paper) que se pueda abordar con dicho patrón_

CREO QUE ESTA MAL, PORQUE TIENEN UNA RELACION ESTRUCTURAL LOS OBJETOS

Un posible ejemplo sería si uno tuviese un objeto que modela a una ciudad como un conjunto de barrios, a un barrio como un conjunto de manzanas, a una manzana como un conjunto de construcciones, donde las construcciones pueden ser o casas o edificios, donde estos últimos se modelan cómo un conjunto de casas. Si ahora se requiriese implementar un método para preguntar si cierta persona vive en una ciudad, con Object Recursion podríamos resolver este problema para cada uno de los objetos involucrados (donde la casa sería la base de la recursión y se debería poder resolver trivialmente). 

Cabe notar que no solo utilizar el patrón de Object Recursion simplificaría la implementación, sino que, ya que encapsulamos nuestra implementación, es probable que la solución sea más general y permita, por ejemplo, resolver otros casos, como una ciudad pequeña donde no hay barrios.

_¿Cómo se relaciona el patrón Object Recursion con el patrón Decorator?_

Según Woolf, el patrón Object Recursion es más general que el Decorator, mientras que el segundo responde a un patrón estructural, el primero responde a un patrón de comportamiento. Esto implica que el Decorator muchas veces puede incluir al patrón de Object Recursion.

### No Silver Bullet – Essence and Accident in Software Engineering

http://worrydream.com/refs/Brooks-NoSilverBullet.pdf

_Describa las características inalienables al software que Brooks presenta_

_¿Por qué desarrollar software es esencialmente complejo según Brooks?_

### Decorator, Adapter, Proxy

_Describa similitudes y diferencias entre Decorator y Adapter._

Si bien Decorator o Adapter son similares, no son iguales. Ambos tienen el objetivo de situarse alrededor (encima) de otro objeto (el decoratee o adaptee) y modificar la interfaz o funcionalidad de cierta manera. Por ejemplo, un adapter podría modificar la interfaz pública de un string cambiando el selector para conseguir el tamaño de `size` a `length` (o viceversa). O un Decorator podría querer modificar como se muestra un string en pantalla para que cambie los espacios ` ` por guiones bajos `_`, sin cambiar la representación interna.

Por otro lado, sus diferencias no son menores, mientras que un Decorator se utiliza para cambiar el funcionamiento de un objeto sin modificar su interfaz, un Adapter tiene cómo objetivo lo contrario, es decir mapear la funcionalidad de un objeto (en principio sin modificarla enormemente) a otra interfaz.

_¿Qué ventajas y desventajas tiene implementar un Proxy polimórfico sobre uno no polimórfico?_

La ventaja principal de implementar un Proxy polimórfico es que permite hacer que la funcionalidad agregada por el proxy sea invisible al usuario, esto tiene dos consecuencias buenas, la primera que simplifica el código, por ejemplo, pensando en el Lazy Proxy visto en clase, una vez que decidimos que cierto objeto es necesario envolverlo en un Lazy Proxy, si este es polimórfico con el objeto subyacente, no hay que cambiar nada más en la implementación, e incluso podemos olvidarnos de eso. La segunda es que nos permite utilizar métodos que esperan una instancia del objeto subyacente sin pagar nada extra (modificar código) por ejemplo, no hace falta tener dos métodos, uno que espere una lista cómun y otro que espere una lista Lazy.

_¿Qué es el problema de la “identidad” o de “self”? ¿En cuáles de estos patrones aplica?_

### Future

_El patrón Future se utiliza para:_
* Obtener una referencia a un resultado que es inmediato.
* Poder programar asincronicamente, paralelizando la ejecución y sincronizando los resultados.
* Ninguna de las anteriores.
* Las respuestas a y b son válidas.

_Explique por qué son importantes las promesas en un lenguaje fuertemente basado en eventos como Javascript_

_Explique es un future transparente o polimórfico. ¿Qué ventajas tiene con respecto a uno que no comparte el mismo protocolo que el objeto a proxiar?_
