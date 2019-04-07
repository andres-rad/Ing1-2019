!classDefinition: #Señal category: #'Semaforo-ClassBased'!
DenotativeObjectMorph subclass: #Señal
	instanceVariableNames: 'color'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo-ClassBased'!

!Señal methodsFor: 'setters' stamp: 'TF 4/7/2019 18:30:09'!
color: unColor
	color := color.! !


!Señal methodsFor: 'control' stamp: 'TF 4/7/2019 18:45:51'!
apagar
	self color: Color black.! !

!Señal methodsFor: 'control' stamp: 'TF 4/7/2019 18:46:14'!
encender
	self color: color.! !

!Señal methodsFor: 'control' stamp: 'TF 4/7/2019 18:46:30'!
titilar
	self apagar.
	(Delay for: 0.5*second) wait.
	self encender.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Señal class' category: #'Semaforo-ClassBased'!
Señal class
	instanceVariableNames: ''!

!Señal class methodsFor: 'instanciacion' stamp: 'TF 4/7/2019 18:31:07'!
conColor: unColor
	|nuevaSeñal|
	nuevaSeñal := self new.
	nuevaSeñal color: unColor.
	^nuevaSeñal.! !

!Señal class methodsFor: 'instanciacion' stamp: 'TF 4/7/2019 18:32:53'!
nuevaSeñalDeDetencion
	^self conColor: Color red.! !

!Señal class methodsFor: 'instanciacion' stamp: 'TF 4/7/2019 18:32:43'!
nuevaSeñalDePaso
	^self conColor: Color green.! !

!Señal class methodsFor: 'instanciacion' stamp: 'TF 4/7/2019 18:33:08'!
nuevaSeñalDePrecaucion
	^self conColor: Color yellow.! !


!Señal class methodsFor: 'as yet unclassified' stamp: 'ar 4/7/2019 19:14:05'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !


!classDefinition: #SeñalizadorDeTransitoClassBased category: #'Semaforo-ClassBased'!
DenotativeObjectMorph subclass: #SeñalizadorDeTransitoClassBased
	instanceVariableNames: 'señalDePaso señalDePrecaucion señalDeDetencion'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo-ClassBased'!

!SeñalizadorDeTransitoClassBased methodsFor: 'inicializacion' stamp: 'TF 4/7/2019 18:53:17'!
agregarLuces
	"
	Crea en el semáforo las tres luces que tiene (Roja, Amarilla, Verde)
	En principio empiezan todas apagadas.
	"
	señalDePrecaucion encender.
	señalDePaso encender.
	señalDeDetencion encender.
	
	self addMorph: señalDeDetencion .
	self addMorph: señalDePrecaucion .
	self addMorph: señalDePaso .! !


!SeñalizadorDeTransitoClassBased methodsFor: 'setters' stamp: 'TF 4/7/2019 18:53:17'!
señalDeDetencion: unaSeñal
	señalDeDetencion := unaSeñal! !

!SeñalizadorDeTransitoClassBased methodsFor: 'setters' stamp: 'TF 4/7/2019 18:53:17'!
señalDePaso: unaSeñal
	señalDePaso := unaSeñal! !

!SeñalizadorDeTransitoClassBased methodsFor: 'setters' stamp: 'TF 4/7/2019 18:53:17'!
señalDePrecaucion: unaSeñal
	señalDePrecaucion := unaSeñal! !


!SeñalizadorDeTransitoClassBased methodsFor: 'morph' stamp: 'TF 4/7/2019 18:53:17'!
createMorph
	^LayoutMorph newColumn
		morphExtent: 60 @ 130;
		yourself
! !


!SeñalizadorDeTransitoClassBased methodsFor: 'control' stamp: 'TF 4/7/2019 18:53:17'!
apagar
	"
	Apaga todas las luces del semáforo.
	"
	señalDeDetencion apagar.
	señalDePrecaucion apagar.
	señalDePaso apagar.! !

!SeñalizadorDeTransitoClassBased methodsFor: 'control' stamp: 'TF 4/7/2019 18:53:17'!
avisarPrecaucionPorEncendido
	"
	Cuando un semáforo se prende lo primero que hace es titilar las luces amarillas 5 veces para avisar 
	 precaución por encendido (con esta versión se muestra en pantalla).
	"
	5 timesRepeat: [
		señalDePrecaucion titilar.
		(Delay for: 0.5*second) wait.
	]! !

!SeñalizadorDeTransitoClassBased methodsFor: 'control' stamp: 'TF 4/7/2019 18:53:17'!
detenerPaso
	"
	Detener el paso implica transicionar de la señal de paso a la de
	detención. Entre medio de esta transición se enciende la señal
	de precaución para avisar a los conductores del cambio.
	"
	señalDePrecaucion encender.
	(Delay forSeconds: 1) wait.
	señalDePaso apagar.
	(Delay forSeconds: 1) wait.
	señalDePrecaucion apagar.
	señalDeDetencion encender.! !

!SeñalizadorDeTransitoClassBased methodsFor: 'control' stamp: 'TF 4/7/2019 18:53:17'!
encender
	"
	Inicializa el señalizador y lo muestra en pantalla.
	"
	self openInWorld.
	self agregarLuces.
	self avisarPrecaucionPorEncendido.! !

!SeñalizadorDeTransitoClassBased methodsFor: 'control' stamp: 'TF 4/7/2019 18:53:17'!
permitirPaso
	"
	Permitir el paso implica transicionar de la señal de detención a 
	la de paso. Entre medio de esta transición se enciende la señal
	de precaución para avisar a los conductores del cambio.
	"
	señalDePrecaucion encender.
	(Delay forSeconds: 1) wait.
	señalDeDetencion apagar.
	(Delay forSeconds: 1) wait.
	señalDePrecaucion apagar.
	señalDePaso encender.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SeñalizadorDeTransitoClassBased class' category: #'Semaforo-ClassBased'!
SeñalizadorDeTransitoClassBased class
	instanceVariableNames: ''!

!SeñalizadorDeTransitoClassBased class methodsFor: 'instanciacion' stamp: 'TF 4/7/2019 18:53:17'!
conSeñalDePaso: unaSeñalDePaso señalDePrecaucion: unaSeñalDePrecaucion ySeñalDeDetención: unaSeñalDeDetencion
	|nuevoSeñalizador|
	nuevoSeñalizador := self new.
	nuevoSeñalizador señalDePaso: unaSeñalDePaso.
	nuevoSeñalizador señalDePrecaucion: unaSeñalDePrecaucion.
	nuevoSeñalizador señalDeDetencion: unaSeñalDeDetencion.
	^nuevoSeñalizador.! !


!SeñalizadorDeTransitoClassBased class methodsFor: 'as yet unclassified' stamp: 'ar 4/7/2019 19:14:05'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !


!classDefinition: #CreadorDeSemaforosEstandar category: #'Semaforo-ClassBased'!
Object subclass: #CreadorDeSemaforosEstandar
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo-ClassBased'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreadorDeSemaforosEstandar class' category: #'Semaforo-ClassBased'!
CreadorDeSemaforosEstandar class
	instanceVariableNames: ''!

!CreadorDeSemaforosEstandar class methodsFor: 'as yet unclassified' stamp: 'ar 4/7/2019 19:08:00'!
crearSemaforo
	|señalizador1 señalizador2|
	
	señalizador1 := 
		(SeñalizadorDeTransitoClassBased 
			conSeñalDePaso: Señal nuevaSeñalDePaso 
			señalDePrecaucion: Señal nuevaSeñalDePrecaucion 
			ySeñalDeDetención: Señal nuevaSeñalDeDetencion
		).	
	señalizador2 := 
		(SeñalizadorDeTransitoClassBased
			conSeñalDePaso: Señal nuevaSeñalDePaso 
			señalDePrecaucion: Señal nuevaSeñalDePrecaucion 
			ySeñalDeDetención: Señal nuevaSeñalDeDetencion
		).

	^SemaforoClassBased nuevoSemaforoConSeñalizadores:  señalizador1 y: señalizador2. ! !


!classDefinition: #SemaforoClassBased category: #'Semaforo-ClassBased'!
Object subclass: #SemaforoClassBased
	instanceVariableNames: 'señalizadorDeTransitoDeLaSegundaCalle señalizadorDeTransitoDeLaPrimeraCalle'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo-ClassBased'!

!SemaforoClassBased methodsFor: 'setters' stamp: 'TF 4/7/2019 17:14:30'!
señalizadorPrimeraCalle: unSeñalizador
	señalizadorDeTransitoDeLaPrimeraCalle := unSeñalizador.! !

!SemaforoClassBased methodsFor: 'setters' stamp: 'TF 4/7/2019 17:14:42'!
señalizadorSegundaCalle: unSeñalizador
	señalizadorDeTransitoDeLaSegundaCalle := unSeñalizador.! !


!SemaforoClassBased methodsFor: 'creacion' stamp: 'TF 4/7/2019 18:51:09'!
iniciar
	señalizadorDeTransitoDeLaPrimeraCalle apagar.
	señalizadorDeTransitoDeLaSegundaCalle apagar.
	señalizadorDeTransitoDeLaPrimeraCalle encender.
	señalizadorDeTransitoDeLaSegundaCalle encender .
	self manejarTransito.! !


!SemaforoClassBased methodsFor: 'control' stamp: 'TF 4/7/2019 18:51:24'!
manejarTransito
	"
	Luego de que el semáforo avisa precaución por encendido,
	empieza de manera alternada, a detener el tránsito de una
	calle y permitir que pase el tránsito de la otra.
	"
	5 timesRepeat: [
		señalizadorDeTransitoDeLaSegundaCalle detenerPaso.
		señalizadorDeTransitoDeLaPrimeraCalle permitirPaso.
		
		(Delay forSeconds: 2) wait.
		
		señalizadorDeTransitoDeLaPrimeraCalle detenerPaso.
		señalizadorDeTransitoDeLaSegundaCalle permitirPaso .
		
		(Delay forSeconds: 2) wait.
	].! !


!SemaforoClassBased methodsFor: 'getters' stamp: 'TF 4/7/2019 18:49:11'!
señalizador1
	^señalizadorDeTransitoDeLaPrimeraCalle .! !

!SemaforoClassBased methodsFor: 'getters' stamp: 'TF 4/7/2019 18:50:10'!
señalizador2
	^señalizadorDeTransitoDeLaSegundaCalle ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SemaforoClassBased class' category: #'Semaforo-ClassBased'!
SemaforoClassBased class
	instanceVariableNames: ''!

!SemaforoClassBased class methodsFor: 'instanciacion' stamp: 'TF 4/7/2019 17:58:02'!
nuevoSemaforoConSeñalizadores: unSeñalizador y: otroSeñalizador 
	| unNuevoSemaforo |
	unNuevoSemaforo := self new.
	unNuevoSemaforo señalizadorPrimeraCalle: unSeñalizador.
	unNuevoSemaforo señalizadorSegundaCalle: otroSeñalizador.
	^unNuevoSemaforo.
	! !

Señal initializeAfterFileIn!
SeñalizadorDeTransitoClassBased initializeAfterFileIn!