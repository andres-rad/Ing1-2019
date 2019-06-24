!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !

!CartTest methodsFor: 'tests' stamp: 'TF 6/22/2019 16:50:09'!
test09CartRemembersItsOwner

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self assert: cart owner = 'validUser'.! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:50'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:04'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:00'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:59'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #TusLibrosInnerInterfaceTest category: #TusLibros!
TestCase subclass: #TusLibrosInnerInterfaceTest
	instanceVariableNames: 'testObjects interface salesBook clock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosInnerInterfaceTest methodsFor: 'testing' stamp: 'TF 6/22/2019 13:36:36'!
test01PuedoCrearCarritoParaUsuarioYContrasenaValidos
	self shouldnt: [interface createCartFor: self validUser with: self validPassword ] raise: Error.! !

!TusLibrosInnerInterfaceTest methodsFor: 'testing' stamp: 'TF 6/22/2019 13:36:36'!
test02NoPuedoCrearCarritoParaUsuarioInvalido
	self should: [interface createCartFor: self invalidUser with: self validPassword ] 
		raise: Error - MessageNotUnderstood 
		withMessageText: TusLibrosInnerInterface invalidUserOrPasswordErrorDescription .
! !

!TusLibrosInnerInterfaceTest methodsFor: 'testing' stamp: 'TF 6/22/2019 13:36:36'!
test03NoPuedoCrearCarritoConContrasenaInvalida
	self should: [interface createCartFor: self validUser with: self invalidPassword ] 
		raise: Error - MessageNotUnderstood 
		withMessageText: TusLibrosInnerInterface invalidUserOrPasswordErrorDescription .
! !

!TusLibrosInnerInterfaceTest methodsFor: 'testing' stamp: 'TF 6/22/2019 14:01:59'!
test04CrearUnCarritoLoCreaVacio
	| cartId |
	
	cartId := interface createCartFor: self validUser with: self validPassword.
	
	self assert: (interface listCartWithId: cartId) isEmpty.! !

!TusLibrosInnerInterfaceTest methodsFor: 'testing' stamp: 'TF 6/22/2019 14:02:17'!
test05AlAgregarLibrosAUnCarritoAparecenEnSuListado
	| cartId |
	
	cartId := interface createCartFor: self validUser with: self validPassword.
	
	interface add: 10 of: testObjects itemSellByTheStore toCartWithId: cartId.
	
	self assert: ((interface listCartWithId: cartId) occurrencesOf: testObjects itemSellByTheStore) equals: 10.! !

!TusLibrosInnerInterfaceTest methodsFor: 'testing' stamp: 'TF 6/22/2019 14:13:17'!
test06PuedoTenerMasDeUnCarritoEnEstadosDiferentes
	| cartId otherCartId |
	
	cartId := interface createCartFor: self validUser with: self validPassword.
	otherCartId := interface createCartFor: self otherValidUser with: self otherValidPassword .
	
	interface add: 10 of: testObjects itemSellByTheStore toCartWithId: cartId.
	
	self assert: ((interface listCartWithId: cartId) occurrencesOf: testObjects itemSellByTheStore) equals: 10.
	self assert: (interface listCartWithId: otherCartId) isEmpty .! !

!TusLibrosInnerInterfaceTest methodsFor: 'testing' stamp: 'TF 6/22/2019 14:03:01'!
test07NoPuedoListarLosContenidosDeUnIdDeCarritoInvalido
	
	self should: [interface listCartWithId: nil] 
		raise: Error  - MessageNotUnderstood 
		withMessageText: TusLibrosInnerInterface invalidCartIdErrorDescription.! !

!TusLibrosInnerInterfaceTest methodsFor: 'testing' stamp: 'TF 6/22/2019 14:03:13'!
test08NoPuedoAgregarLibrosAUnIdDeCarritoInvalido
	
	self should: [interface add: 2 of: testObjects itemSellByTheStore toCartWithId: nil ] 
		raise: Error  - MessageNotUnderstood 
		withMessageText: TusLibrosInnerInterface invalidCartIdErrorDescription.! !

!TusLibrosInnerInterfaceTest methodsFor: 'testing' stamp: 'TF 6/24/2019 10:46:53'!
test09NoPuedoHacerCheckoutDeUnCarritoVacio

	| cartId |
	
	cartId := interface createCartFor: self validUser with: self validPassword .
	
	
	self should: [interface checkOutCartWithId: cartId 
							creditCardNumber: '1234123412341234' 
							expirationDay: testObjects notExpiredMonthOfYear 
							holderName: 'Teodoro Freund'] 
		raise: Error  - MessageNotUnderstood 
		withMessageText: Cashier cartCanNotBeEmptyErrorMessage .! !

!TusLibrosInnerInterfaceTest methodsFor: 'testing' stamp: 'TF 6/24/2019 10:46:46'!
test09bNoPuedoHacerCheckoutDeUnCarritoIdInvalido


	
	self should: [interface checkOutCartWithId: nil 
							creditCardNumber: '1234123412341234' 
							expirationDay: testObjects notExpiredMonthOfYear 
							holderName: 'Teodoro Freund'] 
		raise: Error  - MessageNotUnderstood 
		withMessageText: TusLibrosInnerInterface invalidCartIdErrorDescription .! !

!TusLibrosInnerInterfaceTest methodsFor: 'testing' stamp: 'TF 6/24/2019 10:00:45'!
test10AlHacerCheckoutLaVentaSeRegistraEnElSalesbook

	| cartId |
	
	cartId := interface createCartFor: self validUser with: self validPassword .
	
	interface add: 2 of: testObjects itemSellByTheStore toCartWithId: cartId .
	
	
	interface checkOutCartWithId: cartId 
			creditCardNumber: '1111222233334444' 
			expirationDay: testObjects notExpiredMonthOfYear 
			holderName: 'Teodoro Freund'.
			
	self assert: salesBook size equals: 1.
	self assert: (salesBook sum: [:aSale | aSale total]) equals: (2*testObjects itemSellByTheStorePrice) .
! !

!TusLibrosInnerInterfaceTest methodsFor: 'testing' stamp: 'TF 6/24/2019 11:04:51'!
test11LaInterfazListaParaUnUsuarioLasComprasQueRealizo

	| cartId purchases |
	
	cartId := interface createCartFor: self validUser with: self validPassword .
	
	interface add: 2 of: testObjects itemSellByTheStore toCartWithId: cartId.
	
	
	interface checkOutCartWithId: cartId 
			creditCardNumber: '1111222233334444' 
			expirationDay: testObjects notExpiredMonthOfYear 
			holderName: 'Teodoro Freund'.
	
	purchases := interface listPurchasesOfUser: self validUser withPassword: self validPassword.
	
	self assert: (purchases items occurrencesOf: testObjects itemSellByTheStore) equals: 2.
	self assert: purchases items size equals: 2.
	self assert: purchases total equals: (2 * testObjects itemSellByTheStorePrice ).! !

!TusLibrosInnerInterfaceTest methodsFor: 'testing' stamp: 'TF 6/24/2019 11:05:44'!
test12LaInterfazNoListaComprasParaUnUsuarioQueNoLasHizoInclusoCuandoOtroUsuarioSiHizoLasCompras

	| cartId purchases |
	
	cartId := interface createCartFor: self validUser with: self validPassword .

	
	interface add: 2 of: testObjects itemSellByTheStore toCartWithId: cartId.
	
	
	interface checkOutCartWithId: cartId 
			creditCardNumber: '1111222233334444' 
			expirationDay: testObjects notExpiredMonthOfYear 
			holderName: 'Teodoro Freund'.
	
	purchases := interface listPurchasesOfUser: self otherValidUser withPassword: self otherValidPassword .
	

	self assert: purchases items isEmpty .
	self assert: purchases total equals: 0.! !

!TusLibrosInnerInterfaceTest methodsFor: 'testing' stamp: 'TF 6/22/2019 17:22:21'!
test13NoPuedoListarLasComprasDeUnUsuarioMalAutenticado	
	
	self should: [interface listPurchasesOfUser: self invalidUser withPassword: self validPassword ] 
		raise: Error - MessageNotUnderstood 
		withMessageText:  TusLibrosInnerInterface invalidUserOrPasswordErrorDescription .
	

! !

!TusLibrosInnerInterfaceTest methodsFor: 'testing' stamp: 'TF 6/24/2019 10:11:21'!
test14NoPuedoListarLosContenidosDeUnCarritoExpirado

	| cartId |
	
	cartId := interface createCartFor: self validUser with: self validPassword .
	
	clock advance: 31 minutes.
	
	
	
	self should: [interface listCartWithId: cartId ] 
		raise: Error - MessageNotUnderstood 
		withMessageText:  TusLibrosInnerInterface cantAccessExpiredCartErrorDescription .
	

! !

!TusLibrosInnerInterfaceTest methodsFor: 'testing' stamp: 'TF 6/24/2019 10:44:45'!
test15NoPuedoAgregarContenidosAUnCarritoExpirado

	| cartId |
	
	cartId := interface createCartFor: self validUser with: self validPassword .
	
	clock advance: 31 minutes.
	
	
	
	self should: [interface add: 2 of: testObjects itemSellByTheStore toCartWithId: cartId ] 
		raise: Error - MessageNotUnderstood 
		withMessageText:  TusLibrosInnerInterface cantAccessExpiredCartErrorDescription .
	

! !

!TusLibrosInnerInterfaceTest methodsFor: 'testing' stamp: 'TF 6/24/2019 10:45:48'!
test16NoPuedoHacerCheckoutDeUnCarritoExpirado

	| cartId |
	
	cartId := interface createCartFor: self validUser with: self validPassword .
	interface add: 2 of: testObjects itemSellByTheStore toCartWithId: cartId .
	
	clock advance: 31 minutes.
	
	
	
	self should: [interface checkOutCartWithId: cartId creditCardNumber: '1234123412341234'  expirationDay: testObjects notExpiredMonthOfYear holderName: 'Andres Radunsky' ] 
		raise: Error - MessageNotUnderstood 
		withMessageText:  TusLibrosInnerInterface cantAccessExpiredCartErrorDescription .
	

! !


!TusLibrosInnerInterfaceTest methodsFor: 'test objects - user and password' stamp: 'TF 6/22/2019 13:06:14'!
invalidPassword
	^'0123456789'! !

!TusLibrosInnerInterfaceTest methodsFor: 'test objects - user and password' stamp: 'TF 6/22/2019 13:06:00'!
invalidUser
	^'someInvalidUser'! !

!TusLibrosInnerInterfaceTest methodsFor: 'test objects - user and password' stamp: 'TF 6/22/2019 13:48:34'!
otherValidPassword
	^'0773rS3c0nd'! !

!TusLibrosInnerInterfaceTest methodsFor: 'test objects - user and password' stamp: 'TF 6/22/2019 13:48:15'!
otherValidUser
	^'someOtterValidUser'! !

!TusLibrosInnerInterfaceTest methodsFor: 'test objects - user and password' stamp: 'TF 6/22/2019 13:49:20'!
userPasswordRecord
	^Dictionary new at: self validUser put: self validPassword; at: self otherValidUser put: self otherValidPassword; yourself .! !

!TusLibrosInnerInterfaceTest methodsFor: 'test objects - user and password' stamp: 'TF 6/22/2019 13:06:38'!
validPassword
	^'s4f3tyF1rs7'! !

!TusLibrosInnerInterfaceTest methodsFor: 'test objects - user and password' stamp: 'TF 6/22/2019 13:05:43'!
validUser
	^'someValidUser'! !


!TusLibrosInnerInterfaceTest methodsFor: 'merchant processor interface' stamp: 'TF 6/22/2019 14:34:49'!
debit: anAmount from: aCreditCard ! !


!TusLibrosInnerInterfaceTest methodsFor: 'setUp/tearDown' stamp: 'TF 6/24/2019 10:12:15'!
setUp
	testObjects := StoreTestObjectsFactory new.
	salesBook := OrderedCollection new.
	clock := ClockSimulator with: DateAndTime now .
	interface := TusLibrosInnerInterface 
		authenticatingWith: self userPasswordRecord 
		sellingFrom: testObjects defaultCatalog 
		chargingOn: self  
		registeringOn: salesBook 
		timingWith: clock .! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'catalog items owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'TF 6/24/2019 10:54:07'!
initializeOwnedBy: anUser acceptingItemsOf: aCatalog

	owner := anUser.
	catalog := aCatalog.
	items := Bag new.! !


!Cart methodsFor: 'queries' stamp: 'TF 6/22/2019 13:42:35'!
contents
	^items copy .! !

!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !


!Cart methodsFor: 'accessing' stamp: 'TF 6/22/2019 16:50:50'!
owner
	^owner! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'TF 6/24/2019 10:54:07'!
ownedBy: anUser acceptingItemsOf: aCatalog

	^self new initializeOwnedBy: anUser acceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'TF 6/22/2019 16:51:22'!
createSale

	^ Sale of: total withDescription: cart contents byUser: cart owner.
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #Clock category: #TusLibros!
Object subclass: #Clock
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Clock methodsFor: 'accessing' stamp: 'TF 6/24/2019 10:03:42'!
now
	self subclassResponsibility .! !


!classDefinition: #ClockSimulator category: #TusLibros!
Clock subclass: #ClockSimulator
	instanceVariableNames: 'time'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ClockSimulator methodsFor: 'accessing' stamp: 'TF 6/24/2019 10:04:31'!
now
	^time.! !


!ClockSimulator methodsFor: 'initialization' stamp: 'TF 6/24/2019 10:05:35'!
initializeWith: aTime
	time := aTime .! !


!ClockSimulator methodsFor: 'modification' stamp: 'TF 6/24/2019 10:05:18'!
advance: aDuration
	time := time + aDuration.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ClockSimulator class' category: #TusLibros!
ClockSimulator class
	instanceVariableNames: ''!

!ClockSimulator class methodsFor: 'instance creation' stamp: 'TF 6/24/2019 10:05:49'!
with: aTime
	^self new initializeWith: aTime .! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!classDefinition: #PurchaseList category: #TusLibros!
Object subclass: #PurchaseList
	instanceVariableNames: 'items total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!PurchaseList methodsFor: 'accessing' stamp: 'TF 6/24/2019 11:03:52'!
items
	^items.! !

!PurchaseList methodsFor: 'accessing' stamp: 'TF 6/24/2019 11:03:41'!
total
	^total.! !


!PurchaseList methodsFor: 'initialization' stamp: 'TF 6/24/2019 11:03:33'!
initializeWith: someSales

	items := Bag new.
	total := 0.
	someSales inject: items addingAll: [:aSale | 
											total := total + aSale total .
											aSale contents .] ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PurchaseList class' category: #TusLibros!
PurchaseList class
	instanceVariableNames: ''!

!PurchaseList class methodsFor: 'instance creation' stamp: 'TF 6/24/2019 11:04:07'!
with: someSales
	^self new initializeWith: someSales .! !


!classDefinition: #Sale category: #TusLibros!
Object subclass: #Sale
	instanceVariableNames: 'total cartContents userId'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'TF 6/22/2019 16:39:47'!
initializeTotal: aTotal contents: aCartContents byUser: aUserId

	total := aTotal.
	cartContents := aCartContents .
	userId := aUserId .! !


!Sale methodsFor: 'comparing' stamp: 'TF 6/22/2019 16:40:22'!
madeByUser: anUserId
	^anUserId = userId .! !


!Sale methodsFor: 'querying' stamp: 'TF 6/22/2019 17:13:01'!
contents
	^cartContents.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #TusLibros!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'TF 6/22/2019 16:37:48'!
of: aTotal withDescription: cartContents byUser: userId

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal contents: cartContents byUser: userId .! !


!classDefinition: #StoreTestObjectsFactory category: #TusLibros!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'TF 6/22/2019 16:45:27'!
createCart
	
	^Cart ownedBy: 'validUser' acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'TF 6/22/2019 14:23:48'!
expiredCreditCard
	
	^CreditCard expiringOn: self expiredMonthOfYear ! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'TF 6/22/2019 14:23:39'!
expiredMonthOfYear
	
	^Month month: today monthIndex year: today yearNumber - 1! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'TF 6/22/2019 14:23:56'!
notExpiredCreditCard
	
	^CreditCard expiringOn: self notExpiredMonthOfYear ! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'TF 6/22/2019 14:23:19'!
notExpiredMonthOfYear
	
	^Month month: today monthIndex year: today yearNumber + 1! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!classDefinition: #TimedObject category: #TusLibros!
Object subclass: #TimedObject
	instanceVariableNames: 'value clock lastUsed'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TimedObject methodsFor: 'initialization' stamp: 'TF 6/24/2019 10:08:26'!
initializeWith: aBlock andClock: aClock
	value := aBlock value.
	clock := aClock .
	lastUsed := clock now.! !


!TimedObject methodsFor: 'private' stamp: 'TF 6/24/2019 10:07:52'!
resetTimer
	lastUsed := clock now.! !


!TimedObject methodsFor: 'accessing' stamp: 'TF 6/24/2019 10:08:15'!
isExpired
	^(lastUsed + 30 minutes) < clock now.! !

!TimedObject methodsFor: 'accessing' stamp: 'TF 6/24/2019 10:09:19'!
valueIfExpired: aBlock
	^self isExpired 
		ifFalse: [self resetTimer. value] 
		ifTrue: aBlock. 
	! !


!TimedObject methodsFor: 'applying' stamp: 'TF 6/24/2019 10:16:36'!
do: aBlock IfExpired: anExpirationBlock
	^self isExpired 
		ifFalse: [self resetTimer. aBlock value: value] 
		ifTrue: anExpirationBlock. 
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TimedObject class' category: #TusLibros!
TimedObject class
	instanceVariableNames: ''!

!TimedObject class methodsFor: 'instance creation' stamp: 'TF 6/24/2019 10:13:23'!
with: aBlock andClock: aClock
	^self new initializeWith: aBlock andClock: aClock .! !


!classDefinition: #TusLibrosInnerInterface category: #TusLibros!
Object subclass: #TusLibrosInnerInterface
	instanceVariableNames: 'catalog userPasswordRecord salesBook merchantProcessor carts lastId clock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosInnerInterface methodsFor: 'API protocol' stamp: 'TF 6/22/2019 16:34:31'!
add: anAmount of: aBook toCartWithId: aCartId 
	self onCart: aCartId do: [:aCart | aCart add: anAmount of: aBook] .! !

!TusLibrosInnerInterface methodsFor: 'API protocol' stamp: 'TF 6/22/2019 16:34:02'!
checkOutCartWithId: aCartId creditCardNumber: aCardNumber expirationDay: anExpirationDate holderName: aCardHolder 
	^self onCart: aCartId do: [:aCart | | aCashier | 
			aCashier := Cashier toCheckout: aCart 
								charging: (CreditCard expiringOn: anExpirationDate )
								throught: merchantProcessor 
								on: DateAndTime now
								registeringOn: salesBook.
			aCashier checkOut ] .
! !

!TusLibrosInnerInterface methodsFor: 'API protocol' stamp: 'TF 6/24/2019 10:51:23'!
createCartFor: aUser with: aPassword 
	| cartId |

	self assertUser: aUser hasPassword: aPassword.
	
	cartId := self getNextCartId .
		
	carts at: cartId 
			put: (TimedObject with: [Cart ownedBy: aUser acceptingItemsOf: catalog] andClock: clock ).

	^cartId .
	
	! !

!TusLibrosInnerInterface methodsFor: 'API protocol' stamp: 'TF 6/24/2019 10:15:44'!
listCartWithId: aCartId 
	^self onCart: aCartId do: [:aTimedCart | aTimedCart contents ] .! !

!TusLibrosInnerInterface methodsFor: 'API protocol' stamp: 'TF 6/24/2019 11:05:15'!
listPurchasesOfUser: anUser withPassword: aPassword 
	self assertUser: anUser hasPassword: aPassword .
	
	
	^ PurchaseList with: (salesBook select: [ :aSale | aSale madeByUser: anUser ]) .! !


!TusLibrosInnerInterface methodsFor: 'assertions' stamp: 'TF 6/22/2019 13:28:19'!
assertUser: aUser hasPassword: aPassword 

	userPasswordRecord at: aUser 
		ifPresent: [:thePassword | thePassword = aPassword ifFalse: [self error: self class invalidUserOrPasswordErrorDescription ]] 
		ifAbsent: [self error: self class invalidUserOrPasswordErrorDescription ].! !


!TusLibrosInnerInterface methodsFor: 'initialization' stamp: 'TF 6/24/2019 10:14:47'!
initializeAuthenticatingWith: aUserPasswordRecord
	sellingFrom: aCatalog
	chargingOn: aMerchantProcessor
	registeringOn: aSalesBook
	timingWith: aClock
	
	userPasswordRecord := aUserPasswordRecord .
	catalog := aCatalog .
	merchantProcessor := aMerchantProcessor .
	salesBook := aSalesBook .
	clock := aClock .
	
	carts := Dictionary new.
	lastId := 0.! !


!TusLibrosInnerInterface methodsFor: 'private' stamp: 'TF 6/24/2019 10:55:40'!
getNextCartId

	lastId := lastId + 1.
	^lastId .! !

!TusLibrosInnerInterface methodsFor: 'private' stamp: 'TF 6/24/2019 10:56:22'!
onCart: aCartId do: aBlock 
	^carts at: aCartId 
		ifPresent: [:aTimedCart | 
						aTimedCart do: aBlock 
						IfExpired: [self error: self class cantAccessExpiredCartErrorDescription ]] 
		ifAbsent: [self error: self class invalidCartIdErrorDescription ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosInnerInterface class' category: #TusLibros!
TusLibrosInnerInterface class
	instanceVariableNames: ''!

!TusLibrosInnerInterface class methodsFor: 'error description' stamp: 'TF 6/24/2019 10:12:31'!
cantAccessExpiredCartErrorDescription
	^'El carrito expiro'.! !

!TusLibrosInnerInterface class methodsFor: 'error description' stamp: 'TF 6/22/2019 13:59:54'!
invalidCartIdErrorDescription
	^'Se uso un CartId Invalido'.! !

!TusLibrosInnerInterface class methodsFor: 'error description' stamp: 'TF 6/22/2019 13:19:20'!
invalidUserOrPasswordErrorDescription
	^'El usuario o la contrasena no son validos'.! !


!TusLibrosInnerInterface class methodsFor: 'instance creation' stamp: 'TF 6/24/2019 10:14:59'!
authenticatingWith: aUserPasswordRecord
	sellingFrom: aCatalog
	chargingOn: aMerchantProcessor
	registeringOn: aSalesBook
	timingWith: aClock
	
	^self new 
		initializeAuthenticatingWith: aUserPasswordRecord 
		sellingFrom: aCatalog  
		chargingOn:  aMerchantProcessor 
		registeringOn:  aSalesBook 
		timingWith: aClock .! !
