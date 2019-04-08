!classDefinition: #Se�al category: #'Semaforo-ClassBased'!
DenotativeObjectMorph subclass: #Se�al
	instanceVariableNames: 'color'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo-ClassBased'!

!Se�al methodsFor: 'setters' stamp: 'TF 4/7/2019 18:30:09'!
color: unColor
	color := color.! !


!Se�al methodsFor: 'control' stamp: 'TF 4/7/2019 18:45:51'!
apagar
	self color: Color black.! !

!Se�al methodsFor: 'control' stamp: 'TF 4/7/2019 18:46:14'!
encender
	self color: color.! !

!Se�al methodsFor: 'control' stamp: 'TF 4/7/2019 18:46:30'!
titilar
	self apagar.
	(Delay for: 0.5*second) wait.
	self encender.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Se�al class' category: #'Semaforo-ClassBased'!
Se�al class
	instanceVariableNames: ''!

!Se�al class methodsFor: 'instanciacion' stamp: 'TF 4/7/2019 18:31:07'!
conColor: unColor
	|nuevaSe�al|
	nuevaSe�al := self new.
	nuevaSe�al color: unColor.
	^nuevaSe�al.! !

!Se�al class methodsFor: 'instanciacion' stamp: 'TF 4/7/2019 18:32:53'!
nuevaSe�alDeDetencion
	^self conColor: Color red.! !

!Se�al class methodsFor: 'instanciacion' stamp: 'TF 4/7/2019 18:32:43'!
nuevaSe�alDePaso
	^self conColor: Color green.! !

!Se�al class methodsFor: 'instanciacion' stamp: 'TF 4/7/2019 18:33:08'!
nuevaSe�alDePrecaucion
	^self conColor: Color yellow.! !


!Se�al class methodsFor: 'as yet unclassified' stamp: 'ar 4/7/2019 19:14:05'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !


!classDefinition: #Se�alizadorDeTransitoClassBased category: #'Semaforo-ClassBased'!
DenotativeObjectMorph subclass: #Se�alizadorDeTransitoClassBased
	instanceVariableNames: 'se�alDePaso se�alDePrecaucion se�alDeDetencion'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo-ClassBased'!

!Se�alizadorDeTransitoClassBased methodsFor: 'inicializacion' stamp: 'TF 4/7/2019 18:53:17'!
agregarLuces
	"
	Crea en el sem�foro las tres luces que tiene (Roja, Amarilla, Verde)
	En principio empiezan todas apagadas.
	"
	se�alDePrecaucion encender.
	se�alDePaso encender.
	se�alDeDetencion encender.
	
	self addMorph: se�alDeDetencion .
	self addMorph: se�alDePrecaucion .
	self addMorph: se�alDePaso .! !


!Se�alizadorDeTransitoClassBased methodsFor: 'setters' stamp: 'TF 4/7/2019 18:53:17'!
se�alDeDetencion: unaSe�al
	se�alDeDetencion := unaSe�al! !

!Se�alizadorDeTransitoClassBased methodsFor: 'setters' stamp: 'TF 4/7/2019 18:53:17'!
se�alDePaso: unaSe�al
	se�alDePaso := unaSe�al! !

!Se�alizadorDeTransitoClassBased methodsFor: 'setters' stamp: 'TF 4/7/2019 18:53:17'!
se�alDePrecaucion: unaSe�al
	se�alDePrecaucion := unaSe�al! !


!Se�alizadorDeTransitoClassBased methodsFor: 'morph' stamp: 'TF 4/7/2019 18:53:17'!
createMorph
	^LayoutMorph newColumn
		morphExtent: 60 @ 130;
		yourself
! !


!Se�alizadorDeTransitoClassBased methodsFor: 'control' stamp: 'TF 4/7/2019 18:53:17'!
apagar
	"
	Apaga todas las luces del sem�foro.
	"
	se�alDeDetencion apagar.
	se�alDePrecaucion apagar.
	se�alDePaso apagar.! !

!Se�alizadorDeTransitoClassBased methodsFor: 'control' stamp: 'TF 4/7/2019 18:53:17'!
avisarPrecaucionPorEncendido
	"
	Cuando un sem�foro se prende lo primero que hace es titilar las luces amarillas 5 veces para avisar 
	 precauci�n por encendido (con esta versi�n se muestra en pantalla).
	"
	5 timesRepeat: [
		se�alDePrecaucion titilar.
		(Delay for: 0.5*second) wait.
	]! !

!Se�alizadorDeTransitoClassBased methodsFor: 'control' stamp: 'TF 4/7/2019 18:53:17'!
detenerPaso
	"
	Detener el paso implica transicionar de la se�al de paso a la de
	detenci�n. Entre medio de esta transici�n se enciende la se�al
	de precauci�n para avisar a los conductores del cambio.
	"
	se�alDePrecaucion encender.
	(Delay forSeconds: 1) wait.
	se�alDePaso apagar.
	(Delay forSeconds: 1) wait.
	se�alDePrecaucion apagar.
	se�alDeDetencion encender.! !

!Se�alizadorDeTransitoClassBased methodsFor: 'control' stamp: 'TF 4/7/2019 18:53:17'!
encender
	"
	Inicializa el se�alizador y lo muestra en pantalla.
	"
	self openInWorld.
	self agregarLuces.
	self avisarPrecaucionPorEncendido.! !

!Se�alizadorDeTransitoClassBased methodsFor: 'control' stamp: 'TF 4/7/2019 18:53:17'!
permitirPaso
	"
	Permitir el paso implica transicionar de la se�al de detenci�n a 
	la de paso. Entre medio de esta transici�n se enciende la se�al
	de precauci�n para avisar a los conductores del cambio.
	"
	se�alDePrecaucion encender.
	(Delay forSeconds: 1) wait.
	se�alDeDetencion apagar.
	(Delay forSeconds: 1) wait.
	se�alDePrecaucion apagar.
	se�alDePaso encender.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Se�alizadorDeTransitoClassBased class' category: #'Semaforo-ClassBased'!
Se�alizadorDeTransitoClassBased class
	instanceVariableNames: ''!

!Se�alizadorDeTransitoClassBased class methodsFor: 'instanciacion' stamp: 'TF 4/7/2019 18:53:17'!
conSe�alDePaso: unaSe�alDePaso se�alDePrecaucion: unaSe�alDePrecaucion ySe�alDeDetenci�n: unaSe�alDeDetencion
	|nuevoSe�alizador|
	nuevoSe�alizador := self new.
	nuevoSe�alizador se�alDePaso: unaSe�alDePaso.
	nuevoSe�alizador se�alDePrecaucion: unaSe�alDePrecaucion.
	nuevoSe�alizador se�alDeDetencion: unaSe�alDeDetencion.
	^nuevoSe�alizador.! !


!Se�alizadorDeTransitoClassBased class methodsFor: 'as yet unclassified' stamp: 'ar 4/7/2019 19:14:05'!
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
	|se�alizador1 se�alizador2|
	
	se�alizador1 := 
		(Se�alizadorDeTransitoClassBased 
			conSe�alDePaso: Se�al nuevaSe�alDePaso 
			se�alDePrecaucion: Se�al nuevaSe�alDePrecaucion 
			ySe�alDeDetenci�n: Se�al nuevaSe�alDeDetencion
		).	
	se�alizador2 := 
		(Se�alizadorDeTransitoClassBased
			conSe�alDePaso: Se�al nuevaSe�alDePaso 
			se�alDePrecaucion: Se�al nuevaSe�alDePrecaucion 
			ySe�alDeDetenci�n: Se�al nuevaSe�alDeDetencion
		).

	^SemaforoClassBased nuevoSemaforoConSe�alizadores:  se�alizador1 y: se�alizador2. ! !


!classDefinition: #SemaforoClassBased category: #'Semaforo-ClassBased'!
Object subclass: #SemaforoClassBased
	instanceVariableNames: 'se�alizadorDeTransitoDeLaSegundaCalle se�alizadorDeTransitoDeLaPrimeraCalle'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo-ClassBased'!

!SemaforoClassBased methodsFor: 'setters' stamp: 'TF 4/7/2019 17:14:30'!
se�alizadorPrimeraCalle: unSe�alizador
	se�alizadorDeTransitoDeLaPrimeraCalle := unSe�alizador.! !

!SemaforoClassBased methodsFor: 'setters' stamp: 'TF 4/7/2019 17:14:42'!
se�alizadorSegundaCalle: unSe�alizador
	se�alizadorDeTransitoDeLaSegundaCalle := unSe�alizador.! !


!SemaforoClassBased methodsFor: 'creacion' stamp: 'TF 4/7/2019 18:51:09'!
iniciar
	se�alizadorDeTransitoDeLaPrimeraCalle apagar.
	se�alizadorDeTransitoDeLaSegundaCalle apagar.
	se�alizadorDeTransitoDeLaPrimeraCalle encender.
	se�alizadorDeTransitoDeLaSegundaCalle encender .
	self manejarTransito.! !


!SemaforoClassBased methodsFor: 'control' stamp: 'TF 4/7/2019 18:51:24'!
manejarTransito
	"
	Luego de que el sem�foro avisa precauci�n por encendido,
	empieza de manera alternada, a detener el tr�nsito de una
	calle y permitir que pase el tr�nsito de la otra.
	"
	5 timesRepeat: [
		se�alizadorDeTransitoDeLaSegundaCalle detenerPaso.
		se�alizadorDeTransitoDeLaPrimeraCalle permitirPaso.
		
		(Delay forSeconds: 2) wait.
		
		se�alizadorDeTransitoDeLaPrimeraCalle detenerPaso.
		se�alizadorDeTransitoDeLaSegundaCalle permitirPaso .
		
		(Delay forSeconds: 2) wait.
	].! !


!SemaforoClassBased methodsFor: 'getters' stamp: 'TF 4/7/2019 18:49:11'!
se�alizador1
	^se�alizadorDeTransitoDeLaPrimeraCalle .! !

!SemaforoClassBased methodsFor: 'getters' stamp: 'TF 4/7/2019 18:50:10'!
se�alizador2
	^se�alizadorDeTransitoDeLaSegundaCalle ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SemaforoClassBased class' category: #'Semaforo-ClassBased'!
SemaforoClassBased class
	instanceVariableNames: ''!

!SemaforoClassBased class methodsFor: 'instanciacion' stamp: 'TF 4/7/2019 17:58:02'!
nuevoSemaforoConSe�alizadores: unSe�alizador y: otroSe�alizador 
	| unNuevoSemaforo |
	unNuevoSemaforo := self new.
	unNuevoSemaforo se�alizadorPrimeraCalle: unSe�alizador.
	unNuevoSemaforo se�alizadorSegundaCalle: otroSe�alizador.
	^unNuevoSemaforo.
	! !

Se�al initializeAfterFileIn!
Se�alizadorDeTransitoClassBased initializeAfterFileIn!