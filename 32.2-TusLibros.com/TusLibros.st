!classDefinition: #CardTest category: #TusLibros!
TestCase subclass: #CardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CardTest methodsFor: 'tests' stamp: 'atr 6/9/2019 21:29:36'!
test01CannotCreateCardWithNonDigitsInItsNumber
	self
		should: [Card withNumber: '12341234123412E4' ownerName: 'Wilk inson'  expiringOn: (February of: 2019)] 
		raise: Error - MessageNotUnderstood 
		withMessageText: Card invalidCardNumberErrorDescription.
	

	
	! !

!CardTest methodsFor: 'tests' stamp: 'atr 6/9/2019 21:30:15'!
test02CannotCreateCardWithoutSixteenDigits
	self
		should: [Card withNumber: '123412341234123' ownerName: 'Wilk inson'  expiringOn: (February of: 2019)] 
		raise: Error - MessageNotUnderstood 
		withMessageText: Card invalidCardNumberLengthErrorDescription.
	

	
	! !

!CardTest methodsFor: 'tests' stamp: 'TF 6/10/2019 15:16:07'!
test03CannotCreateCardWithEmptyStringAsOwner
	self
		should: [Card withNumber: '1234123412341234' ownerName: ''  expiringOn: (February of: 2019)] 
		raise: Error - MessageNotUnderstood 
		withMessageText: Card emptyNameErrorDescription.
	

	
	! !

!CardTest methodsFor: 'tests' stamp: 'TF 6/10/2019 15:16:13'!
test04CannotCreateCardWithInvalidOwnerNameLength
	self
		should: [Card withNumber: '1234123412341234' ownerName: 'gvjafldghsruithskgjlhsfdugiashugilhfdjkraehlutiaerhdgkhasdfuighsruiglshuif'  expiringOn: (February of: 2019)] 
		raise: Error - MessageNotUnderstood 
		withMessageText: Card tooLongNameErrorDescription
.
	

	
	! !

!CardTest methodsFor: 'tests' stamp: 'atr 6/9/2019 21:31:19'!
test05ACreditCardKnowsWhenItIsExpired
	| aCard |
	
	aCard := Card withNumber: '1234123412341234' ownerName: 'Wilk Inson'  expiringOn: (February of: 2019).
	
	self assert: (aCard isExpiredOn: (March of: 2019)).
	

	
	! !

!CardTest methodsFor: 'tests' stamp: 'atr 6/9/2019 21:32:11'!
test06ACreditCardKnowsWhenItIsNotExpired
	| aCard |
	
	aCard := Card withNumber: '1234123412341234' ownerName: 'Wilk Inson'  expiringOn: (February of: 2019).
	
	self deny: (aCard isExpiredOn: (January of: 2019)).
	

	
	! !


!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 0 of: self itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 2 of: self itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self assert: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: 2 of: self itemSellByTheStore.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !

!CartTest methodsFor: 'tests' stamp: 'atr 6/9/2019 19:48:32'!
test09CannotCreateCartWithACatalogWithNonPositivePrices

	| aCatalog  |
	
	aCatalog := Dictionary new at: 'invalidePricedBookd' put: 0; yourself. 
	
	self 
		should: [Cart acceptingItemsOf: aCatalog ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidIPricedCatalogErrorMessage]
	! !

!CartTest methodsFor: 'tests' stamp: 'atr 6/9/2019 21:09:20'!
test10AnEmptyCartContentsValueIsZero

	| aCart aCatalog  |

	aCatalog := Dictionary new at: 'invalidePricedBookd' put: 10; yourself. 
	aCart := Cart acceptingItemsOf: aCatalog.

	self assert: aCart contentsValue equals: 0.	! !

!CartTest methodsFor: 'tests' stamp: 'atr 6/9/2019 21:10:38'!
test11TheValueOfTheContentsInTheCarIsTheSumOfEachOne

	| aCart aCatalog  |

	aCatalog := Dictionary new at: 'pricedBook' put: 10; yourself. 
	aCart := Cart acceptingItemsOf: aCatalog.
	aCart add: 10 of: 'pricedBook'.
	 
	self assert: aCart contentsValue equals: 100.	! !


!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'atr 6/9/2019 19:43:47'!
defaultCatalog
	
	^ Dictionary new at: self itemSellByTheStore put: 10; yourself.! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:44'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
itemSellByTheStore
	
	^ 'validBook'! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'support' stamp: 'atr 6/9/2019 21:03:56'!
alwaysExpiredCreditCard
	^ Card withNumber: '1234123412341234'
			ownerName: 'Martes' 
			expiringOn: FixedGregorianDate theBeginningOfTime monthOfYear.! !

!CashierTest methodsFor: 'support' stamp: 'atr 6/9/2019 21:03:46'!
neverExpiredCreditCard
	^ Card withNumber: '1234123412341234'
			ownerName: 'Martes'
			expiringOn: FixedGregorianDate theEndOfTime monthOfYear.! !


!CashierTest methodsFor: 'tests' stamp: 'atr 6/9/2019 21:40:19'!
test01NoPuedoHacerCheckoutConUnaTarjetaVencida
	| cashier cart aCatalog |
	
	aCatalog := Dictionary new.
	aCatalog at: 'cheapBook' put: 3.
	aCatalog at: 'expensiveBook' put: 400.
	
	cart := Cart acceptingItemsOf: aCatalog.
	cart add: 'cheapBook'.
	cashier := Cashier withCart: cart andMerchantProcessor: MerchantInnerInterfaceSimulator new.
	
	self should: [ cashier checkoutWith: self alwaysExpiredCreditCard ] 
		raise: Error - MessageNotUnderstood  
		withExceptionDo: [:anError |
			self assert: anError messageText equals: 'Tarjeta vencida']. 
	
	
	! !

!CashierTest methodsFor: 'tests' stamp: 'atr 6/9/2019 21:40:54'!
test02NoPuedoHacerCheckoutConUnCarritoVacio
	| cashier cart aCatalog |
	
	aCatalog := Dictionary new.
	aCatalog at: 'cheapBook' put: 3.
	aCatalog at: 'expensiveBook' put: 400.
	
	cart := Cart acceptingItemsOf: aCatalog.
	cashier := Cashier withCart: cart andMerchantProcessor: MerchantInnerInterfaceSimulator new.

	self should: [ cashier checkoutWith: self neverExpiredCreditCard ] 
		raise: Error - MessageNotUnderstood  
		withExceptionDo: [:anError |
			self assert: anError messageText equals: 'No se puede hacer checkout de un carrito vacio']. 
	
	
	! !

!CashierTest methodsFor: 'tests' stamp: 'atr 6/9/2019 22:28:42'!
test03DespuesDeHacerUnCheckoutLlosPagosProcesadosEquivalenAlValorDeLaTransferencia
	| cashier cart aCatalog aMerchantProcessor |
	
	aCatalog := Dictionary new.
	aCatalog at: 'cheapBook' put: 3.
	aCatalog at: 'expensiveBook' put: 400.
	
	cart := Cart acceptingItemsOf: aCatalog.
	cart add: 3 of: 'cheapBook'.
	cart add: 10 of: 'expensiveBook'.
	
	aMerchantProcessor := MerchantInnerInterfaceSimulator new.
	 
	cashier := Cashier withCart: cart andMerchantProcessor: aMerchantProcessor .

	cashier checkoutWith: self neverExpiredCreditCard.
	
	self assert: aMerchantProcessor totalTransactionsValue equals: 4009.
	
	
	! !


!classDefinition: #Card category: #TusLibros!
Object subclass: #Card
	instanceVariableNames: 'cardNumber ownerName expirationDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Card methodsFor: 'testing' stamp: 'atr 6/9/2019 20:25:47'!
isExpiredOn: aMonthOfYear 
	^expirationDate < aMonthOfYear .! !


!Card methodsFor: 'initialization' stamp: 'atr 6/9/2019 20:26:25'!
initializeWithNumber: aCardNumber ownerName: aName expiringOn: anExpirationDate 
	cardNumber := aCardNumber .
	ownerName := aName .
	expirationDate := anExpirationDate .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Card class' category: #TusLibros!
Card class
	instanceVariableNames: ''!

!Card class methodsFor: 'assertions' stamp: 'atr 6/9/2019 20:20:57'!
assertValidCardNumber: aCardNumber

	(aCardNumber size = 16) ifFalse: [self error: self invalidCardNumberLengthErrorDescription ].
	(aCardNumber allSatisfy: [:aChar | aChar isDigit ]) ifFalse: [self error: self invalidCardNumberErrorDescription].! !

!Card class methodsFor: 'assertions' stamp: 'atr 6/9/2019 21:33:45'!
assertValidName: aName

	aName size strictlyPositive ifFalse: [self error: self emptyNameErrorDescription ].
	aName size > 30 ifTrue: [self error: self tooLongNameErrorDescription ].
! !


!Card class methodsFor: 'instance creation' stamp: 'atr 6/9/2019 20:23:19'!
withNumber: aCardNumber ownerName: aName expiringOn: anExpirationDate 

	self assertValidCardNumber: aCardNumber .
	self assertValidName: aName .
	
	^ self new initializeWithNumber: aCardNumber ownerName: aName expiringOn: anExpirationDate .! !


!Card class methodsFor: 'errors' stamp: 'atr 6/9/2019 20:22:13'!
emptyNameErrorDescription
	^'El nombre no debe ser vacio'.! !

!Card class methodsFor: 'errors' stamp: 'atr 6/9/2019 20:14:22'!
invalidCardNumberErrorDescription
	^'Numero de tarjeta invalido'.! !

!Card class methodsFor: 'errors' stamp: 'atr 6/9/2019 20:18:37'!
invalidCardNumberLengthErrorDescription
	^'El numero de la tarjeta debe tener 16 digitos'.! !

!Card class methodsFor: 'errors' stamp: 'atr 6/9/2019 21:34:08'!
tooLongNameErrorDescription
	^'El nombre no debe exceder los 30 caracteres'.! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'atr 6/9/2019 19:42:46'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'atr 6/9/2019 21:19:02'!
contentsValue
	^items sum: [:aBook | catalog at: aBook] ifEmpty: 0.! !

!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'atr 6/9/2019 19:55:37'!
acceptingItemsOf: aCatalog

	self assertCatalogPricesAreValid: aCatalog .

	^self new initializeAcceptingItemsOf: aCatalog ! !


!Cart class methodsFor: 'errors' stamp: 'atr 6/9/2019 19:49:15'!
invalidIPricedCatalogErrorMessage
	^'The Catalog has  invalid prices'.! !


!Cart class methodsFor: 'assertions' stamp: 'atr 6/9/2019 19:56:33'!
assertCatalogPricesAreValid: aCatalog
	(aCatalog allSatisfy: [:aPrice | aPrice strictlyPositive]) ifFalse: [self error: self invalidIPricedCatalogErrorMessage ].! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'catalog cart processor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checking out' stamp: 'atr 6/9/2019 21:52:08'!
checkoutWith: aCard
	self assertCardIsNotExpired: aCard.
	self assertCartIsNotEmpty.
	
	processor processTransactionOf: cart contentsValue to: aCard.! !


!Cashier methodsFor: 'initialization' stamp: 'atr 6/9/2019 21:39:27'!
initializeWith: aCart andMerchantProcessor: aMerchantProcessor 
	cart := aCart.
	processor := aMerchantProcessor.! !


!Cashier methodsFor: 'assertions' stamp: 'atr 6/9/2019 20:36:25'!
assertCardIsNotExpired: aCard 
	(aCard isExpiredOn: GregorianMonthOfYear current) ifTrue: [ self error: self class expiredCardErrorMessage].! !

!Cashier methodsFor: 'assertions' stamp: 'atr 6/9/2019 20:54:42'!
assertCartIsNotEmpty
	(cart isEmpty) ifTrue: [self error: self class emptyCartErrorMessage].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'atr 6/9/2019 21:41:24'!
withCart: aCart andMerchantProcessor: aMerchantProcessor 
	^self new initializeWith: aCart andMerchantProcessor: aMerchantProcessor.! !


!Cashier class methodsFor: 'errors' stamp: 'atr 6/9/2019 20:53:38'!
emptyCartErrorMessage
	^'No se puede hacer checkout de un carrito vacio'.! !

!Cashier class methodsFor: 'errors' stamp: 'atr 6/9/2019 20:37:17'!
expiredCardErrorMessage
	^'Tarjeta vencida'.! !


!classDefinition: #MerchantInnerInterfaceSimulator category: #TusLibros!
Object subclass: #MerchantInnerInterfaceSimulator
	instanceVariableNames: 'totalTransactionsValue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantInnerInterfaceSimulator methodsFor: 'initialization' stamp: 'atr 6/9/2019 21:48:18'!
initialize
	totalTransactionsValue := 0.! !


!MerchantInnerInterfaceSimulator methodsFor: 'process' stamp: 'atr 6/9/2019 21:48:07'!
processTransactionOf: anAmount to: aCard
	totalTransactionsValue := totalTransactionsValue + anAmount .! !


!MerchantInnerInterfaceSimulator methodsFor: 'queries' stamp: 'atr 6/9/2019 21:48:31'!
totalTransactionsValue 
	^totalTransactionsValue .! !
