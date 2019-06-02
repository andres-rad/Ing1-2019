!classDefinition: #CarritoDeComprasTest category: #'Ing-Soft-TusLibros.com'!
TestCase subclass: #CarritoDeComprasTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ing-Soft-TusLibros.com'!

!CarritoDeComprasTest methodsFor: 'testing' stamp: 'atr 6/2/2019 16:45:53'!
test01UnCarritoDeComprasNuevoEstaVacio
	
	| unCarrito |
	
	unCarrito _ CarritoDeCompras conCatalogo: #().
	
	self assert: unCarrito isEmpty.! !

!CarritoDeComprasTest methodsFor: 'testing' stamp: 'atr 6/2/2019 16:41:36'!
test02CuandoAgregoAlgunElementoAlCarritoNoEstaVacio

	| unCarrito |
	
	unCarrito _ CarritoDeCompras conCatalogo: #('Cavegol').
	unCarrito agregarCantidad: 1 deLibro: 'Cavegol'.
	
	self deny: unCarrito isEmpty.
	! !

!CarritoDeComprasTest methodsFor: 'testing' stamp: 'atr 6/2/2019 16:41:54'!
test03ElCarritoConoceLosElementosQueTieneAgregados

	| unCarrito |
	
	unCarrito _ CarritoDeCompras conCatalogo: #('Cavegol').
	unCarrito agregarCantidad: 4 deLibro: 'Cavegol'.
	
	self assert: (unCarrito tieneLibro: 'Cavegol').
	! !

!CarritoDeComprasTest methodsFor: 'testing' stamp: 'atr 6/2/2019 16:42:04'!
test04ElCarritoNoConoceUnElementoQueNoTieneAgregado

	| unCarrito |
	
	unCarrito _ CarritoDeCompras conCatalogo: #('Cavegol').
	unCarrito agregarCantidad: 4 deLibro: 'Cavegol'.
	
	self assert: (unCarrito tieneLibro: 'Yo Cumbio') not.
	! !

!CarritoDeComprasTest methodsFor: 'testing' stamp: 'atr 6/2/2019 16:46:13'!
test05SoloSePuedenAgregarAlCarritoCantidadesPositivasParaUnLibro

	| unCarrito |
	
	unCarrito _ CarritoDeCompras conCatalogo: #('Yo soy el Diego').
	
	self 
		should: [ unCarrito agregarCantidad: -4 deLibro: 'Yo soy el Diego'] 
		raise: Error
		withMessageText: CarritoDeCompras cantidadNegativaErrorDescription.! !

!CarritoDeComprasTest methodsFor: 'testing' stamp: 'atr 6/2/2019 16:25:21'!
test06NoSePuedenAgregarAlCarritoLibrosQueNoEstenEnSuCatalogo

	| unCarrito |
	
	unCarrito _ CarritoDeCompras conCatalogo: #('La Final de Nuestras Vidas').
	
	self 
		should: [ unCarrito agregarCantidad: 4 deLibro: 'Gallardo Monumental'] 
		raise: Error
		withMessageText: CarritoDeCompras libroNoEnCatallogoErrorDescription.! !

!CarritoDeComprasTest methodsFor: 'testing' stamp: 'atr 6/2/2019 16:37:59'!
test07ElCarritoConoceLaCantidadDeCadaElementoQueTieneAgregado

	| unCarrito |
	
	unCarrito _ CarritoDeCompras conCatalogo: #('La Final de Nuestras Vidas' 'Gallardo Recargado').
	
	unCarrito agregarCantidad: 4 deLibro: 'La Final de Nuestras Vidas'. 
	unCarrito agregarCantidad: 1 deLibro: 'Gallardo Recargado'.
	
	self assert: (unCarrito cantidadDeLibro: 'La Final de Nuestras Vidas') equals: 4.
	self assert: (unCarrito cantidadDeLibro: 'Gallardo Recargado') equals: 1.
	! !

!CarritoDeComprasTest methodsFor: 'testing' stamp: 'atr 6/2/2019 16:39:47'!
test08ElCarritoTieneCantidadCeroDeLibrosQueNoLeAgregaron

	| unCarrito |
	
	unCarrito _ CarritoDeCompras conCatalogo: #('La Final de Nuestras Vidas' 'Gallardo Recargado').
	
	unCarrito agregarCantidad: 4 deLibro: 'La Final de Nuestras Vidas'. 
	unCarrito agregarCantidad: 1 deLibro: 'Gallardo Recargado'.
	
	self assert: (unCarrito cantidadDeLibro: 'Heroes') equals: 0.
	! !


!classDefinition: #CarritoDeCompras category: #'Ing-Soft-TusLibros.com'!
Object subclass: #CarritoDeCompras
	instanceVariableNames: 'libros catalogo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ing-Soft-TusLibros.com'!

!CarritoDeCompras methodsFor: 'agregar' stamp: 'atr 6/2/2019 16:33:20'!
agregarCantidad: unaCantidad deLibro: unLibro 
	
	(unaCantidad < 0) ifTrue: [self error: (self class cantidadNegativaErrorDescription)].
	(catalogo includes: unLibro) ifFalse: [self error: (self class libroNoEnCatallogoErrorDescription)].
	
	(libros includesKey: unLibro) 
		ifTrue: [ libros at: unLibro put: (libros at: unLibro + unaCantidad)]
		ifFalse: [ libros at: unLibro put: unaCantidad ].! !


!CarritoDeCompras methodsFor: 'initialization' stamp: 'atr 6/2/2019 16:29:26'!
conCatalogo: unCatalogo 
	catalogo _ unCatalogo.
	libros _ Dictionary  new.! !


!CarritoDeCompras methodsFor: 'elementos' stamp: 'atr 6/2/2019 16:40:20'!
cantidadDeLibro: unLibro
	^ libros at: unLibro ifAbsent: 0.! !


!CarritoDeCompras methodsFor: 'testing' stamp: 'atr 6/1/2019 23:42:53'!
isEmpty
	^libros isEmpty.! !

!CarritoDeCompras methodsFor: 'testing' stamp: 'atr 6/2/2019 00:00:21'!
tieneLibro: unLibro
	^ libros includesKey: unLibro.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CarritoDeCompras class' category: #'Ing-Soft-TusLibros.com'!
CarritoDeCompras class
	instanceVariableNames: ''!

!CarritoDeCompras class methodsFor: 'errores' stamp: 'atr 6/2/2019 00:11:32'!
cantidadNegativaErrorDescription
	^'La cantidad debe ser un numero entero positivo'.! !

!CarritoDeCompras class methodsFor: 'errores' stamp: 'atr 6/2/2019 16:29:53'!
libroNoEnCatallogoErrorDescription
	^ 'El libro indicado no se encuentra en el catalogo'.! !


!CarritoDeCompras class methodsFor: 'class initialization' stamp: 'atr 6/2/2019 16:27:59'!
conCatalogo: unCatalogo 
	| unCarrito |
	
	unCarrito _ CarritoDeCompras new.
	^ unCarrito conCatalogo:  unCatalogo.! !
