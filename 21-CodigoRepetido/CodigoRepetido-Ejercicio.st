!classDefinition: #CantSuspend category: #'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: #'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: #'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testingUtilities' stamp: 'ar 4/8/2019 16:04:28'!
assertBlock: aBlock doesNotTakeMoreThan: someMilliseconds

	| millisecondsBeforeRunning millisecondsAfterRunning |
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aBlock value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < someMilliseconds
	
! !

!CustomerBookTest methodsFor: 'testingUtilities' stamp: 'ar 4/8/2019 16:15:46'!
assertBlock: aBlock failsOnError: anError andCompliesWith: anAssertingBlock
	
	[ aBlock value.
	self fail ]
		on: anError 
		do: anAssertingBlock
! !

!CustomerBookTest methodsFor: 'testingUtilities' stamp: 'ar 4/8/2019 16:22:15'!
assertCustomerBook: aCustomerBook hasActiveCustomers: numActiveCustomers andHasSuspendedCustomers: numSuspendedCustomers
	
	self assert: numActiveCustomers equals: aCustomerBook numberOfActiveCustomers.
	self assert: numSuspendedCustomers equals: aCustomerBook numberOfSuspendedCustomers.
	self assert: numActiveCustomers + numSuspendedCustomers equals: aCustomerBook numberOfCustomers.



	
! !

!CustomerBookTest methodsFor: 'testingUtilities' stamp: 'ar 4/8/2019 16:27:04'!
customerBookWithName: aName
	|customerBook|
	customerBook := CustomerBook new.
	customerBook addCustomerNamed: aName.
	^customerBook.


	
! !


!CustomerBookTest methodsFor: 'testing' stamp: 'ar 4/8/2019 16:04:55'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
	
	self assertBlock: [ customerBook addCustomerNamed: 'John Lennon'] doesNotTakeMoreThan: 50 * millisecond .
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'ar 4/8/2019 16:31:42'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	paulMcCartney := 'Paul McCartney'.
	customerBook := CustomerBook with: paulMcCartney.
	
	self assertBlock: [ customerBook removeCustomerNamed: paulMcCartney] doesNotTakeMoreThan: 100 * millisecond .
	! !

!CustomerBookTest methodsFor: 'testing' stamp: 'ar 4/8/2019 16:20:28'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.
		
	self assertBlock: [ customerBook addCustomerNamed: ''.] 
		failsOnError: Error 
		andCompliesWith: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]
	! !

!CustomerBookTest methodsFor: 'testing' stamp: 'ar 4/8/2019 16:31:25'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	johnLennon := 'John Lennon'.
	customerBook := CustomerBook with: johnLennon.
	
	self assertBlock: [ customerBook removeCustomerNamed: 'Paul McCartney'. ] 
		failsOnError: NotFound 
		andCompliesWith: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'ar 4/8/2019 16:31:16'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	paulMcCartney := 'Paul McCartney'.	
	customerBook := CustomerBook with: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	
	self assertCustomerBook: customerBook hasActiveCustomers: 0 andHasSuspendedCustomers: 1.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'ar 4/8/2019 16:31:02'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	paulMcCartney := 'Paul McCartney'.
	
	customerBook := CustomerBook with: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assertCustomerBook: customerBook hasActiveCustomers: 0 andHasSuspendedCustomers: 0.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'ar 4/8/2019 16:30:47'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	johnLennon := 'John Lennon'.
	customerBook := CustomerBook with: johnLennon .
	
	self assertBlock: [ customerBook suspendCustomerNamed: 'Paul McCartney'. ] 
		failsOnError: CantSuspend 
		andCompliesWith: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
		
		
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'ar 4/8/2019 16:30:31'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	johnLennon := 'John Lennon'.
	customerBook := CustomerBook with: johnLennon .
	customerBook suspendCustomerNamed: johnLennon.
	
	self assertBlock: [ customerBook suspendCustomerNamed: johnLennon. ] 
		failsOnError: CantSuspend 
		andCompliesWith: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
	
	
! !


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 4/3/2019 10:14:26'!
initialize

	super initialize.
	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'ar 4/8/2019 15:56:07'!
addCustomerNamed: aName

	aName ifEmpty: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName ) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'ar 4/8/2019 15:36:15'!
numberOfCustomers
	
	^self numberOfActiveCustomers  + self  numberOfSuspendedCustomers.! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'ar 4/8/2019 15:53:28'!
removeCustomerNamed: aName 
	^ active remove: aName ifAbsent: [
		suspended remove: aName ifAbsent: [
			NotFound signal .
			]
		]
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'ar 4/8/2019 15:54:59'!
suspendCustomerNamed: aName 
	
	active remove: aName ifAbsent: [^CantSuspend signal ].
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/3/2019 10:16:22'!
customerAlreadyExistsErrorMessage

	^'Customer Already Exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/3/2019 10:16:31'!
customerCanNotBeEmptyErrorMessage

	^'Customer Name Cannot Be Empty'! !


!CustomerBook class methodsFor: 'instantiation' stamp: 'ar 4/8/2019 16:30:01'!
with: aName
	|customerBook|
	customerBook := self new.
	customerBook addCustomerNamed: aName.
	^customerBook.! !
