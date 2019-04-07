!classDefinition: #SeñalDeDetencion category: #Semaforo!
DenotativeObjectMorph subclass: #SeñalDeDetencion
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SeñalDeDetencion class' category: #Semaforo!
SeñalDeDetencion class
	instanceVariableNames: ''!

!SeñalDeDetencion class methodsFor: 'morph' stamp: 'TF 4/7/2019 16:12:15'!
apagar
	self color: Color black.! !

!SeñalDeDetencion class methodsFor: 'morph' stamp: 'TF 4/7/2019 16:10:36'!
createMorph
	^EllipseMorph new
		color: Color black;
		yourself! !

!SeñalDeDetencion class methodsFor: 'morph' stamp: 'TF 4/7/2019 16:09:58'!
encender
	self color: Color red.! !


!SeñalDeDetencion class methodsFor: 'as yet unclassified' stamp: 'TF 4/7/2019 16:21:44'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !


!classDefinition: #SeñalDeDetencionDeCorrientes category: #Semaforo!
SeñalDeDetencion subclass: #SeñalDeDetencionDeCorrientes
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SeñalDeDetencionDeCorrientes class' category: #Semaforo!
SeñalDeDetencionDeCorrientes class
	instanceVariableNames: ''!


!SeñalDeDetencionDeCorrientes class methodsFor: 'as yet unclassified' stamp: 'TF 4/7/2019 16:21:44'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !


!classDefinition: #SeñalDeDetencionDeMaipu category: #Semaforo!
SeñalDeDetencion subclass: #SeñalDeDetencionDeMaipu
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SeñalDeDetencionDeMaipu class' category: #Semaforo!
SeñalDeDetencionDeMaipu class
	instanceVariableNames: ''!


!SeñalDeDetencionDeMaipu class methodsFor: 'as yet unclassified' stamp: 'TF 4/7/2019 16:21:44'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !


!classDefinition: #SeñalDePaso category: #Semaforo!
DenotativeObjectMorph subclass: #SeñalDePaso
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SeñalDePaso class' category: #Semaforo!
SeñalDePaso class
	instanceVariableNames: ''!

!SeñalDePaso class methodsFor: 'morph' stamp: 'TF 4/7/2019 16:16:55'!
apagar
	self color: Color black.! !

!SeñalDePaso class methodsFor: 'morph' stamp: 'TF 4/7/2019 16:16:55'!
createMorph

	^EllipseMorph new
		color: Color black;
		yourself! !

!SeñalDePaso class methodsFor: 'morph' stamp: 'TF 4/7/2019 16:16:55'!
encender
	self color: Color green.! !


!SeñalDePaso class methodsFor: 'as yet unclassified' stamp: 'TF 4/7/2019 16:21:44'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !


!classDefinition: #SeñalDePasoDeCorrientes category: #Semaforo!
SeñalDePaso subclass: #SeñalDePasoDeCorrientes
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SeñalDePasoDeCorrientes class' category: #Semaforo!
SeñalDePasoDeCorrientes class
	instanceVariableNames: ''!


!SeñalDePasoDeCorrientes class methodsFor: 'as yet unclassified' stamp: 'TF 4/7/2019 16:21:44'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !


!classDefinition: #SeñalDePasoDeMaipu category: #Semaforo!
SeñalDePaso subclass: #SeñalDePasoDeMaipu
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SeñalDePasoDeMaipu class' category: #Semaforo!
SeñalDePasoDeMaipu class
	instanceVariableNames: ''!

!SeñalDePasoDeMaipu class methodsFor: 'morph' stamp: 'AR 3/25/2019 20:28:32'!
apagar
	self color: Color black.! !

!SeñalDePasoDeMaipu class methodsFor: 'morph' stamp: 'AR 3/25/2019 20:07:35'!
createMorph

	^EllipseMorph new
		color: Color black;
		yourself! !

!SeñalDePasoDeMaipu class methodsFor: 'morph' stamp: 'AR 3/25/2019 20:48:12'!
encender
	self color: Color green.! !


!SeñalDePasoDeMaipu class methodsFor: 'as yet unclassified' stamp: 'TF 4/7/2019 16:21:44'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !


!classDefinition: #SeñalDePrecaución category: #Semaforo!
DenotativeObjectMorph subclass: #SeñalDePrecaución
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SeñalDePrecaución class' category: #Semaforo!
SeñalDePrecaución class
	instanceVariableNames: ''!

!SeñalDePrecaución class methodsFor: 'morph' stamp: 'TF 4/7/2019 16:17:29'!
apagar
	self color: Color black.! !

!SeñalDePrecaución class methodsFor: 'morph' stamp: 'TF 4/7/2019 16:17:29'!
createMorph

	^EllipseMorph new
		color: Color black;
		yourself! !

!SeñalDePrecaución class methodsFor: 'morph' stamp: 'TF 4/7/2019 16:17:29'!
encender
	self color: Color yellow.! !

!SeñalDePrecaución class methodsFor: 'morph' stamp: 'TF 4/7/2019 16:17:29'!
titilar
	self apagar.
	(Delay for: 0.5*second) wait.
	self encender.! !


!SeñalDePrecaución class methodsFor: 'as yet unclassified' stamp: 'TF 4/7/2019 16:21:44'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !


!classDefinition: #SeñalDePrecaucionDeCorrientes category: #Semaforo!
SeñalDePrecaución subclass: #SeñalDePrecaucionDeCorrientes
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SeñalDePrecaucionDeCorrientes class' category: #Semaforo!
SeñalDePrecaucionDeCorrientes class
	instanceVariableNames: ''!


!SeñalDePrecaucionDeCorrientes class methodsFor: 'as yet unclassified' stamp: 'TF 4/7/2019 16:21:44'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !


!classDefinition: #SeñalDePrecaucionDeMaipu category: #Semaforo!
SeñalDePrecaución subclass: #SeñalDePrecaucionDeMaipu
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SeñalDePrecaucionDeMaipu class' category: #Semaforo!
SeñalDePrecaucionDeMaipu class
	instanceVariableNames: ''!


!SeñalDePrecaucionDeMaipu class methodsFor: 'as yet unclassified' stamp: 'TF 4/7/2019 16:21:44'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !


!classDefinition: #SeñalizadorDeTransitoDeCorrientes category: #Semaforo!
DenotativeObjectMorph subclass: #SeñalizadorDeTransitoDeCorrientes
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SeñalizadorDeTransitoDeCorrientes class' category: #Semaforo!
SeñalizadorDeTransitoDeCorrientes class
	instanceVariableNames: ''!

!SeñalizadorDeTransitoDeCorrientes class methodsFor: 'morph' stamp: 'TF 4/7/2019 15:17:42'!
createMorph

	^LayoutMorph newColumn
		morphExtent: 60 @ 130;
		yourself
! !


!SeñalizadorDeTransitoDeCorrientes class methodsFor: 'control' stamp: 'TF 4/7/2019 15:37:10'!
avisarPrecaucionPorEncendido
	"
	Cuando un semáforo se prende lo primero que hace es titilar las luces amarillas 5 veces para avisar 
	 precaución por encendido (con esta versión se muestra en pantalla).
	"
	5 timesRepeat: [
		SeñalDePrecaucionDeCorrientes titilar.
		(Delay for: 0.5*second) wait.
	]! !

!SeñalizadorDeTransitoDeCorrientes class methodsFor: 'control' stamp: 'TF 4/7/2019 15:46:41'!
detenerPaso
	"
	Detener el paso implica transicionar de la señal de paso a la de
	detención. Entre medio de esta transición se enciende la señal
	de precaución para avisar a los conductores del cambio.
	"
	SeñalDePrecaucionDeCorrientes encender.
	(Delay forSeconds: 1) wait.
	SeñalDePasoDeCorrientes apagar.
	(Delay forSeconds: 1) wait.
	SeñalDePrecaucionDeCorrientes apagar.
	SeñalDeDetencionDeCorrientes encender.! !

!SeñalizadorDeTransitoDeCorrientes class methodsFor: 'control' stamp: 'TF 4/7/2019 15:47:13'!
permitirPaso
	"
	Permitir el paso implica transicionar de la señal de detención a 
	la de paso. Entre medio de esta transición se enciende la señal
	de precaución para avisar a los conductores del cambio.
	"
	SeñalDePrecaucionDeCorrientes encender.
	(Delay forSeconds: 1) wait.
	SeñalDeDetencionDeCorrientes apagar.
	(Delay forSeconds: 1) wait.
	SeñalDePrecaucionDeCorrientes apagar.
	SeñalDePasoDeCorrientes encender.! !


!SeñalizadorDeTransitoDeCorrientes class methodsFor: 'creacion' stamp: 'TF 4/7/2019 15:44:41'!
agregarLuces
	"
	Crea en el semáforo las tres luces que tiene (Roja, Amarilla, Verde)
	En principio empiezan todas apagadas.
	"
	SeñalDePrecaucionDeCorrientes encender.
	SeñalDePasoDeCorrientes encender.
	SeñalDeDetencionDeCorrientes encender.
	
	self addMorph: SeñalDeDetencionDeCorrientes .
	self addMorph: SeñalDePrecaucionDeCorrientes .
	self addMorph: SeñalDePasoDeCorrientes .! !

!SeñalizadorDeTransitoDeCorrientes class methodsFor: 'creacion' stamp: 'TF 4/7/2019 15:38:09'!
apagar
	"
	Apaga todas las luces del semáforo.
	"
	SeñalDeDetencionDeCorrientes apagar.
	SeñalDePrecaucionDeCorrientes apagar.
	SeñalDePasoDeCorrientes apagar.! !

!SeñalizadorDeTransitoDeCorrientes class methodsFor: 'creacion' stamp: 'TF 4/7/2019 15:48:23'!
encender
	"
	Inicializa el señalizador y lo muestra en pantalla.
	"
	self openInWorld.
	self agregarLuces.
	self avisarPrecaucionPorEncendido.
! !


!SeñalizadorDeTransitoDeCorrientes class methodsFor: 'as yet unclassified' stamp: 'TF 4/7/2019 16:21:44'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !


!classDefinition: #SeñalizadorDeTransitoDeMaipu category: #Semaforo!
DenotativeObjectMorph subclass: #SeñalizadorDeTransitoDeMaipu
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SeñalizadorDeTransitoDeMaipu class' category: #Semaforo!
SeñalizadorDeTransitoDeMaipu class
	instanceVariableNames: ''!

!SeñalizadorDeTransitoDeMaipu class methodsFor: 'morph' stamp: 'AR 3/25/2019 20:05:34'!
createMorph

	^LayoutMorph newColumn
		morphExtent: 60 @ 130;
		yourself
! !


!SeñalizadorDeTransitoDeMaipu class methodsFor: 'control' stamp: 'TF 4/7/2019 15:37:23'!
avisarPrecaucionPorEncendido
	"
	Cuando un semáforo se prende lo primero que hace es titilar las luces amarillas 5 veces para avisar 
	 precaución por encendido (con esta versión se muestra en pantalla).
	"
	5 timesRepeat: [
		SeñalDePrecaucionDeMaipu titilar.
		(Delay for: 0.5*second) wait.
	]! !

!SeñalizadorDeTransitoDeMaipu class methodsFor: 'control' stamp: 'TF 4/7/2019 15:47:22'!
detenerPaso
	"
	Detener el paso implica transicionar de la señal de paso a la de
	detención. Entre medio de esta transición se enciende la señal
	de precaución para avisar a los conductores del cambio.
	"
	SeñalDePrecaucionDeMaipu encender.
	(Delay forSeconds: 1) wait.
	SeñalDePasoDeMaipu apagar.
	(Delay forSeconds: 1) wait.
	SeñalDePrecaucionDeMaipu apagar.
	SeñalDeDetencionDeMaipu encender.! !

!SeñalizadorDeTransitoDeMaipu class methodsFor: 'control' stamp: 'TF 4/7/2019 15:47:38'!
permitirPaso
	"
	Permitir el paso implica transicionar de la señal de detención a 
	la de paso. Entre medio de esta transición se enciende la señal
	de precaución para avisar a los conductores del cambio.
	"
	SeñalDePrecaucionDeMaipu encender.
	(Delay forSeconds: 1) wait.
	SeñalDeDetencionDeMaipu apagar.
	(Delay forSeconds: 1) wait.
	SeñalDePrecaucionDeMaipu apagar.
	SeñalDePasoDeMaipu encender.! !


!SeñalizadorDeTransitoDeMaipu class methodsFor: 'creacion' stamp: 'TF 4/7/2019 15:38:18'!
agregarLuces
	"
	Crea en el semáforo las tres luces que tiene un semáforo (Roja, Amarilla, Verde)
	En principio empiezan todas apagadas.
	"
	SeñalDePrecaucionDeMaipu encender.
	SeñalDePasoDeMaipu encender.
	SeñalDeDetencionDeMaipu encender.
	
	self addMorph: SeñalDeDetencionDeMaipu.
	self addMorph: SeñalDePrecaucionDeMaipu.
	self addMorph: SeñalDePasoDeMaipu.! !

!SeñalizadorDeTransitoDeMaipu class methodsFor: 'creacion' stamp: 'TF 4/7/2019 15:38:18'!
apagar
	"
	Apaga todas las luces del semáforo.
	"
	SeñalDeDetencionDeMaipu apagar.
	SeñalDePrecaucionDeMaipu apagar.
	SeñalDePasoDeMaipu apagar.! !

!SeñalizadorDeTransitoDeMaipu class methodsFor: 'creacion' stamp: 'TF 4/7/2019 15:48:05'!
encender
	"
	Inicializa el señalizador y lo muestra en pantalla.
	"
	self openInWorld.
	self agregarLuces.
	self avisarPrecaucionPorEncendido.
! !


!SeñalizadorDeTransitoDeMaipu class methodsFor: 'as yet unclassified' stamp: 'TF 4/7/2019 16:21:44'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !


!classDefinition: #SemaforoDeMaipuYCorrientes category: #Semaforo!
DenotativeObject subclass: #SemaforoDeMaipuYCorrientes
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SemaforoDeMaipuYCorrientes class' category: #Semaforo!
SemaforoDeMaipuYCorrientes class
	instanceVariableNames: ''!

!SemaforoDeMaipuYCorrientes class methodsFor: 'creacion' stamp: 'TF 4/7/2019 15:36:23'!
iniciar
	SeñalizadorDeTransitoDeCorrientes apagar.
	SeñalizadorDeTransitoDeMaipu apagar.
	SeñalizadorDeTransitoDeCorrientes encender.
	SeñalizadorDeTransitoDeMaipu encender .
	self manejarTransito.! !


!SemaforoDeMaipuYCorrientes class methodsFor: 'control' stamp: 'TF 4/7/2019 15:50:03'!
manejarTransito
	"
	Luego de que el semáforo avisa precaución por encendido,
	empieza de manera alternada, a detener el tránsito de una
	calle y permitir que pase el tránsito de la otra.
	"
	5 timesRepeat: [
		SeñalizadorDeTransitoDeMaipu detenerPaso.
		SeñalizadorDeTransitoDeCorrientes permitirPaso.
		
		(Delay forSeconds: 2) wait.
		
		SeñalizadorDeTransitoDeCorrientes detenerPaso.
		SeñalizadorDeTransitoDeMaipu permitirPaso .
		
		(Delay forSeconds: 2) wait.
	].! !

SeñalDeDetencion initializeAfterFileIn!
SeñalDeDetencionDeCorrientes initializeAfterFileIn!
SeñalDeDetencionDeMaipu initializeAfterFileIn!
SeñalDePaso initializeAfterFileIn!
SeñalDePasoDeCorrientes initializeAfterFileIn!
SeñalDePasoDeMaipu initializeAfterFileIn!
SeñalDePrecaución initializeAfterFileIn!
SeñalDePrecaucionDeCorrientes initializeAfterFileIn!
SeñalDePrecaucionDeMaipu initializeAfterFileIn!
SeñalizadorDeTransitoDeCorrientes initializeAfterFileIn!
SeñalizadorDeTransitoDeMaipu initializeAfterFileIn!