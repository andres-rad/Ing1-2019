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


!SeñalDeDetencion class methodsFor: 'as yet unclassified' stamp: 'TF 4/7/2019 16:55:55'!
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


!SeñalDeDetencionDeCorrientes class methodsFor: 'as yet unclassified' stamp: 'TF 4/7/2019 16:55:55'!
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


!SeñalDeDetencionDeMaipu class methodsFor: 'as yet unclassified' stamp: 'TF 4/7/2019 16:55:55'!
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


!SeñalDePaso class methodsFor: 'as yet unclassified' stamp: 'TF 4/7/2019 16:55:55'!
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


!SeñalDePasoDeCorrientes class methodsFor: 'as yet unclassified' stamp: 'TF 4/7/2019 16:55:55'!
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


!SeñalDePasoDeMaipu class methodsFor: 'as yet unclassified' stamp: 'TF 4/7/2019 16:55:55'!
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


!SeñalDePrecaución class methodsFor: 'as yet unclassified' stamp: 'TF 4/7/2019 16:55:55'!
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


!SeñalDePrecaucionDeCorrientes class methodsFor: 'as yet unclassified' stamp: 'TF 4/7/2019 16:55:55'!
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


!SeñalDePrecaucionDeMaipu class methodsFor: 'as yet unclassified' stamp: 'TF 4/7/2019 16:55:55'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !


!classDefinition: #SeñalizadorDeTransito category: #Semaforo!
DenotativeObjectMorph subclass: #SeñalizadorDeTransito
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SeñalizadorDeTransito class' category: #Semaforo!
SeñalizadorDeTransito class
	instanceVariableNames: 'SeñalDePrecaucion SeñalDePaso SeñalDeDetencion'!

!SeñalizadorDeTransito class methodsFor: 'morph' stamp: 'TF 4/7/2019 16:49:02'!
createMorph

	^LayoutMorph newColumn
		morphExtent: 60 @ 130;
		yourself
! !


!SeñalizadorDeTransito class methodsFor: 'control' stamp: 'TF 4/7/2019 16:50:30'!
avisarPrecaucionPorEncendido
	"
	Cuando un semáforo se prende lo primero que hace es titilar las luces amarillas 5 veces para avisar 
	 precaución por encendido (con esta versión se muestra en pantalla).
	"
	5 timesRepeat: [
		SeñalDePrecaucion titilar.
		(Delay for: 0.5*second) wait.
	]! !

!SeñalizadorDeTransito class methodsFor: 'control' stamp: 'TF 4/7/2019 16:50:52'!
detenerPaso
	"
	Detener el paso implica transicionar de la señal de paso a la de
	detención. Entre medio de esta transición se enciende la señal
	de precaución para avisar a los conductores del cambio.
	"
	SeñalDePrecaucion encender.
	(Delay forSeconds: 1) wait.
	SeñalDePaso apagar.
	(Delay forSeconds: 1) wait.
	SeñalDePrecaucion apagar.
	SeñalDeDetencion encender.! !

!SeñalizadorDeTransito class methodsFor: 'control' stamp: 'TF 4/7/2019 16:51:12'!
permitirPaso
	"
	Permitir el paso implica transicionar de la señal de detención a 
	la de paso. Entre medio de esta transición se enciende la señal
	de precaución para avisar a los conductores del cambio.
	"
	SeñalDePrecaucion encender.
	(Delay forSeconds: 1) wait.
	SeñalDeDetencion apagar.
	(Delay forSeconds: 1) wait.
	SeñalDePrecaucion apagar.
	SeñalDePaso encender.! !


!SeñalizadorDeTransito class methodsFor: 'creacion' stamp: 'TF 4/7/2019 16:50:04'!
agregarLuces
	"
	Crea en el semáforo las tres luces que tiene (Roja, Amarilla, Verde)
	En principio empiezan todas apagadas.
	"
	SeñalDePrecaucion encender.
	SeñalDePaso encender.
	SeñalDeDetencion encender.
	
	self addMorph: SeñalDeDetencion .
	self addMorph: SeñalDePrecaucion .
	self addMorph: SeñalDePaso .! !

!SeñalizadorDeTransito class methodsFor: 'creacion' stamp: 'TF 4/7/2019 16:50:21'!
apagar
	"
	Apaga todas las luces del semáforo.
	"
	SeñalDeDetencion apagar.
	SeñalDePrecaucion apagar.
	SeñalDePaso apagar.! !

!SeñalizadorDeTransito class methodsFor: 'creacion' stamp: 'TF 4/7/2019 16:49:02'!
encender
	"
	Inicializa el señalizador y lo muestra en pantalla.
	"
	self openInWorld.
	self agregarLuces.
	self avisarPrecaucionPorEncendido.
! !


!SeñalizadorDeTransito class methodsFor: 'as yet unclassified' stamp: 'TF 4/7/2019 16:55:55'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.
	SeñalDePrecaucion := nil.
	SeñalDePaso := nil.
	SeñalDeDetencion := nil.! !


!classDefinition: #SeñalizadorDeTransitoDeCorrientes category: #Semaforo!
SeñalizadorDeTransito subclass: #SeñalizadorDeTransitoDeCorrientes
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SeñalizadorDeTransitoDeCorrientes class' category: #Semaforo!
SeñalizadorDeTransitoDeCorrientes class
	instanceVariableNames: ''!




!SeñalizadorDeTransitoDeCorrientes class methodsFor: 'as yet unclassified' stamp: 'TF 4/7/2019 16:55:55'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.
	SeñalDePrecaucion := SeñalDePrecaucionDeCorrientes.
	SeñalDePaso := SeñalDePasoDeCorrientes.
	SeñalDeDetencion := SeñalDeDetencionDeCorrientes.! !


!classDefinition: #SeñalizadorDeTransitoDeMaipu category: #Semaforo!
SeñalizadorDeTransito subclass: #SeñalizadorDeTransitoDeMaipu
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SeñalizadorDeTransitoDeMaipu class' category: #Semaforo!
SeñalizadorDeTransitoDeMaipu class
	instanceVariableNames: ''!




!SeñalizadorDeTransitoDeMaipu class methodsFor: 'as yet unclassified' stamp: 'TF 4/7/2019 16:55:55'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.
	SeñalDePrecaucion := SeñalDePrecaucionDeMaipu.
	SeñalDePaso := SeñalDePasoDeMaipu.
	SeñalDeDetencion := SeñalDeDetencionDeMaipu.! !


!classDefinition: #Semaforo category: #Semaforo!
DenotativeObject subclass: #Semaforo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Semaforo class' category: #Semaforo!
Semaforo class
	instanceVariableNames: 'SeñalizadorDeTransitoDeLaSegundaCalle SeñalizadorDeTransitoDeLaPrimeraCalle'!

!Semaforo class methodsFor: 'creacion' stamp: 'TF 4/7/2019 16:34:36'!
iniciar
	SeñalizadorDeTransitoDeLaPrimeraCalle apagar.
	SeñalizadorDeTransitoDeLaSegundaCalle apagar.
	SeñalizadorDeTransitoDeLaPrimeraCalle encender.
	SeñalizadorDeTransitoDeLaSegundaCalle encender .
	self manejarTransito.! !


!Semaforo class methodsFor: 'control' stamp: 'TF 4/7/2019 16:34:36'!
manejarTransito
	"
	Luego de que el semáforo avisa precaución por encendido,
	empieza de manera alternada, a detener el tránsito de una
	calle y permitir que pase el tránsito de la otra.
	"
	5 timesRepeat: [
		SeñalizadorDeTransitoDeLaSegundaCalle detenerPaso.
		SeñalizadorDeTransitoDeLaPrimeraCalle permitirPaso.
		
		(Delay forSeconds: 2) wait.
		
		SeñalizadorDeTransitoDeLaPrimeraCalle detenerPaso.
		SeñalizadorDeTransitoDeLaSegundaCalle permitirPaso .
		
		(Delay forSeconds: 2) wait.
	].! !


!Semaforo class methodsFor: 'as yet unclassified' stamp: 'TF 4/7/2019 16:55:55'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	SeñalizadorDeTransitoDeLaSegundaCalle := nil.
	SeñalizadorDeTransitoDeLaPrimeraCalle := nil.! !


!classDefinition: #SemaforoDeMaipuYCorrientes category: #Semaforo!
Semaforo subclass: #SemaforoDeMaipuYCorrientes
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SemaforoDeMaipuYCorrientes class' category: #Semaforo!
SemaforoDeMaipuYCorrientes class
	instanceVariableNames: ''!

!SemaforoDeMaipuYCorrientes class methodsFor: 'as yet unclassified' stamp: 'TF 4/7/2019 16:44:57'!
iniciarHijo
	self iniciar.! !

!SemaforoDeMaipuYCorrientes class methodsFor: 'as yet unclassified' stamp: 'TF 4/7/2019 16:55:55'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	SeñalizadorDeTransitoDeLaSegundaCalle := SeñalizadorDeTransitoDeMaipu.
	SeñalizadorDeTransitoDeLaPrimeraCalle := SeñalizadorDeTransitoDeCorrientes.! !

SeñalDeDetencion initializeAfterFileIn!
SeñalDeDetencionDeCorrientes initializeAfterFileIn!
SeñalDeDetencionDeMaipu initializeAfterFileIn!
SeñalDePaso initializeAfterFileIn!
SeñalDePasoDeCorrientes initializeAfterFileIn!
SeñalDePasoDeMaipu initializeAfterFileIn!
SeñalDePrecaución initializeAfterFileIn!
SeñalDePrecaucionDeCorrientes initializeAfterFileIn!
SeñalDePrecaucionDeMaipu initializeAfterFileIn!
SeñalizadorDeTransito initializeAfterFileIn!
SeñalizadorDeTransitoDeCorrientes initializeAfterFileIn!
SeñalizadorDeTransitoDeMaipu initializeAfterFileIn!
Semaforo initializeAfterFileIn!
SemaforoDeMaipuYCorrientes initializeAfterFileIn!