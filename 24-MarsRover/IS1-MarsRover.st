!classDefinition: #MarsRoverTest category: #'IS1-MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-MarsRover'!

!MarsRoverTest methodsFor: 'testing' stamp: 'TF 5/12/2019 18:19:44'!
assert: aRover isAt: aPoint pointingAt: aDirection
	self assert: aRover position equals: aPoint .
	self assert: aRover direction equals: aDirection .! !

!MarsRoverTest methodsFor: 'testing' stamp: 'TF 5/12/2019 18:20:09'!
test01CanCreateMarsRoversAnywherePointingSomewhere
	| initialPosition initialDirection aRover |
	
	initialPosition := 1@2.
	initialDirection := #North.
	
	aRover := MarsRover at: initialPosition pointingTo: initialDirection .
	
	aRover execute: ''.
	
	self assert: aRover isAt: initialPosition  pointingAt: initialDirection .
	

! !

!MarsRoverTest methodsFor: 'testing' stamp: 'TF 5/12/2019 18:21:35'!
test02ShouldFailWithInvalidCommand
	| aRover itsInitialPosition itsInitialDirection|
	
	itsInitialPosition := 1@2.
	itsInitialDirection := #North.
	
	aRover := MarsRover at: itsInitialPosition pointingTo: itsInitialDirection .
	
	self should: [aRover execute: 'x'] 
		 raise: Error 
		 withMessageText: aRover class invalidCommandErrorDescription .
	
	self assert: aRover isAt: itsInitialPosition  pointingAt: itsInitialDirection .! !

!MarsRoverTest methodsFor: 'testing' stamp: 'TF 5/12/2019 18:21:54'!
test03ItMovesNorthWhenPointingThereAndReceivingForewardCommand
	| aRover aCommand |
	
	aRover := MarsRover at: 1@2 pointingTo: #North.
	
	aCommand := 'f'.
	
	aRover execute: aCommand .
	
	self assert: aRover isAt: 2@2  pointingAt: #North. 
	

! !

!MarsRoverTest methodsFor: 'testing' stamp: 'TF 5/12/2019 18:22:16'!
test04ItMovesInItsOppositeDirectionWhenReceivingBackwardCommand
	| aRover aCommand |
	
	aRover := MarsRover at: 1@2 pointingTo: #North.
	
	aCommand := 'b'.
	
	aRover execute: aCommand .
	
	self assert: aRover isAt:  0@2 pointingAt: #North. 
	

! !

!MarsRoverTest methodsFor: 'testing' stamp: 'TF 5/12/2019 18:22:32'!
test05TurnsWestWhenPointingNorthAndReceivingLeftCommand
	| aRover aCommand |
	
	aRover := MarsRover at: 1@2 pointingTo: #North.
	
	aCommand := 'l'.
	
	aRover execute: aCommand .
	
	self assert: aRover isAt:  1@2 pointingAt: #West. 
	

! !

!MarsRoverTest methodsFor: 'testing' stamp: 'TF 5/12/2019 18:22:48'!
test06TurnsEastWhenPointingNorthAndReceivingRightCommand
	| aRover aCommand |
	
	aRover := MarsRover at: 1@2 pointingTo: #North.
	
	aCommand := 'r'.
	
	aRover execute: aCommand .
	
	self assert: aRover isAt: 1@2  pointingAt: #East.

! !

!MarsRoverTest methodsFor: 'testing' stamp: 'TF 5/12/2019 18:23:06'!
test07ItMovesEastWhenPointingThereAndReceivingForewardCommand
	| aRover aCommand |
	
	aRover := MarsRover at: 1@2 pointingTo: #East.
	
	aCommand := 'f'.
	
	aRover execute: aCommand .

	self assert: aRover isAt: 1@3  pointingAt: #East. 
	

! !

!MarsRoverTest methodsFor: 'testing' stamp: 'TF 5/12/2019 18:23:20'!
test08TurnsSouthWithoutMovingWhenPointingEastAndReceivingRightCommand
	| aRover aCommand |
	
	aRover := MarsRover at: 0@0 pointingTo: #East.
	
	aCommand := 'r'.
	
	aRover execute: aCommand .
	
	self assert: aRover isAt: 0@0  pointingAt: #South.

! !

!MarsRoverTest methodsFor: 'testing' stamp: 'TF 5/12/2019 18:23:37'!
test09TurnsNorthWithoutMovingWhenPointingEastAndReceivingLeftCommand
	| aRover aCommand |
	
	aRover := MarsRover at: 0@0 pointingTo: #East.
	
	aCommand := 'l'.
	
	aRover execute: aCommand .
	
	self assert: aRover isAt: 0@0  pointingAt: #North.

! !

!MarsRoverTest methodsFor: 'testing' stamp: 'TF 5/12/2019 18:23:55'!
test10ItMovesSouthWhenPointingThereAndReceivingForewardCommand
	| aRover aCommand |
	
	aRover := MarsRover at: 1@2 pointingTo: #South.
	
	aCommand := 'f'.
	
	aRover execute: aCommand .
	
	self assert: aRover isAt: 0@2  pointingAt: #South.

! !

!MarsRoverTest methodsFor: 'testing' stamp: 'TF 5/12/2019 18:24:10'!
test11TurnsEastWithoutMovingWhenPointingSouthAndReceivingLeftCommand
	| aRover aCommand |
	
	aRover := MarsRover at: 1@2 pointingTo: #South.
	
	aCommand := 'l'.
	
	aRover execute: aCommand .
	
	self assert: aRover isAt: 1@2  pointingAt: #East.

! !

!MarsRoverTest methodsFor: 'testing' stamp: 'TF 5/12/2019 18:24:27'!
test12TurnsWestWithoutMovingWhenPointingSouthAndReceivingRightCommand
	| aRover aCommand |
	
	aRover := MarsRover at: 1@2 pointingTo: #South.
	
	aCommand := 'r'.
	
	aRover execute: aCommand .
	
	self assert: aRover isAt: 1@2  pointingAt: #West. 

! !

!MarsRoverTest methodsFor: 'testing' stamp: 'TF 5/12/2019 18:24:43'!
test13ItMovesWestWhenPointingThereAndReceivingForewardCommand
	| aRover aCommand |
	
	aRover := MarsRover at: 1@2 pointingTo: #West.
	
	aCommand := 'f'.
	
	aRover execute: aCommand .
	
	self assert: aRover isAt: 1@1  pointingAt: #West.

! !

!MarsRoverTest methodsFor: 'testing' stamp: 'TF 5/12/2019 18:24:57'!
test14TurnsSouthWithoutMovingWhenPointingWestAndReceivingLeftCommand
	| aRover aCommand |
	
	aRover := MarsRover at: 1@2 pointingTo: #West.
	
	aCommand := 'l'.
	
	aRover execute: aCommand .
	
	self assert: aRover isAt: 1@2  pointingAt: #South. 

! !

!MarsRoverTest methodsFor: 'testing' stamp: 'TF 5/12/2019 18:25:10'!
test15TurnsNorthWithoutMovingWhenPointingWestAndReceivingRightCommand
	| aRover aCommand |
	
	aRover := MarsRover at: 1@2 pointingTo: #West.
	
	aCommand := 'r'.
	
	aRover execute: aCommand .
	
	self assert: aRover isAt: 1@2  pointingAt: #North.

! !

!MarsRoverTest methodsFor: 'testing' stamp: 'TF 5/12/2019 18:25:24'!
test16ItCanProcessAndExecuteTwoCommands
	| aRover |
	
	aRover := MarsRover at: 0@0 pointingTo: #South.
	
	aRover execute: 'ff'.
	
	self assert: aRover isAt: -2@0  pointingAt: #South. 

! !

!MarsRoverTest methodsFor: 'testing' stamp: 'TF 5/12/2019 18:25:39'!
test17ItCanProcessAndExecuteManyCommandsStoppingAtFirstInvalidCommand
	| aRover |
	
	aRover := MarsRover at: 0@0 pointingTo: #South.
	
	self should: [ aRover execute: 'fllbpffffbt'] raise: Error  withMessageText: MarsRover invalidCommandErrorDescription .
	
	self assert: aRover isAt: -2@0  pointingAt: #North. 

! !


!classDefinition: #CardinalDirectionMovement category: #'IS1-MarsRover'!
Object subclass: #CardinalDirectionMovement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-MarsRover'!

!CardinalDirectionMovement methodsFor: 'movement' stamp: 'TF 5/12/2019 16:59:02'!
move
	self subclassResponsibility .! !

!CardinalDirectionMovement methodsFor: 'movement' stamp: 'TF 5/12/2019 16:59:06'!
rotateLeft
	self subclassResponsibility .! !

!CardinalDirectionMovement methodsFor: 'movement' stamp: 'TF 5/12/2019 16:59:09'!
rotateRight
	self subclassResponsibility .! !


!CardinalDirectionMovement methodsFor: 'presentation' stamp: 'TF 5/12/2019 17:07:55'!
asIdentifier
	self subclassResponsibility .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CardinalDirectionMovement class' category: #'IS1-MarsRover'!
CardinalDirectionMovement class
	instanceVariableNames: ''!

!CardinalDirectionMovement class methodsFor: 'as yet unclassified' stamp: 'TF 5/12/2019 17:06:20'!
from: aDirectionIdentifier
	aDirectionIdentifier = #North ifTrue: [^NorthMovement new.].
	aDirectionIdentifier = #East ifTrue: [^EastMovement new.].
	aDirectionIdentifier = #West ifTrue: [^WestMovement new.].
	aDirectionIdentifier = #South ifTrue: [^SouthMovement new.].
	! !


!classDefinition: #EastMovement category: #'IS1-MarsRover'!
CardinalDirectionMovement subclass: #EastMovement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-MarsRover'!

!EastMovement methodsFor: 'presentation' stamp: 'TF 5/12/2019 17:07:59'!
asIdentifier
	^#East.! !


!EastMovement methodsFor: 'movement' stamp: 'TF 5/12/2019 17:00:36'!
move
	^0@1.! !

!EastMovement methodsFor: 'movement' stamp: 'TF 5/12/2019 17:22:15'!
rotateLeft
	^NorthMovement new.! !

!EastMovement methodsFor: 'movement' stamp: 'TF 5/12/2019 17:20:05'!
rotateRight
	^SouthMovement new.! !


!classDefinition: #NorthMovement category: #'IS1-MarsRover'!
CardinalDirectionMovement subclass: #NorthMovement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-MarsRover'!

!NorthMovement methodsFor: 'presentation' stamp: 'TF 5/12/2019 17:07:20'!
asIdentifier
	^#North.! !


!NorthMovement methodsFor: 'movement' stamp: 'TF 5/12/2019 17:00:47'!
move
	^1@0.! !

!NorthMovement methodsFor: 'movement' stamp: 'TF 5/12/2019 17:03:48'!
rotateLeft
	^WestMovement new.! !

!NorthMovement methodsFor: 'movement' stamp: 'TF 5/12/2019 17:03:09'!
rotateRight
	^EastMovement new.! !


!classDefinition: #SouthMovement category: #'IS1-MarsRover'!
CardinalDirectionMovement subclass: #SouthMovement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-MarsRover'!

!SouthMovement methodsFor: 'presentation' stamp: 'TF 5/12/2019 17:07:27'!
asIdentifier
	^#South.! !


!SouthMovement methodsFor: 'movement' stamp: 'TF 5/12/2019 17:24:56'!
move
	^-1@0.! !

!SouthMovement methodsFor: 'movement' stamp: 'TF 5/12/2019 17:27:17'!
rotateLeft
	^EastMovement new.! !

!SouthMovement methodsFor: 'movement' stamp: 'TF 5/12/2019 17:28:30'!
rotateRight
	^ WestMovement new.! !


!classDefinition: #WestMovement category: #'IS1-MarsRover'!
CardinalDirectionMovement subclass: #WestMovement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-MarsRover'!

!WestMovement methodsFor: 'presentation' stamp: 'TF 5/12/2019 17:07:33'!
asIdentifier
	^#West.! !


!WestMovement methodsFor: 'movement' stamp: 'TF 5/12/2019 17:30:53'!
move
	^0@-1.! !

!WestMovement methodsFor: 'movement' stamp: 'TF 5/12/2019 17:32:24'!
rotateLeft
	^SouthMovement new.! !

!WestMovement methodsFor: 'movement' stamp: 'TF 5/12/2019 17:33:25'!
rotateRight
	^NorthMovement new.! !


!classDefinition: #MarsRover category: #'IS1-MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-MarsRover'!

!MarsRover methodsFor: 'instruction execution' stamp: 'TF 5/12/2019 18:10:12'!
execute: aListOfCommands
	
	aListOfCommands do: [:aCommand | 
		('fblr' includes: aCommand)
			ifTrue: [ self processCommand: aCommand]
			ifFalse: [ ^self error: self class invalidCommandErrorDescription.].
		].
		
	
! !

!MarsRover methodsFor: 'instruction execution' stamp: 'TF 5/12/2019 18:04:28'!
processCommand: aCommand

	(aCommand = $f) ifTrue: [position := position + direction move].
	(aCommand = $b) ifTrue: [position := position - direction move].
	(aCommand = $l) ifTrue: [direction := direction rotateLeft].
	(aCommand = $r) ifTrue: [direction := direction rotateRight].
	! !


!MarsRover methodsFor: 'accessing' stamp: 'TF 5/12/2019 17:06:57'!
direction
	^direction asIdentifier .! !

!MarsRover methodsFor: 'accessing' stamp: 'TF 5/12/2019 16:18:12'!
position
	^position .! !


!MarsRover methodsFor: 'initialization' stamp: 'TF 5/12/2019 17:02:50'!
initializeWith: aPosition and: aDirection 
	position := aPosition .
	direction := CardinalDirectionMovement from: aDirection .
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #'IS1-MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'TF 5/12/2019 18:15:01'!
at: aPosition pointingTo: aDirection 
	^self new initializeWith: aPosition and: aDirection.! !


!MarsRover class methodsFor: 'error descriptions' stamp: 'TF 5/12/2019 16:23:26'!
invalidCommandErrorDescription
	^'Cannot process invalid command'.! !
