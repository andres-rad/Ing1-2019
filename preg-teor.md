## Preg teoricas de ejs 25-29

### Object Recursion

http://www.industriallogic.com/patterns/P21.pdf

_¿Qué intenta resolver el patrón Object Recursion?_

El patron Object Recursion busca simplificar la implementación de métodos en objetos complejos, separando estos en partes más pequeñas y pasando la responsabilidad de resolver parte del problema a sus partes más simples. La idea se basa en que, eventualmente, uno debería llegar a un objeto tan simple que se pueda resolver trivialmente. A través del polimorfismo esta recursión se implementa naturalmente, y permite también abstraer y encapsular el algoritmo aún más, ya que no es necesario conocer los objetos a los cuales se hace recursión.

_Presente un ejemplo (diferente al del paper) que se pueda abordar con dicho patrón_

Un posible ejemplo sería si uno tuviese un objeto que modela a una ciudad como un conjunto de barrios, a un barrio como un conjunto de manzanas, a una manzana como un conjunto de construcciones, donde las construcciones pueden ser o casas o edificios, donde estos últimos se modelan cómo un conjunto de casas. Si ahora se requiriese implementar un método para preguntar si cierta persona vive en una ciudad, con Object Recursion podríamos resolver este problema para cada uno de los objetos involucrados (donde la casa sería la base de la recursión y se debería poder resolver trivialmente, o la casa podría contener una lista de personas y hacer recursión un paso más sobre ellas). 

Cabe notar que utilizar el patrón de Object Recursion no solo simplificaría la implementación, sino que, ya que encapsulamos nuestra implementación, es probable que la solución sea más general y permita, por ejemplo, resolver otros casos, como una ciudad pequeña donde no hay barrios, o poder agregar otra clase de construcción sin tener que hacer cambios en las otras clases.

_¿Cómo se relaciona el patrón Object Recursion con el patrón Decorator?_

Según Woolf, el patrón Object Recursion es más general que el Decorator, mientras que el segundo responde a un patrón estructural, el primero responde a un patrón de comportamiento. Esto implica que el Decorator muchas veces puede incluir al patrón de Object Recursion.

### No Silver Bullet – Essence and Accident in Software Engineering

http://worrydream.com/refs/Brooks-NoSilverBullet.pdf

_Describa las características inalienables al software que Brooks presenta_

En este trabajo Brooks distingue cuatro propiedades que son escenciales a la tarea del desarrollo del software:

* Complejidad

El software tiene una complejidad inherente debido entre otras causas al tamaño de los sistemas de software pensado como el conjunto de estados posibles que puede tener, a la cantidad de partes diferentes que tienen que interactuar, y de como este número crece siempre que crece el sistema. Dada la naturaleza escencial de la complejidad, no puede haber herramientas que ayuden a abstraerla, ya que eso implicaría ignorar elementos escenciales del software.

La complejidad ocasiona dificultades para la comunicación entre equipos, para agregar funcionalidades a un software existentey para tener un conocimiento integral de lo que está solucionando el sistema.

* Conformismo

En el desarrollo de software no existen principios básicos que puedan aplicarse a cualquier situación, ya que uno siempre termina enfrentandose a un problema cuya complejidad está decidida arbitrariamente por el cliente que define la interfaz a la que debe adaptarse.

* Volatibilidad

Las entidades de software debido a la percepción de que son fáciles de modificar, están bajo presión constante de ser modificadas, tanto alterando funcionalidades como extendiéndolas. 

* Invisibilidad

El software es escencialmente invisible, ya que realmente no existe en ningún espacio físico. Debido a esto, el ingeniero de software no tiene abstracciones que lo ayuden a visualizar de manera concisa la estructura del software que está diseñando.

_¿Por qué desarrollar software es esencialmente complejo según Brooks?_

Al principio del paper Brooks clasifica las tareas relacionadas a la construcción de software en dos clases, las escenciales y las accidentales. Para él la parte más difícil del desarrollo de software ocurre en las tareas escenciales, que llevan atadas todas las características enumeradas en la pregunta anterior. Como estuvimos viendo a lo largo de la materia, todas estas tareas están relacionadas a una actividad creativa más que a una mecánica (lo que sería el diseño del modelo que tiene que tener el software para resolver el problema).

### Decorator, Adapter, Proxy

_Describa similitudes y diferencias entre Decorator y Adapter._

Si bien Decorator y Adapter son similares, no son iguales. Ambos tienen el objetivo de situarse alrededor (encima) de otro objeto (el decoratee o adaptee) y modificar la interfaz o funcionalidad de cierta manera. Por ejemplo, un adapter podría modificar la interfaz pública de un string cambiando el selector para conseguir el tamaño de `size` a `length` (o viceversa). O un Decorator podría querer modificar como se muestra un string en pantalla para que cambie los espacios ` ` por guiones bajos `_`, sin cambiar la representación interna.

Por otro lado, sus diferencias no son menores, mientras que un Decorator se utiliza para cambiar el funcionamiento de un objeto sin modificar su interfaz, un Adapter tiene cómo objetivo lo contrario, es decir mapear la funcionalidad de un objeto (en principio sin modificarla enormemente) a otra interfaz.

_¿Qué ventajas y desventajas tiene implementar un Proxy polimórfico sobre uno no polimórfico?_

La ventaja principal de implementar un Proxy polimórfico es que permite hacer que la funcionalidad agregada por el proxy sea invisible al usuario, esto tiene dos consecuencias buenas, la primera que simplifica el código, por ejemplo, pensando en el Lazy Proxy visto en clase, una vez que decidimos que cierto objeto es necesario envolverlo en un Lazy Proxy, si este es polimórfico con el objeto subyacente, no hay que cambiar nada más en la implementación, e incluso podemos olvidarnos de eso. La segunda es que nos permite utilizar métodos que esperan una instancia del objeto subyacente sin pagar nada extra (modificar código) por ejemplo, no hace falta tener dos métodos, uno que espere una lista cómun y otro que espere una lista Lazy.

La principal desventaja es que puede dar lugar a situaciones complicadas a medida que crece el sistema. Por ejemplo, qué pasa si uno quisiese (o lo hace por error) envolver un objeto en dos proxys distintos. O si comienza a hacer programas con metaprogramación y se olvida (o nunca supo) que una instancia de un objeto X era en realidad una instancia de un objeto X envuelta en un proxy, si bien es polimórfica, al pedirle la clase el resultado no es el esperado. Y esto podría fallar en situaciones complicadas. En algún sentido, puede convenir ser explícito al respecto.

_¿Qué es el problema de la “identidad” o de “self”? ¿En cuáles de estos patrones aplica?_

Cuando se habla del problema de la "identidad" o de "self" se hace referencia a una situación en la que la variable self puede referenciar a dos objetos diferentes. Esto ocurre principalmente cuando se realiza forwardeo de mensajes entre clases, ya que en este acto el objeto emisor del mensaje delega la responsabilidad al receptor. Este problema aplica principalmente al patrón de proxy, ya que su intención no es modificar la identidad del objeto decorado, si no que con este patrón lo que se hace es agregar dinámicamente funcionalidad a un objeto preexistente. Para verlo mejor supongamos que tenemos una clase A que responde a los mensajes m1 y m2 tal que m2 tiene la siguiente implementacion

m2
  ...
  self m1
  ...
  
Por otro lado se crea un Decorador para la clase A con el objetivo de loguear lo que ocurre con ella, para ello implementa los mensajes m1 y m2 como

m1
  ...logueo m1 de alguna manera...
  ^decoratee m1


m2
  ...logueo m1 de alguna manera...
  ^decoratee m2
  
Al hacer decorator m2 en algún momento uno esperaría que se logueasen tanto m2 como m1 (ya que en A m2 llama a m1), pero al forweardear el mensaje m1 a su decoratee dentro del contexto de ejecución de m1 ocuree que self == decoratee por lo que la colaboración self m1 no va a loguearse.


### Future

_El patrón Future se utiliza para:_
* Obtener una referencia a un resultado que es inmediato.
X Poder programar asincronicamente, paralelizando la ejecución y sincronizando los resultados.
* Ninguna de las anteriores.
* Las respuestas a y b son válidas.

_Explique por qué son importantes las promesas en un lenguaje fuertemente basado en eventos como Javascript_

Las promesas son importantes en lenguajes basados en eventos ya que nos permiten responder a estos de forma casi instantanea, basándonos en ellas para paralelizar la ejecución del callback de cierto evento. Si no tuviesemos Futures (o alguna otra herramienta para paralelizar código) sería díficil tener software que reaccione rápidamente a los eventos.

_Explique que es un future transparente o polimórfico. ¿Qué ventajas tiene con respecto a uno que no comparte el mismo protocolo que el objeto a proxiar?_

Se refiere a un futuro que mantiene polimorfismo con el objeto que genera forwardeando los mensajes. Esto implica que puedo tratar a un Futuro de una instancia de un objeto X cómo si fuera la instancia del objeto X. La ventaja principal de esta funcionalidad es que no hace falta explicitar operaciones inherentes del Future, por ejemplo, `wait` o `value`. Y simplemente podemos utilizarlo como si fuese el valor esperado. Esto genera código mucho más simple y fácil de entender.

Además, tener Futures polimórficos permite (muy fácilmente) tomar programas ya escritos y agregarles paralelización, simplemente rastreando que objetos tardan mucho en crearse y envolviéndoos con un Future.
