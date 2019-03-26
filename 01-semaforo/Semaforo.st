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


!LuzAmarilla class methodsFor: 'as yet unclassified' stamp: 'AR 3/25/2019 21:27:36'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !


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


!LuzRoja class methodsFor: 'as yet unclassified' stamp: 'AR 3/25/2019 21:27:36'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !


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


!LuzVerde class methodsFor: 'as yet unclassified' stamp: 'AR 3/25/2019 21:27:36'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !


!classDefinition: #SemaforoDeMaipuYCorrientes category: #Semaforo!
DenotativeObjectMorph subclass: #SemaforoDeMaipuYCorrientes
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SemaforoDeMaipuYCorrientes class' category: #Semaforo!
SemaforoDeMaipuYCorrientes class
	instanceVariableNames: 'luzRoja luzVerde luzAmarilla'!

!SemaforoDeMaipuYCorrientes class methodsFor: 'morph' stamp: 'AR 3/25/2019 20:05:34'!
createMorph

	^LayoutMorph newColumn
		morphExtent: 60 @ 130;
		yourself
! !


!SemaforoDeMaipuYCorrientes class methodsFor: 'inicializacion' stamp: 'AR 3/25/2019 21:21:28'!
agregarLuces
	"
	Crea en el semáforo las tres luces que tiene un semáforo (Roja, Amarilla, Verde)
	En principio empiezan todas apagadas.
	"
	LuzAmarilla encender.
	LuzVerde encender.
	LuzRoja encender.
	
	self addMorph: LuzRoja.
	self addMorph: LuzAmarilla.
	self addMorph: LuzVerde.! !

!SemaforoDeMaipuYCorrientes class methodsFor: 'inicializacion' stamp: 'AR 3/25/2019 21:23:49'!
avisarPrecaucionPorEncendido
	"
	Cuando un semáforo se prende lo primero que hace es titilar las luces amarillas 5 veces para avisar 
	 precaución por encendido (con esta versión se muestra en pantalla).
	"
	5 timesRepeat: [
		LuzAmarilla titilar.
		(Delay for: 0.5*second) wait.
	]! !


!SemaforoDeMaipuYCorrientes class methodsFor: 'creacion' stamp: 'AR 3/25/2019 20:34:42'!
apagar
	"
	Apaga todas las luces del semáforo.
	"
	LuzRoja apagar.
	LuzAmarilla apagar.
	LuzVerde apagar.! !

!SemaforoDeMaipuYCorrientes class methodsFor: 'creacion' stamp: 'AR 3/25/2019 21:23:49'!
encender
	"
	Inicializa el semáforo y lo muestra en pantalla.
	"
	self openInWorld.
	self agregarLuces.
	self avisarPrecaucionPorEncendido.
! !


!SemaforoDeMaipuYCorrientes class methodsFor: 'as yet unclassified' stamp: 'AR 3/25/2019 21:27:36'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.
	luzRoja := nil.
	luzVerde := nil.
	luzAmarilla := nil.! !

LuzAmarilla initializeAfterFileIn!
LuzRoja initializeAfterFileIn!
LuzVerde initializeAfterFileIn!
SemaforoDeMaipuYCorrientes initializeAfterFileIn!