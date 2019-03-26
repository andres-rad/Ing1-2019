!classDefinition: #LuzAmarilla category: #Semaforo!
DenotativeObjectMorph subclass: #LuzAmarilla
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LuzAmarilla class' category: #Semaforo!
LuzAmarilla class
	instanceVariableNames: ''!

!LuzAmarilla class methodsFor: 'morph' stamp: 'AR 3/25/2019 20:28:22'!
apagar
	self color: Color black.! !

!LuzAmarilla class methodsFor: 'morph' stamp: 'AR 3/25/2019 20:07:45'!
createMorph

	^EllipseMorph new
		color: Color black;
		yourself! !

!LuzAmarilla class methodsFor: 'morph' stamp: 'AR 3/25/2019 20:37:48'!
encender
	self color: Color yellow.! !

!LuzAmarilla class methodsFor: 'morph' stamp: 'AR 3/25/2019 20:53:20'!
titilar
	self apagar.
	(Delay for: 0.5*second) wait.
	self encender.! !


!LuzAmarilla class methodsFor: 'as yet unclassified' stamp: 'AR 3/25/2019 20:58:50'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := (EllipseMorph basicNew instVarAt: 1 put: nil; instVarAt: 2 put: #(); instVarAt: 3 put: (MorphicTranslation basicNew instVarAt: 1 put: 0.0; instVarAt: 2 put: 0.0; yourself); instVarAt: 4 put: false; instVarAt: 5 put: nil; instVarAt: 6 put: nil; instVarAt: 7 put: 50@40; instVarAt: 8 put: (Color r: 0.000 g: 0.000 b: 0.000); instVarAt: 9 put: 1; instVarAt: 10 put: (Color r: 0.500 g: 0.500 b: 0.500); yourself).! !


!classDefinition: #LuzRoja category: #Semaforo!
DenotativeObjectMorph subclass: #LuzRoja
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LuzRoja class' category: #Semaforo!
LuzRoja class
	instanceVariableNames: ''!

!LuzRoja class methodsFor: 'morph' stamp: 'AR 3/25/2019 20:28:28'!
apagar
	self color: Color black.! !

!LuzRoja class methodsFor: 'morph' stamp: 'AR 3/25/2019 20:05:24'!
createMorph

	^EllipseMorph new
		color: Color black;
		yourself! !

!LuzRoja class methodsFor: 'morph' stamp: 'AR 3/25/2019 20:47:59'!
encender
	self color: Color red.! !


!LuzRoja class methodsFor: 'as yet unclassified' stamp: 'AR 3/25/2019 20:58:50'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := (EllipseMorph basicNew instVarAt: 1 put: nil; instVarAt: 2 put: #(); instVarAt: 3 put: (MorphicTranslation basicNew instVarAt: 1 put: 0.0; instVarAt: 2 put: 0.0; yourself); instVarAt: 4 put: false; instVarAt: 5 put: nil; instVarAt: 6 put: nil; instVarAt: 7 put: 50@40; instVarAt: 8 put: (Color r: 0.000 g: 0.000 b: 0.000); instVarAt: 9 put: 1; instVarAt: 10 put: (Color r: 0.500 g: 0.500 b: 0.500); yourself).! !


!classDefinition: #LuzVerde category: #Semaforo!
DenotativeObjectMorph subclass: #LuzVerde
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LuzVerde class' category: #Semaforo!
LuzVerde class
	instanceVariableNames: ''!

!LuzVerde class methodsFor: 'morph' stamp: 'AR 3/25/2019 20:28:32'!
apagar
	self color: Color black.! !

!LuzVerde class methodsFor: 'morph' stamp: 'AR 3/25/2019 20:07:35'!
createMorph

	^EllipseMorph new
		color: Color black;
		yourself! !

!LuzVerde class methodsFor: 'morph' stamp: 'AR 3/25/2019 20:48:12'!
encender
	self color: Color green.! !


!LuzVerde class methodsFor: 'as yet unclassified' stamp: 'AR 3/25/2019 20:58:50'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := (EllipseMorph basicNew instVarAt: 1 put: nil; instVarAt: 2 put: #(); instVarAt: 3 put: (MorphicTranslation basicNew instVarAt: 1 put: 0.0; instVarAt: 2 put: 0.0; yourself); instVarAt: 4 put: false; instVarAt: 5 put: nil; instVarAt: 6 put: nil; instVarAt: 7 put: 50@40; instVarAt: 8 put: (Color r: 0.000 g: 0.000 b: 0.000); instVarAt: 9 put: 1; instVarAt: 10 put: (Color r: 0.500 g: 0.500 b: 0.500); yourself).! !


!classDefinition: #Semaforo category: #Semaforo!
DenotativeObjectMorph subclass: #Semaforo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Semaforo class' category: #Semaforo!
Semaforo class
	instanceVariableNames: 'luzRoja luzVerde luzAmarilla'!

!Semaforo class methodsFor: 'morph' stamp: 'AR 3/25/2019 20:05:34'!
createMorph

	^LayoutMorph newColumn
		morphExtent: 60 @ 130;
		yourself
! !


!Semaforo class methodsFor: 'inicializacion' stamp: 'AR 3/25/2019 20:33:42'!
agregarLuces
	"
	Crea en el semáforo las tres luces que tiene un semáforo (Roja, Amarilla, Verde)
	En principio empiezan todas apagadas.
	"
	LuzAmarilla color: Color black.
	LuzVerde color: Color black.
	LuzRoja color: Color black.
	
	self addMorph: LuzRoja.
	self addMorph: LuzAmarilla.
	self addMorph: LuzVerde.! !

!Semaforo class methodsFor: 'inicializacion' stamp: 'AR 3/25/2019 20:46:48'!
señalizarEncendido
	"
	Cuando un semáforo se prende lo primero que hace es titilar las luces amarillas 5 veces para avisar 
	 precaución por encendido.
	"
	5 timesRepeat: [
		self titilar: LuzAmarilla.
	]! !

!Semaforo class methodsFor: 'inicializacion' stamp: 'AR 3/25/2019 20:53:47'!
señalizarEncendido2
	"
	Cuando un semáforo se prende lo primero que hace es titilar las luces amarillas 5 veces para avisar 
	 precaución por encendido (con esta versión se muestra en pantalla).
	"
	5 timesRepeat: [
		LuzAmarilla titilar.
		(Delay for: 0.5*second) wait.
	]! !

!Semaforo class methodsFor: 'inicializacion' stamp: 'AR 3/25/2019 20:47:10'!
titilar: aLuz
	aLuz apagar.
	(Delay for: 0.5*second) wait.
	aLuz encender.! !


!Semaforo class methodsFor: 'creacion' stamp: 'AR 3/25/2019 20:34:42'!
apagar
	"
	Apaga todas las luces del semáforo.
	"
	LuzRoja apagar.
	LuzAmarilla apagar.
	LuzVerde apagar.! !

!Semaforo class methodsFor: 'creacion' stamp: 'AR 3/25/2019 20:32:12'!
encender
	"
	Inicializa el semáforo y lo muestra en pantalla.
	"
	self openInWorld.
	self agregarLuces.
	self señalizarEncendido.
! !


!Semaforo class methodsFor: 'as yet unclassified' stamp: 'AR 3/25/2019 20:58:50'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.
	luzRoja := nil.
	luzVerde := nil.
	luzAmarilla := nil.! !

LuzAmarilla initializeAfterFileIn!
LuzRoja initializeAfterFileIn!
LuzVerde initializeAfterFileIn!
Semaforo initializeAfterFileIn!