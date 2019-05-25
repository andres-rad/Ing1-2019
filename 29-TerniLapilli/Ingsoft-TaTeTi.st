!classDefinition: #TaTeTiTest category: #'Ingsoft-TaTeTi'!
TestCase subclass: #TaTeTiTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ingsoft-TaTeTi'!

!TaTeTiTest methodsFor: 'as yet unclassified' stamp: 'TF 5/20/2019 18:36:37'!
test01CuandoComienzaElJuegoNoSeTermino
	
	| tateti |
	
	tateti := TaTeTi new.
	
	self assert: tateti isOver not.
		! !

!TaTeTiTest methodsFor: 'as yet unclassified' stamp: 'TF 5/20/2019 18:36:57'!
test02EmpiezaElJugadorX
	
	| tateti |
	
	tateti := TaTeTi new.
	
	tateti play: #X at: 0@0.
	
	self assert: (tateti at: 0@0) equals: #X. ! !

!TaTeTiTest methodsFor: 'as yet unclassified' stamp: 'TF 5/20/2019 18:37:55'!
test03NoEmpiezaElJugadorO
	
	| tateti |
	
	tateti := TaTeTi new.
	
	self should: [tateti play: #O at: 0@0] raise: Error  withMessageText: 'No es tu turno.'.
	
	! !

!TaTeTiTest methodsFor: 'as yet unclassified' stamp: 'TF 5/20/2019 18:39:21'!
test04NoPuedoHacerUnMovimientoFueraDelTablero
	
	| tateti |
	
	tateti := TaTeTi new.
	
	
	self should: [tateti play: #X at: 3@-1] raise: Error  withMessageText: TaTeTi outOfBoardErrorDescription.
	
	! !

!TaTeTiTest methodsFor: 'as yet unclassified' stamp: 'TF 5/20/2019 18:40:00'!
test05NoPuedeJugarDosVecesSeguidasElMismoJugador
	
	| tateti |
	
	tateti := TaTeTi new.
	
	tateti play: #X at: 0@0.
	self should: [tateti play: #X at: 1@1] raise: Error  withMessageText: TaTeTi notYourTurnErrorDescription.
	
	! !

!TaTeTiTest methodsFor: 'as yet unclassified' stamp: 'TF 5/20/2019 18:42:35'!
test06SoloPuedoJugarConOsYXs
	
	| tateti |
	
	tateti := TaTeTi new.
	
	self should: [tateti play: #Z at: 1@1] raise: Error  withMessageText: TaTeTi notValidTokenErrorDescription.
	
	! !

!TaTeTiTest methodsFor: 'as yet unclassified' stamp: 'TF 5/20/2019 18:43:54'!
test07NoPuedoPonerDosPiezasEnLaMismaPosicion
	
	| tateti |
	
	tateti := TaTeTi new.
	
	tateti play: #X at: 0@0.
	self should: [tateti play: #O at: 0@0] raise: Error  withMessageText: TaTeTi cantPlayOnOccupiedSpaceErrorDescription.
	
	! !

!TaTeTiTest methodsFor: 'as yet unclassified' stamp: 'TF 5/20/2019 18:55:57'!
test08PuedeJugarODespuesDeX
	
	| tateti |
	
	tateti := TaTeTi new.
	
	tateti play: #X at: 0@0.
	tateti play: #O at: 2@1.
	
	self assert: (tateti at: 0@0) equals: #X.
	self assert: (tateti at: 2@1) equals: #O.
	
	! !

!TaTeTiTest methodsFor: 'as yet unclassified' stamp: 'TF 5/20/2019 19:27:14'!
test09NoPodesPonerMasDeTresFichas
	
	| tateti |
	
	tateti := TaTeTi new.
	
	tateti play: #X at: 0@0.
	tateti play: #O at: 0@1.
	tateti play: #X at: 0@2.
	tateti play: #O at: 1@0.
	tateti play: #X at: 1@1.
	tateti play: #O at: 1@2.
	
	self should: [tateti play: #X  at: 2@0] raise: Error  withMessageText: TaTeTi cantPlayMoreThanThreePieces.
	
	self assert: (tateti at: 0@0) equals: #X.
	self assert: (tateti at: 0@2) equals: #X.
	self assert: (tateti at: 1@1) equals: #X.
	self assert: (tateti at: 0@1) equals: #O.
	self assert: (tateti at: 1@0) equals: #O.
	self assert: (tateti at: 1@2) equals: #O.
	
	! !


!classDefinition: #TaTeTi category: #'Ingsoft-TaTeTi'!
Object subclass: #TaTeTi
	instanceVariableNames: 'lastPlay occupiedPositions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ingsoft-TaTeTi'!

!TaTeTi methodsFor: 'as yet unclassified' stamp: 'TF 5/20/2019 18:34:33'!
assertIsPlayerTurn: aSymbol
	lastPlay = aSymbol ifTrue: [self error: self class notYourTurnErrorDescription.].! !

!TaTeTi methodsFor: 'as yet unclassified' stamp: 'TF 5/20/2019 18:53:14'!
assertPointIsEmpty: aPoint

	occupiedPositions at: aPoint ifPresent: [:symbol | self error: self class cantPlayOnOccupiedSpaceErrorDescription ].! !

!TaTeTi methodsFor: 'as yet unclassified' stamp: 'TF 5/20/2019 18:30:54'!
assertPointIsValid: aPoint

	(((aPoint x < 0 or: [aPoint x > 2]) or: [aPoint y < 0]) or: [aPoint x > 2]) ifTrue: [self error: self class outOfBoardErrorDescription ].! !

!TaTeTi methodsFor: 'as yet unclassified' stamp: 'TF 5/20/2019 18:32:13'!
assertSymbolIsValid: aSymbol

	(aSymbol =#O or: aSymbol = #X) ifFalse: [self error: self class notValidTokenErrorDescription ].
! !

!TaTeTi methodsFor: 'as yet unclassified' stamp: 'TF 5/20/2019 18:56:27'!
at: aPosition
	^ occupiedPositions at: aPosition .! !

!TaTeTi methodsFor: 'as yet unclassified' stamp: 'TF 5/20/2019 18:50:10'!
initialize
	lastPlay := #O.
	occupiedPositions := Dictionary new.! !

!TaTeTi methodsFor: 'as yet unclassified' stamp: 'TF 5/20/2019 17:51:52'!
isOver
	^false.! !

!TaTeTi methodsFor: 'as yet unclassified' stamp: 'TF 5/20/2019 18:51:45'!
play: aSymbol at: aPoint 

	
	self assertSymbolIsValid: aSymbol.
	self assertPointIsValid: aPoint.
	self assertPointIsEmpty: aPoint.
	self assertIsPlayerTurn: aSymbol.
	
	lastPlay := aSymbol.
	
	occupiedPositions at: aPoint put: aSymbol.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TaTeTi class' category: #'Ingsoft-TaTeTi'!
TaTeTi class
	instanceVariableNames: ''!

!TaTeTi class methodsFor: 'as yet unclassified' stamp: 'TF 5/20/2019 19:27:39'!
cantPlayMoreThanThreePieces
	^'No podes jugar mas de 3 piezas de un mismo tipo'.! !

!TaTeTi class methodsFor: 'as yet unclassified' stamp: 'TF 5/20/2019 18:44:17'!
cantPlayOnOccupiedSpaceErrorDescription
	^'No podes jugar en una posicion ocupada'.! !

!TaTeTi class methodsFor: 'as yet unclassified' stamp: 'TF 5/20/2019 18:27:33'!
notValidTokenErrorDescription
	^'Las piezas validas son #X o #O'! !

!TaTeTi class methodsFor: 'as yet unclassified' stamp: 'TF 5/20/2019 18:02:49'!
notYourTurnErrorDescription
 ^'No es tu turno.'! !

!TaTeTi class methodsFor: 'as yet unclassified' stamp: 'TF 5/20/2019 18:05:12'!
outOfBoardErrorDescription
	^'No juegues afuera del tablero'.! !
