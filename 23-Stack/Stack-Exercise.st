!classDefinition: #OOStackTest category: #'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:31'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/8/2012 08:20'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:33'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'First'.
	secondPushedObject := 'Second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:35'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:36'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:36'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: #'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'utilities' stamp: 'TF 4/22/2019 16:07:20'!
aStackCreator
	"Provides a sample stack meant for testing"
	"It is guaranteed that this stack contains only sentences starting only with characters in [a..g], lower and upper case"

	| aStack |
	
	aStack := OOStack new.
	aStack push: 'abc'.
	aStack push: 'abcde'.
	aStack push: 'acc'.
	aStack push: 'ghc rules'.
	aStack push: 'Dont know what else to write'.
	aStack push: 'A girl has secrets'.
	aStack push: 'abc'.
	
	^aStack.! !

!SentenceFinderByPrefixTest methodsFor: 'utilities' stamp: 'TF 4/22/2019 15:43:59'!
anEmptyStackCreator
	"Provides a sample stack meant for testing"

	| aStack |
	
	aStack := OOStack new.
	
	^aStack.! !

!SentenceFinderByPrefixTest methodsFor: 'utilities' stamp: 'TF 4/22/2019 15:34:20'!
hasEqualElements: aStack than: anotherStack
	"This is an utility method meant for testing, it destroys both stacks"
	(aStack size = anotherStack size) ifFalse: [^false].
	
	[aStack isEmpty] whileFalse: [
		(aStack pop = anotherStack pop) ifFalse: [^false].
	].

	^true.! !

!SentenceFinderByPrefixTest methodsFor: 'utilities' stamp: 'TF 4/22/2019 15:57:40'!
running: aBlockToRun shouldRaise: anExceptionType asserting: aVerificationBlock

	[ aBlockToRun value. self fail.]
		on: anExceptionType 
		do: aVerificationBlock.
	! !


!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'TF 4/22/2019 16:11:58'!
test01StackShouldntChange

	| stack backUpStack |
	
	stack := self aStackCreator .
	
	backUpStack := self aStackCreator .
	
	SentenceFinderByPrefix find: 'a' on: stack. 
	
	self assert: (self hasEqualElements: stack than: backUpStack).! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'TF 4/22/2019 15:45:05'!
test02AcceptsEmptyStack

	| stack  |
	
	stack := self anEmptyStackCreator .
	
	SentenceFinderByPrefix find: 'b' on: stack. 
	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'TF 4/22/2019 16:11:00'!
test03FindsRepeated

	| stack filteredStack repeatedSentence |
	
	repeatedSentence := 'This will appear more than once'.
	
	stack := self aStackCreator .
	stack push: repeatedSentence.
	stack push: 'Intermezzo'.
	stack push: repeatedSentence.
	stack push: 'in the middle of it all'.
	stack push: repeatedSentence.
	
	filteredStack := SentenceFinderByPrefix find: 'This' on: stack. 
	self assert: filteredStack size equals: 3.
	[filteredStack isEmpty ] whileFalse: [self assert: filteredStack pop equals: repeatedSentence].

	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'TF 4/22/2019 16:01:16'!
test04FindsOnlyWithCaseSensitive

	| stack filteredStack |
	
	stack := self anEmptyStackCreator .
	stack push: 'This one'.
	stack push: 'tHIs one not'.
	stack push: 'this one not'.
	stack push: 'THIS one not'.
	
	filteredStack := SentenceFinderByPrefix find: 'This' on: stack. 
	self assert: filteredStack size equals: 1. 
	self assert: filteredStack pop equals: 'This one'.
	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'TF 4/22/2019 15:56:57'!
test05FailsOnEmptyPrefix

	| stack  |
	
	stack := self aStackCreator.
	
	self running: [SentenceFinderByPrefix find: '' on: stack]
	 	shouldRaise: Error 
		asserting: [ :anError | self assert: anError messageText equals: SentenceFinderByPrefix prefixCannotBeEmptyErrorDescription ].
	 
	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'TF 4/22/2019 15:58:33'!
test06FailsOnPrefixWithSpaces

	| stack  |
	
	stack := self aStackCreator.
	
	self running: [SentenceFinderByPrefix find: 'dany i am your niece' on: stack]
	 	shouldRaise: Error 
		asserting: [ :anError | self assert: anError messageText equals: SentenceFinderByPrefix prefixCannotHaveSpacesErrorDescription ].
	 
	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'TF 4/22/2019 16:11:53'!
test07ReturnsEmptyStackForEmptyStack

	| stack filteredStack |
	
	stack := self anEmptyStackCreator .
	
	filteredStack := SentenceFinderByPrefix find: 'a' on: stack. 
	self assert: filteredStack isEmpty .
	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'TF 4/22/2019 16:19:12'!
test08ReturnsEmptyStackForNonAppearingPrefix

	| stack filteredStack |
	
	stack := self aStackCreator .
	
	filteredStack := SentenceFinderByPrefix find: 'ImPrettySureThisOneDoesntAppearSinceItStartsWithI' on: stack. 
	self assert: filteredStack isEmpty .
	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'TF 4/22/2019 16:13:20'!
test09StackCanContainEmptySentences

	| stack filteredStack |
	
	stack := self aStackCreator .
	stack push: ''.
	stack push: 'Only this will appear'.
	stack push: ''.
	
	filteredStack := SentenceFinderByPrefix find: 'Onl' on: stack. 
	self assert: filteredStack size equals: 1 .
	self assert: filteredStack pop equals:  'Only this will appear'.
	! !


!classDefinition: #ChainedValues category: #'Stack-Exercise'!
Object subclass: #ChainedValues
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!ChainedValues methodsFor: 'as yet unclassified' stamp: 'TF 4/21/2019 10:02:38'!
countChain
	self subclassResponsibility .! !

!ChainedValues methodsFor: 'as yet unclassified' stamp: 'TF 4/21/2019 09:43:48'!
next
	self subclassResponsibility .! !

!ChainedValues methodsFor: 'as yet unclassified' stamp: 'TF 4/21/2019 09:44:00'!
value
	self subclassResponsibility .! !


!classDefinition: #EmptyChainedValue category: #'Stack-Exercise'!
ChainedValues subclass: #EmptyChainedValue
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!EmptyChainedValue methodsFor: 'as yet unclassified' stamp: 'TF 4/21/2019 10:02:51'!
countChain
	^0.! !

!EmptyChainedValue methodsFor: 'as yet unclassified' stamp: 'TF 4/21/2019 11:51:51'!
next
	^self error: OOStack stackEmptyErrorDescription .! !

!EmptyChainedValue methodsFor: 'as yet unclassified' stamp: 'TF 4/21/2019 11:51:56'!
value
	^self error: OOStack stackEmptyErrorDescription .! !


!classDefinition: #FilledChainedValue category: #'Stack-Exercise'!
ChainedValues subclass: #FilledChainedValue
	instanceVariableNames: 'element nextStackElement'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!FilledChainedValue methodsFor: 'initialization' stamp: 'TF 4/21/2019 09:53:01'!
initializeWithValue: aValue andNext: nextStackedElement
	nextStackElement := nextStackedElement. 
	element := aValue.
	! !


!FilledChainedValue methodsFor: 'accesing' stamp: 'TF 4/21/2019 10:03:07'!
countChain
	^1 + nextStackElement countChain .! !

!FilledChainedValue methodsFor: 'accesing' stamp: 'TF 4/21/2019 09:45:34'!
next
	^nextStackElement .! !

!FilledChainedValue methodsFor: 'accesing' stamp: 'TF 4/21/2019 09:45:41'!
value
	^element .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FilledChainedValue class' category: #'Stack-Exercise'!
FilledChainedValue class
	instanceVariableNames: ''!

!FilledChainedValue class methodsFor: 'instance creation' stamp: 'TF 4/22/2019 16:15:43'!
withValue: aValue andNextElement: nextStackElement
	| newStackElement |
	newStackElement := FilledChainedValue new initializeWithValue: aValue andNext:  nextStackElement .
	^newStackElement .
! !


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'topElement'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'initialization' stamp: 'TF 4/22/2019 16:15:02'!
initialize
	topElement := EmptyChainedValue new.! !


!OOStack methodsFor: 'accessing' stamp: 'TF 4/21/2019 10:03:24'!
isEmpty
	^self size = 0.! !

!OOStack methodsFor: 'accessing' stamp: 'TF 4/21/2019 10:44:21'!
pop
	| topValue |
	topValue := self top.
	topElement := topElement next .
	^topValue.! !

!OOStack methodsFor: 'accessing' stamp: 'TF 4/22/2019 16:15:43'!
push: anElement
	| newTopElement |
	newTopElement := FilledChainedValue withValue: anElement andNextElement: topElement .
	topElement := newTopElement .
! !

!OOStack methodsFor: 'accessing' stamp: 'TF 4/21/2019 10:02:21'!
size
	^topElement countChain.! !

!OOStack methodsFor: 'accessing' stamp: 'TF 4/21/2019 10:43:42'!
top
	^topElement value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!classDefinition: #SentenceFinderByPrefix category: #'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: #'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'private' stamp: 'TF 4/22/2019 15:54:02'!
checkPrefixPreConditions: aPrefix
	"El prefijo es case sensitive, no puede ser vacío, ni contener espacios vacíos y el Stack al terminar la operación de búsqueda debe de mantener las mismas oraciones en idéntico orden"
	
	(aPrefix includesSubString: ' ') ifTrue: [self error: self prefixCannotHaveSpacesErrorDescription ].
	(aPrefix isEmpty) ifTrue: [self error: self prefixCannotBeEmptyErrorDescription ].
	
	! !

!SentenceFinderByPrefix class methodsFor: 'private' stamp: 'TF 4/22/2019 15:12:29'!
forEachElementIn: aStack do: aBlock
	"applies aBlock to each element of aStack. aStack is empty after the operation"

	[aStack isEmpty] whileFalse: [aBlock value: aStack pop].! !


!SentenceFinderByPrefix class methodsFor: 'public' stamp: 'TF 4/22/2019 16:17:25'!
find: aPrefix on: aStackOfSentences
	| filteredStack copyStack |
	
	self checkPrefixPreConditions: aPrefix.
	
	filteredStack  := OOStack new.
	copyStack  := OOStack new.
	self forEachElementIn: aStackOfSentences do:  [
		:anElement |
		copyStack push: anElement .
	].
	
	self forEachElementIn: copyStack do: [
		:anElement |
		aStackOfSentences push: anElement.
		(anElement beginsWith: aPrefix) ifTrue: [filteredStack push: anElement].
	].

	^filteredStack .! !


!SentenceFinderByPrefix class methodsFor: 'error' stamp: 'TF 4/22/2019 15:52:28'!
prefixCannotBeEmptyErrorDescription
	^'The prefix should not be empty'! !

!SentenceFinderByPrefix class methodsFor: 'error' stamp: 'TF 4/22/2019 15:52:45'!
prefixCannotHaveSpacesErrorDescription
	^'The prefix should not include any spaces'! !
