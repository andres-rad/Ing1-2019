!classDefinition: #TaTeTiTest category: #'Ingsoft-TaTeTi'!
TestCase subclass: #TaTeTiTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ingsoft-TaTeTi'!

!TaTeTiTest methodsFor: 'tests' stamp: 'TF 5/20/2019 18:36:37'!
test01CuandoComienzaElJuegoNoSeTermino
	
	| tateti |
	
	tateti := TaTeTi new.
	
	self assert: tateti isOver not.
		! !

!TaTeTiTest methodsFor: 'tests' stamp: 'atr 5/25/2019 20:02:14'!
test02EmpiezaElJugadorX
	
	| tateti |
	
	tateti := TaTeTi new.
	
	tateti playXAt: 0@0.
	
	self assert: (tateti at: 0@0) equals: #X. ! !

!TaTeTiTest methodsFor: 'tests' stamp: 'TF 5/27/2019 14:52:29'!
test03NoEmpiezaElJugadorO
	
	| tateti |
	
	tateti := TaTeTi new.
	
	self should: [tateti playOAt: 0@0] raise: Error  withMessageText: TaTeTi notYourTurnErrorDescription.
	
	! !

!TaTeTiTest methodsFor: 'tests' stamp: 'atr 5/25/2019 20:03:38'!
test04NoPuedoHacerUnMovimientoFueraDelTablero
	
	| tateti |
	
	tateti := TaTeTi new.
	
	
	self should: [tateti playXAt: 3@-1] raise: Error  withMessageText: TaTeTi outOfBoardErrorDescription.
	
	! !

!TaTeTiTest methodsFor: 'tests' stamp: 'atr 5/25/2019 20:03:55'!
test05NoPuedeJugarDosVecesSeguidasElMismoJugador
	
	| tateti |
	
	tateti := TaTeTi new.
	
	tateti playXAt: 0@0.
	self should: [tateti playXAt: 1@1] raise: Error  withMessageText: TaTeTi notYourTurnErrorDescription.
	
	! !

!TaTeTiTest methodsFor: 'tests' stamp: 'atr 5/26/2019 15:10:38'!
test06NoPuedoPonerDosPiezasEnLaMismaPosicion
	
	| tateti |
	
	tateti := TaTeTi new.
	
	tateti playXAt: 0@0.
	self should: [tateti playOAt: 0@0] raise: Error  withMessageText: TaTeTi cantPlayOnOccupiedSpaceErrorDescription.
	
	! !

!TaTeTiTest methodsFor: 'tests' stamp: 'atr 5/26/2019 15:10:43'!
test07PuedeJugarODespuesDeX
	
	| tateti |
	
	tateti := TaTeTi new.
	
	tateti playXAt: 0@0.
	tateti playOAt: 2@1.
	
	self assert: (tateti at: 0@0) equals: #X.
	self assert: (tateti at: 2@1) equals: #O.
	
	! !

!TaTeTiTest methodsFor: 'tests' stamp: 'atr 5/26/2019 15:18:34'!
test08ElJugadorONoPuedePonerMasDeTresFichas
	
	| tateti |
	
	tateti := TaTeTi new.
	
	tateti playXAt: 0@0.
	tateti playOAt: 0@1.
	tateti playXAt: 0@2.
	tateti playOAt: 1@0.
	tateti playXAt: 1@1.
	tateti playOAt: 1@2.
	
	self should: [tateti playOAt: 2@0] raise: Error withMessageText: TaTeTi cantPlayMoreThanThreePieces.
	
	self assert: (tateti at: 0@0) equals: #X.
	self assert: (tateti at: 0@2) equals: #X.
	self assert: (tateti at: 1@1) equals: #X.
	self assert: (tateti at: 0@1) equals: #O.
	self assert: (tateti at: 1@0) equals: #O.
	self assert: (tateti at: 1@2) equals: #O.
	
	! !

!TaTeTiTest methodsFor: 'tests' stamp: 'atr 5/26/2019 15:18:43'!
test09ElJugadorXNoPuedePonerMasDeTresFichas
	
	| tateti |
	
	tateti := TaTeTi new.
	
	tateti playXAt: 0@0.
	tateti playOAt: 0@1.
	tateti playXAt: 0@2.
	tateti playOAt: 1@0.
	tateti playXAt: 1@1.
	tateti playOAt: 1@2.
	
	self should: [tateti playXAt: 2@0] raise: Error withMessageText: TaTeTi cantPlayMoreThanThreePieces.
	
	self assert: (tateti at: 0@0) equals: #X.
	self assert: (tateti at: 0@2) equals: #X.
	self assert: (tateti at: 1@1) equals: #X.
	self assert: (tateti at: 0@1) equals: #O.
	self assert: (tateti at: 1@0) equals: #O.
	self assert: (tateti at: 1@2) equals: #O.
	
	! !

!TaTeTiTest methodsFor: 'tests' stamp: 'TF 5/27/2019 14:53:57'!
test10SiUnJugadorTieneTresFichasEnUnaFilaElJuegoSeTermina
	
	| tateti |
	
	tateti := TaTeTi new.
	
	tateti playXAt: 0@0.
	tateti playOAt: 2@2.
	tateti playXAt: 0@1.
	tateti playOAt: 1@0.
	tateti playXAt: 0@2.
	
	self assert: tateti isOver.
	! !

!TaTeTiTest methodsFor: 'tests' stamp: 'TF 5/27/2019 14:54:09'!
test11SiUnJugadorTieneTresFichasEnUnaColumnaElJuegoSeTermina
	
	| tateti |
	
	tateti := TaTeTi new.
	
	tateti playXAt: 0@0.
	tateti playOAt: 2@1.
	tateti playXAt: 2@2.
	tateti playOAt: 1@1.
	tateti playXAt: 2@0.
	tateti playOAt: 0@1.
	
	self assert: tateti isOver.
	! !

!TaTeTiTest methodsFor: 'tests' stamp: 'TF 5/27/2019 14:54:23'!
test12SiUnJugadorTieneTresFichasEnLaDiagonalQueBajaElJuegoSeTermina
	
	| tateti |
	
	tateti := TaTeTi new.
	
	tateti playXAt: 0@0.
	tateti playOAt: 0@1.
	tateti playXAt: 1@1.
	tateti playOAt: 0@2.
	tateti playXAt: 2@2.
	
	self assert: tateti isOver.
	! !

!TaTeTiTest methodsFor: 'tests' stamp: 'TF 5/27/2019 14:54:30'!
test13SiUnJugadorTieneTresFichasEnLaDiagonalQueSubeElJuegoSeTermina
	
	| tateti |
	
	tateti := TaTeTi new.
	
	tateti playXAt: 0@0.
	tateti playOAt: 2@0.
	tateti playXAt: 1@0.
	tateti playOAt: 1@1.
	tateti playXAt: 0@1.
	tateti playOAt: 0@2.
	
	self assert: tateti isOver.
	! !

!TaTeTiTest methodsFor: 'tests' stamp: 'atr 5/26/2019 15:16:35'!
test14SiUnJugadorYaGanoONoPuedePonerMasFichas
	
	| tateti |
	
	tateti := TaTeTi new.
	
	tateti playXAt: 0@0.
	tateti playOAt: 2@2.
	tateti playXAt: 0@1.
	tateti playOAt: 1@0.
	tateti playXAt: 0@2.
	
	self should: [ tateti playOAt: 2@1 ] raise: Error withMessageText: TaTeTi gameAlreadyOverErrorDescription.! !

!TaTeTiTest methodsFor: 'tests' stamp: 'atr 5/26/2019 15:16:59'!
test15SiUnJugadorYaGanoXNoPuedePonerMasFichas
	
	| tateti |
	
	tateti := TaTeTi new.
	
	tateti playXAt: 0@0.
	tateti playOAt: 2@2.
	tateti playXAt: 0@1.
	tateti playOAt: 1@0.
	tateti playXAt: 0@2.
	
	self should: [ tateti playXAt: 2@1 ] raise: Error withMessageText: TaTeTi gameAlreadyOverErrorDescription.! !

!TaTeTiTest methodsFor: 'tests' stamp: 'atr 5/26/2019 15:53:31'!
test16SiTodaviaNoSePusieronTodasLasFichasNoSePuedenMoverLasColocadas
	
	| tateti |
	
	tateti := TaTeTi new.
	
	tateti playXAt: 0@0.
	tateti playOAt: 2@2.
	
	self should: [ tateti moveXFrom: 0@0 to: 0@1 ] raise: Error withMessageText: TaTeTi cantMovePieceUntilAllArePlaced.
	self should: [ tateti moveOFrom: 2@2 to: 2@1 ] raise: Error withMessageText: TaTeTi cantMovePieceUntilAllArePlaced.! !

!TaTeTiTest methodsFor: 'tests' stamp: 'atr 5/26/2019 18:02:47'!
test17SiElJuegoSeTerminoNingunJugadorPuedeMoverUnaPieza
	
	| tateti |
	
	tateti := TaTeTi new.
	
	tateti playXAt: 0@0.
	tateti playOAt: 2@2.
	tateti playXAt: 0@1.
	tateti playOAt: 1@0.
	tateti playXAt: 0@2.

	self should: [ tateti moveXFrom: 0@2 to: 1@2 ] raise: Error withMessageText: TaTeTi gameAlreadyOverErrorDescription.
	self should: [ tateti moveOFrom: 2@2 to: 2@1 ] raise: Error withMessageText: TaTeTi gameAlreadyOverErrorDescription.! !

!TaTeTiTest methodsFor: 'tests' stamp: 'atr 5/26/2019 16:30:07'!
test18XNoPuedeDeslizarDesdeDondeNoHayFichas
	
	| tateti |
	
	tateti := TaTeTi new.
	
	tateti playXAt: 0@0.
	tateti playOAt: 0@1.
	tateti playXAt: 0@2.
	tateti playOAt: 1@0.
	tateti playXAt: 1@1.
	tateti playOAt: 1@2.

	self should: [ tateti moveXFrom: 2@0 to: 2@1 ] raise: Error withMessageText: TaTeTi cantMoveFromAnEmptyPositionErrorDescription.
! !

!TaTeTiTest methodsFor: 'tests' stamp: 'atr 5/26/2019 16:42:33'!
test19XNoPuedeDeslizarDesdeDondeHayO
	
	| tateti |
	
	tateti := TaTeTi new.
	
	tateti playXAt: 0@0.
	tateti playOAt: 0@1.
	tateti playXAt: 0@2.
	tateti playOAt: 1@0.
	tateti playXAt: 1@1.
	tateti playOAt: 1@2.

	self should: [ tateti moveXFrom: 1@2 to: 2@2 ] raise: Error withMessageText: TaTeTi cantMoveADifferentPieceErrorDescription.
! !

!TaTeTiTest methodsFor: 'tests' stamp: 'atr 5/26/2019 16:42:50'!
test20XNoPuedeDeslizarUnMovimientoMayorA1
	
	| tateti |
	
	tateti := TaTeTi new.
	
	tateti playXAt: 0@0.
	tateti playOAt: 0@1.
	tateti playXAt: 0@2.
	tateti playOAt: 1@0.
	tateti playXAt: 1@1.
	tateti playOAt: 2@0.

	self should: [ tateti moveXFrom: 0@2 to: 2@2 ] raise: Error withMessageText: TaTeTi invalidSlidingMovementErrorDescription.
! !

!TaTeTiTest methodsFor: 'tests' stamp: 'atr 5/26/2019 17:18:12'!
test21XNoPuedeDeslizarAUnaPosicionInvalida
	
	| tateti |
	
	tateti := TaTeTi new.
	
	tateti playXAt: 0@0.
	tateti playOAt: 0@1.
	tateti playXAt: 0@2.
	tateti playOAt: 1@0.
	tateti playXAt: 1@1.
	tateti playOAt: 2@0.

	self should: [ tateti moveXFrom: 0@2 to: 0@3 ] raise: Error withMessageText: TaTeTi invalidSlidingMovementErrorDescription .
! !

!TaTeTiTest methodsFor: 'tests' stamp: 'atr 5/26/2019 18:03:24'!
test22XNoPuedeDeslizarDesdeUnaPosicionInvalida
	
	| tateti |
	
	tateti := TaTeTi new.
	
	tateti playXAt: 0@0.
	tateti playOAt: 0@1.
	tateti playXAt: 0@2.
	tateti playOAt: 1@0.
	tateti playXAt: 1@1.
	tateti playOAt: 2@0.

	self should: [ tateti moveXFrom: 2@3 to: 2@2 ] raise: Error withMessageText: TaTeTi outOfBoardErrorDescription.
! !

!TaTeTiTest methodsFor: 'tests' stamp: 'atr 5/26/2019 16:58:32'!
test23XNoPuedeDeslizarPorUnaDiagonalInvalida
	
	| tateti |
	
	tateti := TaTeTi new.
	
	tateti playXAt: 0@1.
	tateti playOAt: 0@2.
	tateti playXAt: 1@0.
	tateti playOAt: 1@1.
	tateti playXAt: 1@2.
	tateti playOAt: 2@2.

	self should: [ tateti moveXFrom: 1@0 to: 2@1 ] raise: Error withMessageText: TaTeTi invalidSlidingMovementErrorDescription .
! !

!TaTeTiTest methodsFor: 'tests' stamp: 'TF 5/27/2019 14:56:15'!
test24SiDeslizoXDejaDeEstarDondeEstabaYPasaAEstarDondeLoMovi
	
	| tateti |
	
	tateti := TaTeTi new.
	
	tateti playXAt: 0@0.
	tateti playOAt: 0@1.
	tateti playXAt: 0@2.
	tateti playOAt: 1@0.
	tateti playXAt: 1@1.
	tateti playOAt: 2@0.

	tateti moveXFrom: 0@2 to: 1@2.
	
	tateti at: 0@2 ifPresent: [:unused | self fail].

	self assert: (tateti at: 1@2) equals: #X.
! !

!TaTeTiTest methodsFor: 'tests' stamp: 'atr 5/26/2019 17:42:44'!
test25ONoPuedeDeslizarDesdeDondeNoHayFichas
	
	| tateti |
	
	tateti := TaTeTi new.
	
	tateti playXAt: 0@1.
	tateti playOAt: 0@2.
	tateti playXAt: 1@0.
	tateti playOAt: 1@1.
	tateti playXAt: 1@2.
	tateti playOAt: 2@2.
	tateti moveXFrom: 1@0 to: 2@0.  
	
	self should: [ tateti moveOFrom: 0@0 to: 1@0 ] raise: Error withMessageText: TaTeTi cantMoveFromAnEmptyPositionErrorDescription.
! !

!TaTeTiTest methodsFor: 'tests' stamp: 'atr 5/26/2019 17:48:02'!
test26ONoPuedeDeslizarDesdeDondeHayX
	
	| tateti |
	
	tateti := TaTeTi new.
	
	tateti playXAt: 0@1.
	tateti playOAt: 0@2.
	tateti playXAt: 1@0.
	tateti playOAt: 1@1.
	tateti playXAt: 1@2.
	tateti playOAt: 2@2.
	tateti moveXFrom: 1@0 to: 2@0.  

	self should: [ tateti moveOFrom: 2@0 to: 2@1 ] raise: Error withMessageText: TaTeTi cantMoveADifferentPieceErrorDescription.
! !

!TaTeTiTest methodsFor: 'tests' stamp: 'atr 5/26/2019 17:49:28'!
test27ONoPuedeDeslizarUnMovimientoMayorA1
	
	| tateti |
	
	tateti := TaTeTi new.
	
	tateti playXAt: 0@1.
	tateti playOAt: 0@2.
	tateti playXAt: 1@0.
	tateti playOAt: 1@1.
	tateti playXAt: 1@2.
	tateti playOAt: 2@2.
	tateti moveXFrom: 1@0 to: 0@0.  
	
	self should: [ tateti moveOFrom: 2@2 to: 2@0 ] raise: Error withMessageText: TaTeTi invalidSlidingMovementErrorDescription.
! !

!TaTeTiTest methodsFor: 'tests' stamp: 'atr 5/26/2019 17:50:43'!
test28ONoPuedeDeslizarAUnaPosicionInvalida
	
	| tateti |
	
	tateti := TaTeTi new.
	
	
	tateti playXAt: 0@1.
	tateti playOAt: 0@2.
	tateti playXAt: 1@0.
	tateti playOAt: 1@1.
	tateti playXAt: 1@2.
	tateti playOAt: 2@2.
	tateti moveXFrom: 1@0 to: 2@0.  

	self should: [ tateti moveOFrom: 2@2 to: 2@3 ] raise: Error withMessageText: TaTeTi invalidSlidingMovementErrorDescription .
! !

!TaTeTiTest methodsFor: 'tests' stamp: 'atr 5/26/2019 17:52:29'!
test29ONoPuedeDeslizarPorUnaDiagonalInvalida
	
	| tateti |
	
	tateti := TaTeTi new.
	
	tateti playXAt: 0@1.
	tateti playOAt: 0@2.
	tateti playXAt: 1@0.
	tateti playOAt: 2@1.
	tateti playXAt: 1@2.
	tateti playOAt: 2@2.
	tateti moveXFrom: 1@0 to: 0@0.  

	self should: [ tateti moveOFrom: 2@1 to: 1@0 ] raise: Error withMessageText: TaTeTi invalidSlidingMovementErrorDescription .
! !

!TaTeTiTest methodsFor: 'tests' stamp: 'atr 5/26/2019 17:53:23'!
test30SiDeslizoODejaDeEstarDondeEstabaYPasaAEstarDondeLoMovi
	
	| tateti |
	
	tateti := TaTeTi new.
	
	
	tateti playXAt: 0@1.
	tateti playOAt: 0@2.
	tateti playXAt: 1@0.
	tateti playOAt: 1@1.
	tateti playXAt: 1@2.
	tateti playOAt: 2@2.
	tateti moveXFrom: 1@0 to: 2@0.  

	tateti moveOFrom: 1@1 to: 0@0.
	


	tateti at: 1@1 ifPresent: [:unused | self fail].


	self assert: (tateti at: 0@0) equals: #O.
! !

!TaTeTiTest methodsFor: 'tests' stamp: 'atr 5/26/2019 17:57:36'!
test31NoPuedoDeslizarDosVecesSeguidasX
	
	| tateti |
	
	tateti := TaTeTi new.
	
	
	tateti playXAt: 0@1.
	tateti playOAt: 0@2.
	tateti playXAt: 1@0.
	tateti playOAt: 1@1.
	tateti playXAt: 1@2.
	tateti playOAt: 2@2.
	tateti moveXFrom: 1@0 to: 2@0.  

	self should:  [tateti moveXFrom: 2@0 to: 1@0.] raise: Error  withMessageText: TaTeTi notYourTurnErrorDescription.
	
! !

!TaTeTiTest methodsFor: 'tests' stamp: 'atr 5/26/2019 17:58:44'!
test32NoPuedoDeslizarDosVecesSeguidasO
	
	| tateti |
	
	tateti := TaTeTi new.
	
	
	tateti playXAt: 0@1.
	tateti playOAt: 0@2.
	tateti playXAt: 1@0.
	tateti playOAt: 1@1.
	tateti playXAt: 1@2.
	tateti playOAt: 2@2.
	tateti moveXFrom: 1@0 to: 2@0.  
	
	tateti moveOFrom: 2@2 to: 2@1. 

	self should:  [tateti moveOFrom: 2@1 to: 2@2.] raise: Error  withMessageText: TaTeTi notYourTurnErrorDescription.
	
! !

!TaTeTiTest methodsFor: 'tests' stamp: 'atr 5/26/2019 18:01:19'!
test33NoPuedoDeslizarXAUnaPosicionOcupada
	
	| tateti |
	
	tateti := TaTeTi new.
	
	
	tateti playXAt: 0@1.
	tateti playOAt: 0@2.
	tateti playXAt: 1@0.
	tateti playOAt: 1@1.
	tateti playXAt: 1@2.
	tateti playOAt: 2@2.
	

	self should:  [tateti moveXFrom: 1@0 to: 1@1.] raise: Error  withMessageText: TaTeTi cantPlayOnOccupiedSpaceErrorDescription .
	
! !

!TaTeTiTest methodsFor: 'tests' stamp: 'atr 5/26/2019 18:04:07'!
test34NoPuedoDeslizarOAUnaPosicionOcupada
	
	| tateti |
	
	tateti := TaTeTi new.
	
	
	tateti playXAt: 0@1.
	tateti playOAt: 0@2.
	tateti playXAt: 1@0.
	tateti playOAt: 1@1.
	tateti playXAt: 1@2.
	tateti playOAt: 2@2.
	tateti moveXFrom: 1@0 to: 2@0.

	self should:  [tateti moveOFrom: 1@1 to: 1@2.] raise: Error  withMessageText: TaTeTi cantPlayOnOccupiedSpaceErrorDescription .
	
! !

!TaTeTiTest methodsFor: 'tests' stamp: 'atr 5/26/2019 18:20:47'!
test35ElJuegoTerminaComoXComoGanadorCuandoGana
	
	| tateti |
	
	tateti := TaTeTi new.
	
	tateti playXAt: 0@1.
	tateti playOAt: 1@2.
	tateti playXAt: 0@2.
	tateti playOAt: 1@1.
	tateti playXAt: 0@0.

	self assert: tateti winner equals: #X.	
! !

!TaTeTiTest methodsFor: 'tests' stamp: 'atr 5/26/2019 18:26:43'!
test36ElJuegoTerminaComoOComoGanadorCuandoGana
	
	| tateti |
	
	tateti := TaTeTi new.
	
	tateti playXAt: 2@2.	
	tateti playOAt: 0@1.
	tateti playXAt: 1@2.
	tateti playOAt: 0@2.
	tateti playXAt: 1@1.
	tateti playOAt: 0@0.

	self assert: tateti winner equals: #O.	
! !

!TaTeTiTest methodsFor: 'tests' stamp: 'atr 5/26/2019 18:29:13'!
test37NoHayGanadorSiNoTerminoElJuego
	
	| tateti |
	
	tateti := TaTeTi new.
	
	tateti playXAt: 2@2.	
	tateti playOAt: 0@1.
	
	
	self should: [tateti winner] raise: Error  withMessageText: TaTeTi noWinnerErrorDescription.	
! !


!classDefinition: #TaTeTi category: #'Ingsoft-TaTeTi'!
Object subclass: #TaTeTi
	instanceVariableNames: 'occupiedPositions state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ingsoft-TaTeTi'!

!TaTeTi methodsFor: 'initialization' stamp: 'atr 5/26/2019 12:03:06'!
initialize
	state := TaTeTiInitialStageXToMove new.
	occupiedPositions := Dictionary new.
	! !


!TaTeTi methodsFor: 'game logic' stamp: 'TF 5/27/2019 15:00:03'!
hasWinFor: aSymbol
	^ (((self hasWinInColumn: aSymbol) 
		or: [self hasWinInRow: aSymbol]) 
			or: [self hasWinInDownwardDiagonal: aSymbol])
				or: [self hasWinInUpwardDiagonal: aSymbol].! !

!TaTeTi methodsFor: 'game logic' stamp: 'atr 5/26/2019 18:05:09'!
hasWinInColumn: aSymbol
	| PiecePositions |
	
	PiecePositions := (occupiedPositions select: [:piece | piece = aSymbol ]) keys.
	
	^(0 to: 2) anySatisfy: [ :row | (PiecePositions count: [ :position | position x = row ]) = 3].! !

!TaTeTi methodsFor: 'game logic' stamp: 'atr 5/26/2019 14:49:12'!
hasWinInDownwardDiagonal: aSymbol
	|downwardDiagonal |
	
	downwardDiagonal _ OrderedCollection with: 0@0 with: 1@1  with: 2@2. 

	^ self player: aSymbol hasWinInDiagonal: downwardDiagonal.! !

!TaTeTi methodsFor: 'game logic' stamp: 'atr 5/26/2019 13:35:57'!
hasWinInRow: aSymbol
	| PiecePositions |
	
	PiecePositions := (occupiedPositions select: [:piece | piece = aSymbol ]) keys.
	
	^(0 to: 2) anySatisfy: [ :column | (PiecePositions count: [:position | position y = column]) = 3].! !

!TaTeTi methodsFor: 'game logic' stamp: 'atr 5/26/2019 14:50:09'!
hasWinInUpwardDiagonal: aSymbol 
	| upwardDiagonal |	
	
	upwardDiagonal _ OrderedCollection with: 2@0 with: 1@1  with: 0@2. 
	
	^ self player: aSymbol hasWinInDiagonal: upwardDiagonal.
		! !

!TaTeTi methodsFor: 'game logic' stamp: 'atr 5/26/2019 13:29:48'!
isOver
	^state isOver.! !

!TaTeTi methodsFor: 'game logic' stamp: 'atr 5/26/2019 14:48:12'!
player: aSymbol hasWinInDiagonal: aDiagonalPositions 
	| PiecePositions |
	
	PiecePositions := (occupiedPositions select: [:piece | piece = aSymbol ]) keys.
	^ PiecePositions includesAllOf: aDiagonalPositions .
	! !

!TaTeTi methodsFor: 'game logic' stamp: 'atr 5/26/2019 18:25:59'!
winner
	^state winner.! !


!TaTeTi methodsFor: 'assertions' stamp: 'TF 5/20/2019 18:53:14'!
assertPointIsEmpty: aPoint

	occupiedPositions at: aPoint ifPresent: [:symbol | self error: self class cantPlayOnOccupiedSpaceErrorDescription ].! !

!TaTeTi methodsFor: 'assertions' stamp: 'atr 5/26/2019 18:15:01'!
assertPointIsValid: aPoint
	((0 to: 2) includesAllOf: (Array with: aPoint x with: aPoint y))
		ifFalse: [self error: self class outOfBoardErrorDescription ].! !

!TaTeTi methodsFor: 'assertions' stamp: 'atr 5/26/2019 12:28:59'!
hasAllPiecesPlaced
	^ occupiedPositions size = 6.! !


!TaTeTi methodsFor: 'accessing' stamp: 'TF 5/20/2019 18:56:27'!
at: aPosition
	^ occupiedPositions at: aPosition .! !

!TaTeTi methodsFor: 'accessing' stamp: 'atr 5/26/2019 16:35:14'!
at: aPosition ifAbsent: aBlock
	^ occupiedPositions at: aPosition ifAbsent: aBlock .! !

!TaTeTi methodsFor: 'accessing' stamp: 'atr 5/26/2019 17:24:23'!
at: aPosition ifPresent: aBlock
	^ occupiedPositions at: aPosition ifPresent: aBlock .! !


!TaTeTi methodsFor: 'ingame actions' stamp: 'atr 5/26/2019 18:17:32'!
moveOFrom: aPosition to: anotherPosition

	self 
		assertPointIsEmpty: anotherPosition;
		assertPointIsValid: aPosition .
	
	state moveOFrom: aPosition to: anotherPosition inGame: self. ! !

!TaTeTi methodsFor: 'ingame actions' stamp: 'atr 5/26/2019 18:07:02'!
movePieceFrom: aPoint to: anotherPoint 

	occupiedPositions 
		at: anotherPoint put: (occupiedPositions at: aPoint );
		removeKey: aPoint.! !

!TaTeTi methodsFor: 'ingame actions' stamp: 'atr 5/26/2019 18:07:19'!
moveXFrom: aPosition to: anotherPosition

	self 
		assertPointIsEmpty: anotherPosition;
		assertPointIsValid: aPosition .
	
	state moveXFrom: aPosition to: anotherPosition inGame: self. ! !

!TaTeTi methodsFor: 'ingame actions' stamp: 'atr 5/26/2019 18:06:17'!
placePiece: aSymbol at: aPosition
	occupiedPositions at: aPosition put: aSymbol.! !

!TaTeTi methodsFor: 'ingame actions' stamp: 'atr 5/26/2019 18:07:41'!
playOAt: aPoint 

	self 
		assertPointIsValid: aPoint;
		assertPointIsEmpty: aPoint.
	
	state playOAt: aPoint inGame: self.
	! !

!TaTeTi methodsFor: 'ingame actions' stamp: 'atr 5/26/2019 18:18:18'!
playXAt: aPoint 

	self 
		assertPointIsValid: aPoint;
		assertPointIsEmpty: aPoint.

	state playXAt: aPoint inGame: self.! !


!TaTeTi methodsFor: 'private' stamp: 'atr 5/26/2019 18:18:05'!
state: aNewState
	state _ aNewState.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TaTeTi class' category: #'Ingsoft-TaTeTi'!
TaTeTi class
	instanceVariableNames: 'validMovements'!

!TaTeTi class methodsFor: 'as yet unclassified' stamp: 'atr 5/26/2019 16:42:33'!
cantMoveADifferentPieceErrorDescription
	^'No podes mover una ficha de otro tipo en tu turno'.! !

!TaTeTi class methodsFor: 'as yet unclassified' stamp: 'atr 5/26/2019 16:30:38'!
cantMoveFromAnEmptyPositionErrorDescription
	^'No se puede mover una ficha de una posicion vacia'.! !

!TaTeTi class methodsFor: 'as yet unclassified' stamp: 'atr 5/26/2019 15:50:00'!
cantMovePieceUntilAllArePlaced
	^ 'No se puede mover una pieza hasta haber colocado todas en el tablero'.! !

!TaTeTi class methodsFor: 'as yet unclassified' stamp: 'TF 5/20/2019 19:27:39'!
cantPlayMoreThanThreePieces
	^'No podes jugar mas de 3 piezas de un mismo tipo'.! !

!TaTeTi class methodsFor: 'as yet unclassified' stamp: 'TF 5/20/2019 18:44:17'!
cantPlayOnOccupiedSpaceErrorDescription
	^'No podes jugar en una posicion ocupada'.! !

!TaTeTi class methodsFor: 'as yet unclassified' stamp: 'atr 5/26/2019 15:13:32'!
gameAlreadyOverErrorDescription
	^'El juego ya finalizó'.! !

!TaTeTi class methodsFor: 'as yet unclassified' stamp: 'atr 5/26/2019 17:13:23'!
initialize
	| validMovementsArray |
	
	validMovements := Dictionary new.
	
	validMovementsArray := Array with: 0@1 with: 1@0 with: 1@1.
	validMovements at: 0@0 put: validMovementsArray. 
	
	validMovementsArray := Array with: 0@0 with: 1@1 with: 0@2.
	validMovements at: 0@1 put: validMovementsArray. 
	
	validMovementsArray := Array with: 0@1 with: 1@1 with: 1@2.
	validMovements at: 0@2 put: validMovementsArray. 
	
	validMovementsArray := Array with: 0@0 with: 1@1 with: 2@0.
	validMovements at: 1@0 put: validMovementsArray. 
	
	validMovementsArray := (Array with: 0@0 with: 0@1 with: 0@2), (Array with: 1@0 with: 1@2), (Array with: 2@0 with: 2@1 with: 2@2).
	validMovements at: 1@1 put: validMovementsArray. 
	
	validMovementsArray := Array with: 0@2 with: 1@1 with: 2@2.
	validMovements at: 1@2 put: validMovementsArray.
	
	validMovementsArray := Array with: 1@0 with: 1@1 with: 2@1.
	validMovements at: 2@0 put: validMovementsArray. 
	
	validMovementsArray := Array with: 2@0 with: 1@1 with: 2@2.
	validMovements at: 2@1 put: validMovementsArray. 
	
	validMovementsArray := Array with: 2@1 with: 1@1 with: 1@2.
	validMovements at: 2@2 put: validMovementsArray. ! !

!TaTeTi class methodsFor: 'as yet unclassified' stamp: 'atr 5/26/2019 16:43:11'!
invalidSlidingMovementErrorDescription
	^'Movimiento invalido'.! !

!TaTeTi class methodsFor: 'as yet unclassified' stamp: 'atr 5/26/2019 18:29:30'!
noWinnerErrorDescription
	^'Todavia no hay un ganador'.! !

!TaTeTi class methodsFor: 'as yet unclassified' stamp: 'TF 5/20/2019 18:27:33'!
notValidTokenErrorDescription
	^'Las piezas validas son #X o #O'! !

!TaTeTi class methodsFor: 'as yet unclassified' stamp: 'TF 5/20/2019 18:02:49'!
notYourTurnErrorDescription
 ^'No es tu turno.'! !

!TaTeTi class methodsFor: 'as yet unclassified' stamp: 'TF 5/20/2019 18:05:12'!
outOfBoardErrorDescription
	^'No juegues afuera del tablero'.! !

!TaTeTi class methodsFor: 'as yet unclassified' stamp: 'atr 5/26/2019 17:15:04'!
validMovements
	^validMovements.! !


!classDefinition: #TaTeTiState category: #'Ingsoft-TaTeTi'!
Object subclass: #TaTeTiState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ingsoft-TaTeTi'!

!TaTeTiState methodsFor: 'state' stamp: 'atr 5/26/2019 17:32:12'!
nextStateOf: aGame
	self subclassResponsibility.! !


!TaTeTiState methodsFor: 'ingame actions' stamp: 'atr 5/26/2019 16:10:52'!
moveOFrom: aPosition to: anotherPosition inGame: aTicTacToeGame
	self subclassResponsibility.! !

!TaTeTiState methodsFor: 'ingame actions' stamp: 'atr 5/26/2019 16:10:50'!
moveXFrom: aPosition to: anotherPosition inGame: aTicTacToeGame
	self subclassResponsibility.! !

!TaTeTiState methodsFor: 'ingame actions' stamp: 'TF 5/27/2019 15:02:05'!
playOAt: aPosition inGame: aTicTacToeGame
	self subclassResponsibility.! !

!TaTeTiState methodsFor: 'ingame actions' stamp: 'TF 5/27/2019 15:02:08'!
playXAt: aPosition inGame: aTicTacToeGame
	self subclassResponsibility.! !


!TaTeTiState methodsFor: 'game logic' stamp: 'atr 5/26/2019 15:19:45'!
isOver
	self subclassResponsibility.! !

!TaTeTiState methodsFor: 'game logic' stamp: 'atr 5/26/2019 18:23:59'!
winner
	self subclassResponsibility .! !


!classDefinition: #TaTeTiGameOverState category: #'Ingsoft-TaTeTi'!
TaTeTiState subclass: #TaTeTiGameOverState
	instanceVariableNames: 'winner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ingsoft-TaTeTi'!

!TaTeTiGameOverState methodsFor: 'game logic' stamp: 'atr 5/26/2019 13:30:16'!
isOver
	^true! !

!TaTeTiGameOverState methodsFor: 'game logic' stamp: 'atr 5/26/2019 18:22:49'!
winner
	^winner.! !


!TaTeTiGameOverState methodsFor: 'ingame actions' stamp: 'atr 5/26/2019 16:01:02'!
moveOFrom: aPosition to: anotherPosition inGame: aTicTacToeGame
	^ self error: aTicTacToeGame class gameAlreadyOverErrorDescription. ! !

!TaTeTiGameOverState methodsFor: 'ingame actions' stamp: 'atr 5/26/2019 16:01:05'!
moveXFrom: aPosition to: anotherPosition inGame: aTicTacToeGame
	^ self error: aTicTacToeGame class gameAlreadyOverErrorDescription. ! !

!TaTeTiGameOverState methodsFor: 'ingame actions' stamp: 'atr 5/26/2019 15:15:45'!
playOAt: aPosition inGame: aTicTacToeGame
	^ self error: aTicTacToeGame class gameAlreadyOverErrorDescription. ! !

!TaTeTiGameOverState methodsFor: 'ingame actions' stamp: 'atr 5/26/2019 15:15:37'!
playXAt: aPosition inGame: aTicTacToeGame
	^ self error: aTicTacToeGame class gameAlreadyOverErrorDescription. ! !


!TaTeTiGameOverState methodsFor: 'state' stamp: 'atr 5/26/2019 17:32:43'!
nextStateOf: aTicTacToeGame
	self shouldNotImplement ! !


!TaTeTiGameOverState methodsFor: 'initialization' stamp: 'atr 5/26/2019 18:22:34'!
withWinner: aPlayer
	winner _ aPlayer! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TaTeTiGameOverState class' category: #'Ingsoft-TaTeTi'!
TaTeTiGameOverState class
	instanceVariableNames: ''!

!TaTeTiGameOverState class methodsFor: 'instantiation' stamp: 'atr 5/26/2019 18:22:05'!
withWinner: aPlayer
	^self new withWinner: aPlayer.! !


!classDefinition: #TaTeTiInitialStage category: #'Ingsoft-TaTeTi'!
TaTeTiState subclass: #TaTeTiInitialStage
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ingsoft-TaTeTi'!

!TaTeTiInitialStage methodsFor: 'game logic' stamp: 'atr 5/26/2019 13:30:29'!
isOver
	^false! !

!TaTeTiInitialStage methodsFor: 'game logic' stamp: 'atr 5/26/2019 18:23:26'!
winner
	self error: TaTeTi noWinnerErrorDescription.! !


!TaTeTiInitialStage methodsFor: 'ingame actions' stamp: 'atr 5/26/2019 15:54:59'!
moveOFrom: aPosition to: anotherPosition inGame: aTicTacToeGame
	^ self error: aTicTacToeGame class cantMovePieceUntilAllArePlaced.! !

!TaTeTiInitialStage methodsFor: 'ingame actions' stamp: 'atr 5/26/2019 15:51:30'!
moveXFrom: aPosition to: anotherPosition inGame: aTicTacToeGame
	^ self error: aTicTacToeGame class cantMovePieceUntilAllArePlaced.! !


!classDefinition: #TaTeTiInitialStageOToMove category: #'Ingsoft-TaTeTi'!
TaTeTiInitialStage subclass: #TaTeTiInitialStageOToMove
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ingsoft-TaTeTi'!

!TaTeTiInitialStageOToMove methodsFor: 'state' stamp: 'atr 5/26/2019 18:25:36'!
nextStateOf: aGame
	(aGame hasWinFor: #O)
		ifTrue: [aGame state: (TaTeTiGameOverState withWinner: #O).]
		ifFalse: [
			aGame hasAllPiecesPlaced 
				ifTrue: [aGame state: TaTeTiSlidingStateXToMove new.]
				ifFalse: [aGame state: TaTeTiInitialStageXToMove new.]
		].! !


!TaTeTiInitialStageOToMove methodsFor: 'ingame actions' stamp: 'atr 5/26/2019 13:31:27'!
playOAt: aPosition inGame: aTicTacToeGame
	aTicTacToeGame placePiece: #O at: aPosition.
	self nextStateOf: aTicTacToeGame.! !

!TaTeTiInitialStageOToMove methodsFor: 'ingame actions' stamp: 'TF 5/27/2019 15:03:17'!
playXAt: aPosition inGame: aTicTacToeGame
	self error: aTicTacToeGame class notYourTurnErrorDescription.! !


!classDefinition: #TaTeTiInitialStageXToMove category: #'Ingsoft-TaTeTi'!
TaTeTiInitialStage subclass: #TaTeTiInitialStageXToMove
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ingsoft-TaTeTi'!

!TaTeTiInitialStageXToMove methodsFor: 'state' stamp: 'atr 5/26/2019 18:25:19'!
nextStateOf: aGame
	(aGame hasWinFor: #X)
		ifTrue: [aGame state: (TaTeTiGameOverState withWinner: #X).]
		ifFalse: [aGame state: TaTeTiInitialStageOToMove new.].! !


!TaTeTiInitialStageXToMove methodsFor: 'ingame actions' stamp: 'TF 5/27/2019 15:03:25'!
playOAt: aPosition inGame: aTicTacToeGame
	self error: aTicTacToeGame class notYourTurnErrorDescription.! !

!TaTeTiInitialStageXToMove methodsFor: 'ingame actions' stamp: 'atr 5/26/2019 13:31:56'!
playXAt: aPosition inGame: aTicTacToeGame
	aTicTacToeGame placePiece: #X at: aPosition.
	self nextStateOf: aTicTacToeGame.! !


!classDefinition: #TaTeTiSlidingState category: #'Ingsoft-TaTeTi'!
TaTeTiState subclass: #TaTeTiSlidingState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ingsoft-TaTeTi'!

!TaTeTiSlidingState methodsFor: 'game logic' stamp: 'atr 5/26/2019 13:30:37'!
isOver
	^false! !

!TaTeTiSlidingState methodsFor: 'game logic' stamp: 'atr 5/26/2019 18:23:40'!
winner
	self error: TaTeTi noWinnerErrorDescription.! !


!TaTeTiSlidingState methodsFor: 'ingame actions' stamp: 'atr 5/26/2019 13:39:05'!
playOAt: aPosition inGame: aTicTacToeGame
	self error: aTicTacToeGame class cantPlayMoreThanThreePieces.! !

!TaTeTiSlidingState methodsFor: 'ingame actions' stamp: 'atr 5/26/2019 13:39:01'!
playXAt: aPosition inGame: aTicTacToeGame
	self error: aTicTacToeGame class cantPlayMoreThanThreePieces.! !


!classDefinition: #TaTeTiSlidingStateOToMove category: #'Ingsoft-TaTeTi'!
TaTeTiSlidingState subclass: #TaTeTiSlidingStateOToMove
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ingsoft-TaTeTi'!

!TaTeTiSlidingStateOToMove methodsFor: 'ingame actions' stamp: 'atr 5/26/2019 18:04:39'!
moveOFrom: aPosition to: anotherPosition inGame: aTicTacToeGame
	
	
	((TaTeTi validMovements at: aPosition) includes: anotherPosition) ifFalse: [self error: TaTeTi invalidSlidingMovementErrorDescription ].
		
	((aTicTacToeGame at: aPosition ifAbsent: [self error: TaTeTi cantMoveFromAnEmptyPositionErrorDescription ]) = #O) 
		ifFalse:  [self error: TaTeTi cantMoveADifferentPieceErrorDescription ].
		
	aTicTacToeGame movePieceFrom: aPosition to: anotherPosition .
	
	self nextStateOf: aTicTacToeGame .! !

!TaTeTiSlidingStateOToMove methodsFor: 'ingame actions' stamp: 'TF 5/27/2019 15:04:08'!
moveXFrom: aPosition to: anotherPosition inGame: aTicTacToeGame

	self error: aTicTacToeGame class notYourTurnErrorDescription.! !


!TaTeTiSlidingStateOToMove methodsFor: 'state' stamp: 'atr 5/26/2019 18:24:54'!
nextStateOf: aGame
	(aGame hasWinFor: #O)
		ifTrue: [aGame state: (TaTeTiGameOverState withWinner: #O).]
		ifFalse: [aGame state: TaTeTiSlidingStateXToMove new.].! !


!classDefinition: #TaTeTiSlidingStateXToMove category: #'Ingsoft-TaTeTi'!
TaTeTiSlidingState subclass: #TaTeTiSlidingStateXToMove
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ingsoft-TaTeTi'!

!TaTeTiSlidingStateXToMove methodsFor: 'ingame actions' stamp: 'TF 5/27/2019 15:04:21'!
moveOFrom: aPosition to: anotherPosition inGame: aTicTacToeGame

	self error: aTicTacToeGame class notYourTurnErrorDescription.! !

!TaTeTiSlidingStateXToMove methodsFor: 'ingame actions' stamp: 'atr 5/26/2019 18:04:46'!
moveXFrom: aPosition to: anotherPosition inGame: aTicTacToeGame
	
	
	((TaTeTi validMovements at: aPosition) includes: anotherPosition) ifFalse: [self error: TaTeTi invalidSlidingMovementErrorDescription ].
		
	((aTicTacToeGame at: aPosition ifAbsent: [self error: TaTeTi cantMoveFromAnEmptyPositionErrorDescription ]) = #X) 
		ifFalse:  [self error: TaTeTi cantMoveADifferentPieceErrorDescription ].
		
	aTicTacToeGame movePieceFrom: aPosition to: anotherPosition .
	
	self nextStateOf: aTicTacToeGame .! !


!TaTeTiSlidingStateXToMove methodsFor: 'state' stamp: 'atr 5/26/2019 18:25:08'!
nextStateOf: aGame
	(aGame hasWinFor: #X)
		ifTrue: [aGame state: (TaTeTiGameOverState withWinner: #X).]
		ifFalse: [aGame state: TaTeTiSlidingStateOToMove new.].! !

TaTeTi initialize!