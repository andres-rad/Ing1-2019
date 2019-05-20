!classDefinition: #IntegerReportTest category: #'Ingsoft-IntegerReports'!
TestCase subclass: #IntegerReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ingsoft-IntegerReports'!

!IntegerReportTest methodsFor: 'tests' stamp: 'HAW 5/12/2019 20:03:16'!
test01

	| lines report  integerToAnalize |
	
	integerToAnalize := 100.
	report := BasicIntegerPropertiesReport for: integerToAnalize.
	lines := ReadStream on: report value.
	
	self assert: 'Factorial: ', integerToAnalize factorial printString equals: lines next.
	self assert: 'Roman: ''', integerToAnalize printStringRoman, '''' equals: lines next.
	self assert: 'Ln: ', integerToAnalize ln printString equals: lines next.
	self assert: lines atEnd.
	
 ! !

!IntegerReportTest methodsFor: 'tests' stamp: 'HAW 5/12/2019 20:03:37'!
test02

	| lines report integerToAnalize |
	
	integerToAnalize := 200.
	report := IntegerOnDifferentBasesReport for: integerToAnalize.
	lines := ReadStream on: report value.
	
	self assert: 'Binary: ', (integerToAnalize storeStringBase: 2) equals: lines next.
	self assert: 'Octal: ', (integerToAnalize storeStringBase: 8) equals: lines next.
	self assert: 'Hexadecimal: ', (integerToAnalize storeStringBase: 16) equals: lines next.
	self assert: lines atEnd.
	
! !

!IntegerReportTest methodsFor: 'tests' stamp: 'HAW 5/12/2019 20:05:09'!
test03

	| lines report  integerToAnalize |
	
	integerToAnalize := 300.
	report := ComplexIntegerPropertiesReport for: integerToAnalize.
	lines := ReadStream on: report value.
	
	self assert: 'Prime?: ', integerToAnalize isPrime printString equals: lines next.
	self assert: 'Next Prime: ', integerToAnalize nextPrime printString equals: lines next.
	self assert: 'Sqrt: ', integerToAnalize sqrt printString equals: lines next.
	self assert: lines atEnd.
	
 ! !

!IntegerReportTest methodsFor: 'tests' stamp: 'HAW 5/12/2019 20:06:01'!
test04

	| lines report  integerToAnalize |
	
	integerToAnalize := 300.
	report := CombinedIntegerPropertiesReport for: integerToAnalize.
	self 
		shouldnt: [ lines := ReadStream on: report value ]
		takeMoreThan: 1.5*second.
		
	self assert: 'Factorial: ', integerToAnalize factorial printString equals: lines next.
	self assert: 'Roman: ''', integerToAnalize printStringRoman, '''' equals: lines next.
	self assert: 'Ln: ', integerToAnalize ln printString equals: lines next.
	self assert: 'Prime?: ', integerToAnalize isPrime printString equals: lines next.
	self assert: 'Next Prime: ', integerToAnalize nextPrime printString equals: lines next.
	self assert: 'Sqrt: ', integerToAnalize sqrt printString equals: lines next.
	self assert: lines atEnd.
	
 ! !

!IntegerReportTest methodsFor: 'tests' stamp: 'HAW 5/12/2019 20:08:26'!
test05

	| lines report  integerToAnalize |
	
	integerToAnalize := 300.
	report := CompleteIntegerReport for: integerToAnalize.
	self 
		shouldnt: [ lines := ReadStream on: report value ]
		takeMoreThan: 1.5*second.

	self assert: 'Factorial: ', integerToAnalize factorial printString equals: lines next.
	self assert: 'Roman: ''', integerToAnalize printStringRoman, '''' equals: lines next.
	self assert: 'Ln: ', integerToAnalize ln printString equals: lines next.
	self assert: 'Prime?: ', integerToAnalize isPrime printString equals: lines next.
	self assert: 'Next Prime: ', integerToAnalize nextPrime printString equals: lines next.
	self assert: 'Sqrt: ', integerToAnalize sqrt printString equals: lines next.
	self assert: 'Binary: ', (integerToAnalize storeStringBase: 2) equals: lines next.
	self assert: 'Octal: ', (integerToAnalize storeStringBase: 8) equals: lines next.
	self assert: 'Hexadecimal: ', (integerToAnalize storeStringBase: 16) equals: lines next.
	self assert: lines atEnd.
	
 ! !


!IntegerReportTest methodsFor: 'assertions' stamp: 'HAW 5/12/2019 19:20:40'!
shouldnt: aClosureToMeasure takeMoreThan: aTimeLimit

	| elapsedTime |
	
	elapsedTime :=  aClosureToMeasure timeToRun * millisecond.
	
	self assert: elapsedTime <= aTimeLimit 
	
! !


!classDefinition: #ConcurrentClosure category: #'Ingsoft-IntegerReports'!
Object subclass: #ConcurrentClosure
	instanceVariableNames: 'value semaphore'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ingsoft-IntegerReports'!

!ConcurrentClosure methodsFor: 'as yet unclassified' stamp: 'ar 5/19/2019 21:02:03'!
initializeWith: aBlock
	semaphore := Semaphore new.
	[value := aBlock value. semaphore signal] fork.! !

!ConcurrentClosure methodsFor: 'as yet unclassified' stamp: 'ar 5/19/2019 21:02:57'!
value
	semaphore wait.
	semaphore signal.
	^value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ConcurrentClosure class' category: #'Ingsoft-IntegerReports'!
ConcurrentClosure class
	instanceVariableNames: ''!

!ConcurrentClosure class methodsFor: 'as yet unclassified' stamp: 'ar 5/19/2019 21:02:24'!
withClosure: aBlock
	^self new initializeWith: aBlock.! !


!classDefinition: #IntegerReport category: #'Ingsoft-IntegerReports'!
Object subclass: #IntegerReport
	instanceVariableNames: 'integerToAnalize'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ingsoft-IntegerReports'!

!IntegerReport methodsFor: 'initialization' stamp: 'HAW 5/12/2019 19:11:29'!
initializeFor: anIntegerToAnalize

	integerToAnalize := anIntegerToAnalize ! !


!IntegerReport methodsFor: 'reporting' stamp: 'HAW 5/12/2019 19:12:35'!
value

	self subclassResponsibility ! !


!IntegerReport methodsFor: 'time consuption simulation' stamp: 'HAW 5/12/2019 19:14:02'!
wait

	(Delay forSeconds: 1) wait.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IntegerReport class' category: #'Ingsoft-IntegerReports'!
IntegerReport class
	instanceVariableNames: ''!

!IntegerReport class methodsFor: 'instance creation' stamp: 'HAW 5/12/2019 19:11:34'!
for: anIntegerToAnalize

	^self new initializeFor: anIntegerToAnalize ! !


!classDefinition: #CombinedIntegerPropertiesReport category: #'Ingsoft-IntegerReports'!
IntegerReport subclass: #CombinedIntegerPropertiesReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ingsoft-IntegerReports'!

!CombinedIntegerPropertiesReport methodsFor: 'reporting' stamp: 'ar 5/19/2019 21:19:48'!
value

	| basicPropertiesLines complexPropertiesLines lines |
	
	lines := OrderedCollection new.

	basicPropertiesLines  := ConcurrentClosure withClosure: [(BasicIntegerPropertiesReport for: integerToAnalize) value.].
	complexPropertiesLines := ConcurrentClosure withClosure: [(ComplexIntegerPropertiesReport for: integerToAnalize) value.].

	lines 
		addAll: basicPropertiesLines value;
		addAll: complexPropertiesLines value.
		
	^lines! !


!classDefinition: #CompleteIntegerReport category: #'Ingsoft-IntegerReports'!
IntegerReport subclass: #CompleteIntegerReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ingsoft-IntegerReports'!

!CompleteIntegerReport methodsFor: 'reporting' stamp: 'ar 5/19/2019 21:10:30'!
value

	| combinedPropertiesLines differentBasesLines lines semaphore|
	
	lines := OrderedCollection new.	
	semaphore := Semaphore new.
	
	[combinedPropertiesLines := (CombinedIntegerPropertiesReport for: integerToAnalize) value. semaphore signal] fork.
	[differentBasesLines := (IntegerOnDifferentBasesReport for: integerToAnalize) value. semaphore signal] fork.
	
	semaphore wait; wait.
	lines
		addAll: combinedPropertiesLines;
		addAll: differentBasesLines.
		
	^lines! !


!classDefinition: #IntegerOnDifferentBasesReport category: #'Ingsoft-IntegerReports'!
IntegerReport subclass: #IntegerOnDifferentBasesReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ingsoft-IntegerReports'!

!IntegerOnDifferentBasesReport methodsFor: 'reporting - private' stamp: 'HAW 5/12/2019 20:04:56'!
addNumberInBase: aBase to: lines title: aTitle

	lines add: aTitle, ': ', (integerToAnalize storeStringBase: aBase).
	
	! !


!IntegerOnDifferentBasesReport methodsFor: 'reporting' stamp: 'HAW 5/12/2019 20:04:08'!
value

	| lines |
	
	self wait.
	lines := OrderedCollection new.
	self 
		addNumberInBase: 2 to: lines title: 'Binary';
		addNumberInBase: 8 to: lines title: 'Octal';
		addNumberInBase: 16 to: lines title: 'Hexadecimal'.
		
	^lines! !


!classDefinition: #IntegerPropertiesReport category: #'Ingsoft-IntegerReports'!
IntegerReport subclass: #IntegerPropertiesReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ingsoft-IntegerReports'!

!IntegerPropertiesReport methodsFor: 'reporting - private' stamp: 'HAW 5/12/2019 20:02:54'!
addLineTo: lines title: aTitle with: anIntegerClosure

	lines add: aTitle, ': ', anIntegerClosure value printString
! !


!classDefinition: #BasicIntegerPropertiesReport category: #'Ingsoft-IntegerReports'!
IntegerPropertiesReport subclass: #BasicIntegerPropertiesReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ingsoft-IntegerReports'!

!BasicIntegerPropertiesReport methodsFor: 'reporting' stamp: 'HAW 5/12/2019 20:02:09'!
value

	| lines |
	
	self wait.
	lines := OrderedCollection new.
	self 
		addLineTo: lines title: 'Factorial' with: [ integerToAnalize factorial ];
		addLineTo: lines title: 'Roman' with: [ integerToAnalize printStringRoman ];
		addLineTo: lines title: 'Ln' with: [ integerToAnalize ln ].
		
	^lines! !


!classDefinition: #ComplexIntegerPropertiesReport category: #'Ingsoft-IntegerReports'!
IntegerPropertiesReport subclass: #ComplexIntegerPropertiesReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ingsoft-IntegerReports'!

!ComplexIntegerPropertiesReport methodsFor: 'reporting' stamp: 'HAW 5/12/2019 20:05:39'!
value

	| lines |
	
	self wait.
	lines := OrderedCollection new.
	self 
		addLineTo: lines title: 'Prime?' with: [ integerToAnalize isPrime ];
		addLineTo: lines title: 'Next Prime' with: [ integerToAnalize nextPrime ];
		addLineTo: lines title: 'Sqrt' with: [ integerToAnalize sqrt ].
		
	^lines! !
