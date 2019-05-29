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

_¿Qué ventajas y desventajas tiene implementar un Proxy polimórfico sobre uno no polimórfico?_

_¿Qué es el problema de la “identidad” o de “self”? ¿En cuáles de estos patrones aplica?_

### Future

_El patrón Future se utiliza para:_
* Obtener una referencia a un resultado que es inmediato.
* Poder programar asincronicamente, paralelizando la ejecución y sincronizando los resultados.
* Ninguna de las anteriores.
* Las respuestas a y b son válidas.

_Explique por qué son importantes las promesas en un lenguaje fuertemente basado en eventos como Javascript_

_Explique es un future transparente o polimórfico. ¿Qué ventajas tiene con respecto a uno que no comparte el mismo protocolo que el objeto a proxiar?_
