!classDefinition: #CheckOutWindow category: #'TusLibros-Web'!
Panel subclass: #CheckOutWindow
	instanceVariableNames: 'creditCardNumberTextBox ownersNameTextBox payButton transcriptList expirationDateTextBox errorTextBox paymentInfoTextBox'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Web'!

!CheckOutWindow methodsFor: 'GUI building' stamp: 'tf 7/11/2019 13:18:40'!
buildCheckOutColumn
	creditCardNumberTextBox _ TextModelMorph 
		textProvider: self model 
		textGetter:  #creditCardNumber
		textSetter: #creditCardNumber: .
	creditCardNumberTextBox textMorph 
		setProperty: #keyStroke: 
		toValue: [:key |
			creditCardNumberTextBox textMorph acceptContents 
		].
	creditCardNumberTextBox 
		borderWidth: 1;
		borderColor: Color skyBlue;
		morphHeight: self textBoxHeight ;
		emptyTextDisplayMessage: '0123456789012345'.
		
	ownersNameTextBox _ TextModelMorph 
		textProvider: self model 
		textGetter:  #ownersName
		textSetter: #ownersName: .
	ownersNameTextBox textMorph 
		setProperty: #keyStroke: 
		toValue: [:key |
			ownersNameTextBox textMorph acceptContents 
		].
	ownersNameTextBox 
		borderWidth: 1;
		borderColor: Color skyBlue ;
		morphHeight: self textBoxHeight ;
		emptyTextDisplayMessage: 'Jane Doe'.
		
	expirationDateTextBox _ TextModelMorph 
		textProvider: self model 
		textGetter:  #expirationDate
		textSetter: #expirationDate: .
	expirationDateTextBox textMorph 
		setProperty: #keyStroke: 
		toValue: [:key |
			expirationDateTextBox textMorph acceptContents 
		].
	expirationDateTextBox 
		borderWidth: 1;
		borderColor: Color skyBlue ;
		morphHeight: self textBoxHeight ;
		emptyTextDisplayMessage: '07/2019'.
		
	payButton _
		PluggableButtonMorph model: self model 
									stateGetter: nil 
									action: #checkout 
									label: 'Pay'. 
									
	paymentInfoTextBox _ StringMorph contents: ''.
		
	^(LayoutMorph newColumn )
		padding: #left;
		separation: 15;
		addMorph: (StringMorph contents: 'Credit card number:');
		addMorph: creditCardNumberTextBox ;
		addMorph: (StringMorph contents: 'Owners name:');
		addMorph: ownersNameTextBox ;
		addMorph: (StringMorph contents: 'Expiration Date (mm/yyyy)');
		addMorph: expirationDateTextBox ;
		addMorph: payButton ;
		addMorph: paymentInfoTextBox .
			
	! !

!CheckOutWindow methodsFor: 'GUI building' stamp: 'tf 7/11/2019 09:56:15'!
buildMorphicWindow
	self layoutMorph beRow;
		 separation: 15;
		 padding: #left;
		 addMorph: self buildCheckOutColumn;
		addMorph: self buildTranscriptColumn .! !

!CheckOutWindow methodsFor: 'GUI building' stamp: 'tf 7/11/2019 10:07:51'!
buildTranscriptColumn

	transcriptList _ PluggableListMorph model: self model
								listGetter: #transcript
								indexGetter: nil
								indexSetter: nil.
	transcriptList morphHeight: self textBoxHeight *6.
	
	errorTextBox _ StringMorph contents: ''.
	
	^(LayoutMorph newColumn )
		padding: #left;
		separation: 15;
		addMorph: (StringMorph contents: 'Transcript:');
		addMorph: transcriptList;
		addMorph: errorTextBox ;
		yourself.
			
	! !


!CheckOutWindow methodsFor: 'events' stamp: 'tf 7/11/2019 13:13:13'!
paymentDone
	paymentInfoTextBox contents: 'Payment Done'.
	! !

!CheckOutWindow methodsFor: 'events' stamp: 'tf 7/11/2019 10:07:58'!
showError: anErrorMessage

	errorTextBox contents: 'Error: ', anErrorMessage .! !

!CheckOutWindow methodsFor: 'events' stamp: 'tf 7/11/2019 10:20:22'!
updateTranscript
	transcriptList updateList.
	! !


!CheckOutWindow methodsFor: 'layout-properties' stamp: 'tf 7/11/2019 09:09:11'!
textBoxHeight
	^30.! !


!CheckOutWindow methodsFor: 'initialization' stamp: 'tf 7/11/2019 10:21:09'!
initializeWith: aTitle cartId: cartId username: username password: password
	
	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: aTitle;
		 model: (CheckOutWindowModel withCartId: cartId username: username password: password);
		 morphExtent: 640@480;
		 buildMorphicWindow;
		 openInWorld.
	self model when: #paymentDone
				send: #paymentDone
				to: self.
	self model when: #updateTranscript
				send: #updateTranscript
				to: self.
	self model when: #paymentFailed:
				send: #showError:
				to: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CheckOutWindow class' category: #'TusLibros-Web'!
CheckOutWindow class
	instanceVariableNames: ''!

!CheckOutWindow class methodsFor: 'as yet unclassified' stamp: 'tf 7/10/2019 19:12:34'!
withCartId: cartId usernam: username password: password

	^self new initializeWith: 'Checkout (', cartId printString, ')' cartId: cartId username: username password: password.! !


!classDefinition: #CreateCartWindow category: #'TusLibros-Web'!
Panel subclass: #CreateCartWindow
	instanceVariableNames: 'usernameTextBox passwordTextBox errorTextBox'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Web'!

!CreateCartWindow methodsFor: 'access' stamp: 'tf 7/10/2019 17:53:30'!
goToStore
	self model goToStore.
	self delete.
	
	! !

!CreateCartWindow methodsFor: 'access' stamp: 'TF 7/9/2019 17:14:55'!
showWrongUser: anErrorMessage
	errorTextBox contents: anErrorMessage.! !


!CreateCartWindow methodsFor: 'initialization' stamp: 'ar 7/9/2019 19:03:49'!
initializeWith: aTitle
	self titleMorph showButtonsNamed: #(close collapse).
	self setLabel: aTitle;
		 model: CreateCartWindowModel new;
		 morphExtent: 640@480;
		 buildMorphicWindow;
		 openInWorld.
	self model when: #cartCreationSuccess
				send: #goToStore
				to: self.
	self model when: #cartCreationFailed
				send: #showWrongUser:
				to: self.! !


!CreateCartWindow methodsFor: 'GUI building' stamp: 'TF 7/9/2019 17:06:02'!
buildCreateCartButtonRow
	| aButtonMorph |
			
	aButtonMorph _ PluggableButtonMorph 
		model: self model
		stateGetter: nil
		action: #sendCreateCartRequest
		label: 'Nuevo carrito'.
	
	errorTextBox  _ StringMorph contents: ''.

	^ (LayoutMorph newRow)
		separation: 25;
		padding: #left;
		addMorph: aButtonMorph;
		addMorph: errorTextBox;
		yourself.! !

!CreateCartWindow methodsFor: 'GUI building' stamp: 'TF 7/9/2019 16:25:03'!
buildMorphicWindow
	self layoutMorph beColumn;
		separation: 15;
		padding: #left;
		addMorph: self buildUsernameRow;
		addMorph: self buildPasswordRow;
		addMorph: self buildCreateCartButtonRow.! !

!CreateCartWindow methodsFor: 'GUI building' stamp: 'tf 7/11/2019 13:17:09'!
buildPasswordRow

	passwordTextBox _ TextModelMorph
		textProvider: self model
		textGetter: #password
		textSetter: #password: .
		
	passwordTextBox textMorph
		setProperty: #keyStroke:
		toValue: [ :key |
			passwordTextBox textMorph acceptContents ].
		
	passwordTextBox
		borderWidth: 1;
		borderColor: Color skyBlue;
		emptyTextDisplayMessage: 'hint: freund';
		morphHeight: self rowHeight.
		
	^ (LayoutMorph newRow) separation: 25;
		padding: #left;
		addMorph: (StringMorph contents: 'Contraseña:');
		addMorph: passwordTextBox;
		yourself.! !

!CreateCartWindow methodsFor: 'GUI building' stamp: 'tf 7/11/2019 13:17:05'!
buildUsernameRow

	usernameTextBox _ TextModelMorph
		textProvider: self model
		textGetter: #username
		textSetter: #username: .
		
	usernameTextBox textMorph
		setProperty: #keyStroke:
		toValue: [ :key |
			usernameTextBox textMorph acceptContents ].
	usernameTextBox
		borderWidth: 1;
		borderColor: Color skyBlue;
		emptyTextDisplayMessage: 'hint: teo';
		morphHeight: self rowHeight.
		
	^ (LayoutMorph newRow) separation: 25;
		padding: #left;
		addMorph: (StringMorph contents: 'Usuario:');
		addMorph: usernameTextBox;
		yourself.! !


!CreateCartWindow methodsFor: 'layout properties' stamp: 'tf 7/11/2019 13:16:35'!
rowHeight
	^30.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreateCartWindow class' category: #'TusLibros-Web'!
CreateCartWindow class
	instanceVariableNames: ''!

!CreateCartWindow class methodsFor: 'as yet unclassified' stamp: 'TF 7/9/2019 16:22:05'!
open
	^ self new initializeWith: 'TusLibros.com'.! !


!classDefinition: #StoreWindow category: #'TusLibros-Web'!
Panel subclass: #StoreWindow
	instanceVariableNames: 'catalogList cartContentsList subtotalText errorTextBox'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Web'!

!StoreWindow methodsFor: 'events' stamp: 'ar 7/9/2019 19:59:46'!
setCatalog
	catalogList updateList.
	catalogList setSelectionIndex: 0.! !

!StoreWindow methodsFor: 'events' stamp: 'tf 7/10/2019 18:41:03'!
showError: anErrorMessage
	errorTextBox contents: 'ERROR: ', anErrorMessage .! !

!StoreWindow methodsFor: 'events' stamp: 'tf 7/10/2019 18:29:22'!
updateCartContents

	cartContentsList updateList .
	subtotalText contents: 'Total $', self model subTotal printString .! !


!StoreWindow methodsFor: 'GUI building' stamp: 'tf 7/11/2019 09:08:07'!
buildCartContentsColumn
	|checkoutButton |
	cartContentsList _ 
		PluggableListMorph model: self model
								listGetter: #cartContentsAsOrderedCollection
								indexGetter: #cartContentsIndex
								indexSetter: #cartContentsIndex:.
	cartContentsList morphHeight: self listHeight.
	
	checkoutButton _ 
		PluggableButtonMorph model: self model
									stateGetter: nil
									action: #goToCheckout
									label: 'Checkout'.
									
	subtotalText _ StringMorph contents: 'Total: $0'.
	
	errorTextBox _ StringMorph contents: ''.
	
		     
	^ (LayoutMorph newColumn)
		    padding: #left;
		    separation: 15;
		    addMorph: (StringMorph contents: 'Tu carrito:');
		    addMorph: cartContentsList;
    	    addMorph: checkoutButton;
  	          addMorph: subtotalText;
		    addMorph: errorTextBox .
		! !

!StoreWindow methodsFor: 'GUI building' stamp: 'tf 7/11/2019 09:07:24'!
buildCatalogColumn
	|addToCartButton|
	catalogList _ 
		PluggableListMorph model: self model
								listGetter: #catalog
								indexGetter: #catalogIndex
								indexSetter: #catalogIndex:.
	catalogList morphHeight: self listHeight.
	
	addToCartButton _ 
		PluggableButtonMorph model: self model
									stateGetter: nil
									action: #addToCart
									label: 'Agregar al carrito'.
	
	^ (LayoutMorph newColumn)
					    separation: 15;
					    padding: #left;
					    addMorph: (StringMorph contents: 'Catálogo:');
					    addMorph: catalogList;
					    addMorph: addToCartButton.! !

!StoreWindow methodsFor: 'GUI building' stamp: 'ar 7/9/2019 19:06:39'!
buildMorphicWindow
	self layoutMorph beRow;
		 separation: 15;
		 padding: #left;
		 addMorph: self buildCatalogColumn;
		 addMorph: self buildCartContentsColumn.! !


!StoreWindow methodsFor: 'layout-properties' stamp: 'tf 7/11/2019 09:07:50'!
listHeight
	^280.! !


!StoreWindow methodsFor: 'initialization' stamp: 'tf 7/10/2019 18:46:48'!
withModel: aModel andTitle: aTitle
	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: aTitle;
		 model: (aModel);
		 morphExtent: 640@480;
		 buildMorphicWindow;
		 openInWorld.
	self model when: #catalogArrived 
			     send: #setCatalog
			     to: self.
	self model when: #cartContentsUpdated 
				send: #updateCartContents  
				to: self.
	self model when: #catalogRequestFailed
				send: #showError:
				to: self.
	self model when: #addToCartFailed
				send: #showError:
				to: self.
	self model  when: #checkOutWindowCreated 
				send: #delete  
				to: self. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StoreWindow class' category: #'TusLibros-Web'!
StoreWindow class
	instanceVariableNames: ''!

!StoreWindow class methodsFor: 'as yet unclassified' stamp: 'ar 7/9/2019 19:18:06'!
open
	self new initializeWith: 'Tus Libros - Tienda'.! !

!StoreWindow class methodsFor: 'as yet unclassified' stamp: 'tf 7/10/2019 17:59:50'!
withCartId: cartId username: username password: password	
	self new 
		withModel:  (StoreWindowModel 
			withWebClient: TusLibrosWebClient new 
			cartId: cartId 
			username: username 
			andPassword: password ) 
		andTitle: 'Tus Libros - Tienda (', cartId printString, ')'.! !


!classDefinition: #CheckOutWindowModelTest category: #'TusLibros-Web'!
TestCase subclass: #CheckOutWindowModelTest
	instanceVariableNames: 'checkoutModel checkoutWebClientRequestBlock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Web'!

!CheckOutWindowModelTest methodsFor: 'tests' stamp: 'tf 7/11/2019 09:11:01'!
test01CreditCardNmuberEmpiezaVacio
	
	self assert: checkoutModel creditCardNumber equals: ''.
 ! !

!CheckOutWindowModelTest methodsFor: 'tests' stamp: 'tf 7/11/2019 09:11:16'!
test02PuedoCambiarElValorDeCreditCardNumber
	
	checkoutModel creditCardNumber: '123tteeoo'.
	self assert: checkoutModel creditCardNumber equals: '123tteeoo'.
 ! !

!CheckOutWindowModelTest methodsFor: 'tests' stamp: 'tf 7/11/2019 09:11:25'!
test03OwnersNameEmpiezaVacio
	
	self assert: checkoutModel ownersName equals: ''.
 ! !

!CheckOutWindowModelTest methodsFor: 'tests' stamp: 'tf 7/11/2019 09:12:09'!
test04PuedoCambiarElValorDeOwnersName
	
	checkoutModel ownersName: '123tteeoo'.
	self assert: checkoutModel ownersName equals: '123tteeoo'.
 ! !

!CheckOutWindowModelTest methodsFor: 'tests' stamp: 'tf 7/11/2019 09:12:18'!
test05ExpirationDateEmpiezaVacio
	
	self assert: checkoutModel expirationDate equals: ''.
 ! !

!CheckOutWindowModelTest methodsFor: 'tests' stamp: 'tf 7/11/2019 09:11:51'!
test06PuedoCambiarElValorDeExpirationDate
	
	checkoutModel expirationDate: '123tteeoo'.
	self assert: checkoutModel expirationDate equals: '123tteeoo'.
 ! !

!CheckOutWindowModelTest methodsFor: 'tests' stamp: 'tf 7/11/2019 13:10:46'!
test07AlPagarSeHaceElRequestAlWebClientYSeLevantaElEventoCorrespondienteSiTodoSaleBien
	|  counter |
	
	counter _ 0.
	checkoutWebClientRequestBlock _ [:cartId :ccNumber :ownersName :expirationDate |
		self assert: cartId equals: 23. 
		self assert: ccNumber equals: '0123012301230123'. 
		self assert: ownersName equals: 'Teo Freund'.
		self assert: expirationDate equals:  (Month month: 07 year: 2020) . 
		counter _ counter + 1.
	].
	

	checkoutModel when: #paymentDone evaluate: [counter _ counter + 1].
	checkoutModel creditCardNumber: '0123012301230123'.
	checkoutModel ownersName: 'Teo Freund'.
	checkoutModel expirationDate: '07/2020'.
	
	checkoutModel checkout.
	
	self assert: counter equals: 2.

	! !

!CheckOutWindowModelTest methodsFor: 'tests' stamp: 'tf 7/11/2019 09:36:39'!
test08AlPagarSeHaceElRequestAlWebClientYSeLevantaElEventoCorrespondienteSiHayUnError
	|  error |
	
	error _ ''.
	checkoutWebClientRequestBlock _ [:cartId :ccNumber :ownersName :expirationDate |
		self error: 'Error!!'.
	].
	

	checkoutModel when: #paymentFailed: evaluate: [:anError | error _ anError].
	
	checkoutModel creditCardNumber: '0123012301230123'.
	checkoutModel ownersName: 'Teo Freund'.
	checkoutModel expirationDate: '07/2020'.
	checkoutModel checkout.
	
	self assert: error equals: 'Error!!'.

	! !

!CheckOutWindowModelTest methodsFor: 'tests' stamp: 'tf 7/11/2019 09:52:01'!
test09TranscriptEmpiezaVacio
	
	self assert: checkoutModel transcript isEmpty.
 ! !

!CheckOutWindowModelTest methodsFor: 'tests' stamp: 'tf 7/11/2019 10:28:27'!
test10DespuesDeEfectuarElPagoSeActualizaElTranscript

	| flag |
	checkoutWebClientRequestBlock _ [:cartId :ccNumber :ownersName :expirationDate |].
	

	flag _ false.
	checkoutModel when: #updateTranscript evaluate: [flag _ true].
	checkoutModel creditCardNumber: '0123012301230123'.
	checkoutModel ownersName: 'Teo Freund'.
	checkoutModel expirationDate: '07/2020'.
	
	checkoutModel checkout.
	

	self assert: flag.
	self assert: checkoutModel transcript equals: (OrderedCollection with: 'harry potter $120' with: 'valid $200').
	! !


!CheckOutWindowModelTest methodsFor: 'setUp/tearDown' stamp: 'tf 7/11/2019 09:22:25'!
setUp
	
	checkoutModel _ 
		CheckOutWindowModel 
			withWebClient: self
			cartId: self cartId 
			username: self username 
			password: self password. ! !


!CheckOutWindowModelTest methodsFor: 'default values' stamp: 'tf 7/11/2019 00:12:43'!
cartId
	^23.! !

!CheckOutWindowModelTest methodsFor: 'default values' stamp: 'tf 7/11/2019 00:13:02'!
password
	^'ValidP'.! !

!CheckOutWindowModelTest methodsFor: 'default values' stamp: 'tf 7/11/2019 00:12:52'!
username
	^'Valid'.! !


!CheckOutWindowModelTest methodsFor: 'web client protocol' stamp: 'tf 7/11/2019 09:30:43'!
checkOutCartIdentifiedAs: aCartId 
withCreditCardNumbered: aCreditCartNumber 
ownedBy: anOwner 
expiringOn: anExpirationMonthOfYear
	^checkoutWebClientRequestBlock 
		value: aCartId 
		value: aCreditCartNumber  
		value: anOwner  
		value: anExpirationMonthOfYear .! !

!CheckOutWindowModelTest methodsFor: 'web client protocol' stamp: 'tf 7/11/2019 10:25:15'!
listPurchasesOf: username authenticatingWith: password
	^Dictionary new at: 'valid' put: 200; at: 'harry potter' put: 120; yourself. ! !


!classDefinition: #CreateCartWindowModelTest category: #'TusLibros-Web'!
TestCase subclass: #CreateCartWindowModelTest
	instanceVariableNames: 'webClientRequestBlock windowModel'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Web'!

!CreateCartWindowModelTest methodsFor: 'tests' stamp: 'ar 7/7/2019 17:53:46'!
test01NewModelUsernameValueIsEmpty
	| LoginModel |
	
	LoginModel _ CreateCartWindowModel new.
	
	self assert: (LoginModel username = '').! !

!CreateCartWindowModelTest methodsFor: 'tests' stamp: 'ar 7/7/2019 17:53:46'!
test02NewModelPasswordValueIsEmpty
	| LoginModel |
	
	LoginModel _ CreateCartWindowModel new.
	
	self assert: (LoginModel password = '').! !

!CreateCartWindowModelTest methodsFor: 'tests' stamp: 'ar 7/7/2019 17:53:46'!
test03ModelUsernameValueUpdatesWithInputtedValue
	| LoginModel |
	
	LoginModel _ CreateCartWindowModel new.
	
	LoginModel username: 'ValidUser'.
	self assert: (LoginModel username = 'ValidUser').! !

!CreateCartWindowModelTest methodsFor: 'tests' stamp: 'ar 7/7/2019 17:53:46'!
test04ModelPasswordValueUpdatesWithInputtedValue
	| LoginModel |
	
	LoginModel _ CreateCartWindowModel new.
	
	LoginModel password: 'ValidPass'.
	self assert: (LoginModel password = 'ValidPass').! !

!CreateCartWindowModelTest methodsFor: 'tests' stamp: 'TF 7/9/2019 16:17:15'!
test05SiElWebClientCreaElCarritoElModeloGuardaElIdYDisparaElEventoDeCreacionExitosa
	| flag |
	
	webClientRequestBlock _ [:user :password |
		self assert: user equals: 'valid'.
		self assert: password equals: 'valid'. 
		23.
	] .

	flag _ false.
	windowModel when: #cartCreationSuccess evaluate: [flag _ true].
	
	windowModel username: 'valid'.
	windowModel password: 'valid'.
	windowModel sendCreateCartRequest .
	
	self assert: windowModel cartId equals: 23. 
	self assert: flag .! !

!CreateCartWindowModelTest methodsFor: 'tests' stamp: 'ar 7/9/2019 19:33:52'!
test06SiElWebClientRecibeUnErrorAlCrearElCarritoForewardeaElMensajeDeError
	| flag error |
	
	webClientRequestBlock _ [:user :password |
		self assert: user equals: 'invalid'.
		self assert: password equals: 'invalid'. 
		self error: 'error 123'.
	] .

	flag _ false.
	windowModel when: #cartCreationFailed evaluate: [:errorMessage | flag _ true. error _ errorMessage ].
	
	windowModel username: 'invalid'.
	windowModel password: 'invalid'.
	windowModel sendCreateCartRequest.
	
	self assert: error equals: 'error 123'. 
	self assert: flag .! !


!CreateCartWindowModelTest methodsFor: 'webclient protocol' stamp: 'TF 7/9/2019 16:16:10'!
createCartFor: aUsername authenticatedWith: aPassword
	^webClientRequestBlock value: aUsername value: aPassword.! !


!CreateCartWindowModelTest methodsFor: 'setUp/tearDown' stamp: 'TF 7/9/2019 15:59:42'!
setUp
	windowModel _ CreateCartWindowModel withWebClient: self.! !


!classDefinition: #StoreWindowModelTest category: #'TusLibros-Web'!
TestCase subclass: #StoreWindowModelTest
	instanceVariableNames: 'catalogWebClientRequestBlock addToCartWebClientRequestBlock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Web'!

!StoreWindowModelTest methodsFor: 'tests' stamp: 'tf 7/10/2019 17:18:19'!
test01AlPedirElCatalogoPorPrimeraVezLoReciboYSeLevantaElEvento
	| storeModel catalogAsOrderedCollection flag |
	
	catalogWebClientRequestBlock _ [
		self defaultCatalog .
	].
	
	storeModel _ StoreWindowModel withWebClient: self cartId: 23  username: 'Valid'  andPassword: 'ValidP'.
	
	flag _ false.
	storeModel when: #catalogUpdated evaluate: [flag _ true].
	
	catalogAsOrderedCollection _ OrderedCollection new.
	self defaultCatalog keysAndValuesDo: [:key :value | catalogAsOrderedCollection add: key, ' $', value printString].
	
	self assert: storeModel catalog equals:  catalogAsOrderedCollection .
	self assert: flag.! !

!StoreWindowModelTest methodsFor: 'tests' stamp: 'tf 7/10/2019 17:18:19'!
test02AlPedirElCatalogoYRecibirUnaExcepcionPorElWebClientSeLlamaAlEventoCorrespondiente
	| storeModel error |
	
	catalogWebClientRequestBlock _ [
		self error: 'bad request' .
	].
	
	storeModel _ StoreWindowModel withWebClient: self cartId: 23  username: 'Valid'  andPassword: 'ValidP'.
	
	storeModel when: #catalogRequestFailed evaluate: [:anError | error _ anError].
	
	storeModel catalog.
	
	self assert: error equals: 'bad request'.! !

!StoreWindowModelTest methodsFor: 'tests' stamp: 'tf 7/10/2019 18:06:29'!
test03ElValorDeCatalogIndexComienzaEn0
	| storeModel |
	
	storeModel _ StoreWindowModel withWebClient: self cartId: 23  username: 'Valid'  andPassword: 'ValidP'.

	self assert: storeModel catalogIndex equals: 0.! !

!StoreWindowModelTest methodsFor: 'tests' stamp: 'tf 7/10/2019 18:06:12'!
test03bisPuedoCambiarElValorDeCatalogIndex
	| storeModel |
	
	storeModel _ StoreWindowModel withWebClient: self cartId: 23  username: 'Valid'  andPassword: 'ValidP'.
	storeModel catalogIndex: 42.
	self assert: storeModel catalogIndex equals: 42.! !

!StoreWindowModelTest methodsFor: 'tests' stamp: 'tf 7/10/2019 17:33:41'!
test04AlAgregarUnElementoSeNotificaAlWebClientYSeLevantaElEventoCorrespondienteSiTodoSaleBien
	| storeModel counter |
	
	counter _ 0.
	addToCartWebClientRequestBlock _ [:anAmount :aBookISBN :aCartId |
		self assert: anAmount equals: 1. 
		self assert: aBookISBN equals: 'harry potter'. 
		self assert: aCartId equals: 24. 
		counter _ counter + 1.
	].
	
	storeModel _ StoreWindowModel withWebClient: self cartId: 24  username: 'Valid'  andPassword: 'ValidP'.
	

	storeModel when: #cartContentsUpdated evaluate: [counter _ counter + 1].
	storeModel catalog.
	storeModel catalogIndex: 1.
	
	storeModel addToCart.
	
	self assert: counter equals: 2.
	self assert: storeModel cartContents equals: (Bag with: 'harry potter'). ! !

!StoreWindowModelTest methodsFor: 'tests' stamp: 'tf 7/10/2019 19:08:04'!
test05SiAlAgregarUnElementoElWebClientLevantaUnaExcepcionSeLevantaAlEventoYNoSeModificanLosContenidosDelCarrito
	| storeModel error |
	
	error _ 0.
	addToCartWebClientRequestBlock _ [:anAmount :aBookISBN :aCartId |
		self error: 'super error!!'.
	].
	
	storeModel _ StoreWindowModel withWebClient: self cartId: 24  username: 'Valid'  andPassword: 'ValidP'.
	

	storeModel when: #addToCartFailed evaluate: [:anError | error _ anError ].
	storeModel catalog.
	storeModel catalogIndex: 1.
	
	storeModel addToCart.
	
	self assert: error equals: 'super error!!'.
	self assert: storeModel cartContents equals: (Bag new). ! !

!StoreWindowModelTest methodsFor: 'tests' stamp: 'tf 7/10/2019 18:07:03'!
test06ElValorDeCartContentsIndexComienzaEn0
	| storeModel |
	
	storeModel _ StoreWindowModel withWebClient: self cartId: 23  username: 'Valid'  andPassword: 'ValidP'.

	self assert: storeModel cartContentsIndex equals: 0.! !

!StoreWindowModelTest methodsFor: 'tests' stamp: 'tf 7/10/2019 18:07:42'!
test07PuedoCambiarElValorDeCartContentsIndex
	| storeModel |
	
	storeModel _ StoreWindowModel withWebClient: self cartId: 23  username: 'Valid'  andPassword: 'ValidP'.
	storeModel cartContentsIndex: 42.
	self assert: storeModel cartContentsIndex equals: 42.! !

!StoreWindowModelTest methodsFor: 'tests' stamp: 'tf 7/10/2019 18:22:52'!
test08ElValorDelSubTotalComienzaEn0
	| storeModel |
	
	storeModel _ StoreWindowModel withWebClient: self cartId: 23  username: 'Valid'  andPassword: 'ValidP'.

	self assert: storeModel subTotal equals: 0.! !

!StoreWindowModelTest methodsFor: 'tests' stamp: 'tf 7/10/2019 18:26:45'!
test09AlAgregarUnElementoSeIncrementaAcordeElSubTotal
	| storeModel |
	

	storeModel _ StoreWindowModel withWebClient: self cartId: 24  username: 'Valid'  andPassword: 'ValidP'.
	

	storeModel when: #cartContentsUpdated evaluate: [].
	storeModel catalog.
	storeModel catalogIndex: 1.
	
	storeModel addToCart.
	
	self assert: storeModel subTotal equals: 231. 
	
	storeModel catalogIndex: 2.
	
	storeModel addToCart.
	
	self assert: storeModel subTotal equals: 231 + 23. ! !


!StoreWindowModelTest methodsFor: 'setUp/tearDown' stamp: 'tf 7/10/2019 17:31:50'!
setUp
	catalogWebClientRequestBlock _ [
		self defaultCatalog .
	].

	addToCartWebClientRequestBlock _ [:anAmount :aBookISBN :aCartId | ].! !


!StoreWindowModelTest methodsFor: 'test - private' stamp: 'tf 7/10/2019 17:03:10'!
defaultCatalog
	^Dictionary new
		at: 'valid' put: 23;
		at: 'harry potter' put: 231;
		yourself ! !


!StoreWindowModelTest methodsFor: 'webclient protocol' stamp: 'tf 7/10/2019 17:21:10'!
add: bookQuantity of: bookISBN toCartIdentifiedAs: cartId
	addToCartWebClientRequestBlock value: bookQuantity value: bookISBN  value: cartId .! !

!StoreWindowModelTest methodsFor: 'webclient protocol' stamp: 'tf 7/10/2019 17:18:19'!
catalog
	^catalogWebClientRequestBlock value.! !


!classDefinition: #TusLibrosServerControllerTest category: #'TusLibros-Web'!
TestCase subclass: #TusLibrosServerControllerTest
	instanceVariableNames: 'port aSystemFacade testObjectsFactory storeTestObjectsFactory aDefaultServerController'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Web'!

!TusLibrosServerControllerTest methodsFor: 'test - port' stamp: 'tf 7/10/2019 12:45:44'!
test02PuedoCrearUnaInstanciaDelServidorQueEscucheEnUnPuertoEspecifico
	| aServerController |
	
	aServerController _ TusLibrosServerController listeningOn: 8888 withFacade: aSystemFacade.
	
	self assert: aServerController port equals: 8888.
	
	aServerController stopListening ; destroy .! !

!TusLibrosServerControllerTest methodsFor: 'test - port' stamp: 'ar 7/7/2019 15:46:46'!
test03ElServerNoPuedeEscucharEnUnPuertoNegativo
	
	self should: [TusLibrosServerController listeningOn: -1 withFacade: aSystemFacade ]
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo: [:anError |
			self assert: anError messageText equals: TusLibrosServerController invalidPortNumberMessageError	
		].! !

!TusLibrosServerControllerTest methodsFor: 'test - port' stamp: 'ar 7/7/2019 15:46:52'!
test04ElServerNoPuedeEscucharEnUnMayorA65535
	
	self should: [TusLibrosServerController listeningOn: 3598102 withFacade: aSystemFacade ]
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo: [:anError |
			self assert: anError messageText equals: TusLibrosServerController invalidPortNumberMessageError	
		].! !

!TusLibrosServerControllerTest methodsFor: 'test - port' stamp: 'ar 7/7/2019 15:46:59'!
test05ElNumeroDePuertoTieneQueSerEntero
	
	self should: [TusLibrosServerController listeningOn: 80.5 withFacade: aSystemFacade ]
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo: [:anError |
			self assert: anError messageText equals: TusLibrosServerController invalidPortNumberMessageError	
		].! !


!TusLibrosServerControllerTest methodsFor: 'setUp/tearDown' stamp: 'TF 7/9/2019 14:07:15'!
port
	^8484! !

!TusLibrosServerControllerTest methodsFor: 'setUp/tearDown' stamp: 'TF 7/9/2019 14:07:05'!
setUp
	testObjectsFactory _ TusLibrosWebTestObjectFactory new.
	aSystemFacade _ testObjectsFactory tusLibrosSystemFacade. 
	aDefaultServerController _ TusLibrosServerController listeningOn: self port withFacade: aSystemFacade.! !

!TusLibrosServerControllerTest methodsFor: 'setUp/tearDown' stamp: 'TF 7/9/2019 14:08:30'!
tearDown
	
	aDefaultServerController stopListening .
	aDefaultServerController destroy .! !


!TusLibrosServerControllerTest methodsFor: 'test - create cart' stamp: 'tf 7/11/2019 11:48:59'!
test06ElServidorDeTusLibrosTieneUnEndpointParaCrearUnCarrito
	
	self assert: 
		(aDefaultServerController webServer endpoints includes: TusLibrosServerController createCartEndpoint). ! !

!TusLibrosServerControllerTest methodsFor: 'test - create cart' stamp: 'tf 7/11/2019 12:38:19'!
test07IntentarCrearUnCarritoConUnUsuarioMalAutenticadoGeneraUnaRespuestaDeError404
	| httpResponse queryParams |
	
	queryParams _ Dictionary newFromPairs:  { 
		'user' . self encode: testObjectsFactory invalidUser . 
		'password' . self encode: testObjectsFactory invalidUserPassword
	}.
	httpResponse _ 
		WebClient htmlSubmit: (self urlFor: TusLibrosServerController createCartEndpoint)
					 fields: queryParams.
	
	self deny: httpResponse isSuccess.
	self assert: httpResponse code = 404.
	self assert: httpResponse content equals: 'key not found'.! !

!TusLibrosServerControllerTest methodsFor: 'test - create cart' stamp: 'tf 7/11/2019 12:39:20'!
test08AlCrearUnCarritoConUnUsuarioValidoTengoUnaRespuesta200
	| httpResponse queryParams |
	
	queryParams _ Dictionary newFromPairs:  { 
		'username' . self encode: testObjectsFactory validUser . 
		'password' . self encode: testObjectsFactory validUserPassword 
	}.
	httpResponse _ 
		WebClient htmlSubmit: (self urlFor: TusLibrosServerController createCartEndpoint)
					 fields: queryParams.
	
	self assert: httpResponse isSuccess.
	self assert: httpResponse code = 200.! !


!TusLibrosServerControllerTest methodsFor: 'test - add items' stamp: 'tf 7/11/2019 11:52:41'!
test09ElServidorDeTusLibrosTieneUnEndpointParaAgregarItemsAlCarrito
	
	self assert: 
		(aDefaultServerController webServer endpoints includes: TusLibrosServerController addToCartEndpoint). ! !

!TusLibrosServerControllerTest methodsFor: 'test - add items' stamp: 'tf 7/11/2019 12:39:35'!
test10ReciboUnaRespuesta200AlAgregarItemsAlCarrito
	| cartId queryParams addToCartResponse|
	
	cartId _ self createCart .
	
	queryParams _ Dictionary newFromPairs: { 
			'cartId' . self encode: cartId printString . 
			'bookISBN' . self encode: testObjectsFactory storeTestObjectsFactory itemSellByTheStore . 
			'bookQuantity' . self encode: '3' 
	}.
	addToCartResponse  _ 
		WebClient htmlSubmit: (self urlFor: TusLibrosServerController addToCartEndpoint ) 
					 fields: queryParams.

	self assert: addToCartResponse isSuccess .
	self assert: addToCartResponse code = 200.! !

!TusLibrosServerControllerTest methodsFor: 'test - add items' stamp: 'tf 7/11/2019 12:39:59'!
test11ReciboUnaRespuesta404AlAgregarItemsDeUnLibroInexistente
	| queryParams addToCartResponse cartId |
	
	cartId _ self createCart .
	
	queryParams _ Dictionary newFromPairs: { 
		'cartId' . self encode: cartId printString . 
		'bookISBN' . self encode: testObjectsFactory storeTestObjectsFactory itemNotSellByTheStore . 
		'bookQuantity' . self encode: '3' 
	}.
	addToCartResponse  _ 
		WebClient htmlSubmit: (self urlFor: TusLibrosServerController addToCartEndpoint ) 
					 fields: queryParams.
	
	self deny: addToCartResponse isSuccess .
	self assert: addToCartResponse code = 404.
	self assert: addToCartResponse content = 'Item is not in catalog'.! !

!TusLibrosServerControllerTest methodsFor: 'test - add items' stamp: 'tf 7/11/2019 12:40:06'!
test12ReciboUnaRespuesta404AlAgregarItemsAUnCarritoInexistente
	| queryParams addToCartResponse|
	
	queryParams _ Dictionary newFromPairs: { 
		'cartId' . self encode: '-1835140' . 
		'bookISBN' . self encode: testObjectsFactory storeTestObjectsFactory itemSellByTheStore . 
		'bookQuantity' . self encode: '3' 
	}.
	addToCartResponse  _ 
		WebClient htmlSubmit: (self urlFor: TusLibrosServerController addToCartEndpoint ) 
					 fields: queryParams.
	
	self assert: addToCartResponse code = 404.
	self assert: addToCartResponse content = 'Invalid cart id'.! !


!TusLibrosServerControllerTest methodsFor: 'test - catalogo' stamp: 'tf 7/11/2019 11:54:15'!
test18ElServidorDeTusLibrosTieneUnEndpointParaHacerCatalogDelSistema
	
	self assert: 
		(aDefaultServerController webServer endpoints includes: TusLibrosServerController catalogEndpoint). ! !

!TusLibrosServerControllerTest methodsFor: 'test - catalogo' stamp: 'tf 7/11/2019 11:54:35'!
test19AlPedirElCatalogoMeLoDevuelveConCodigo200
	| catalogResponse aCatalog |

		
	catalogResponse _ 
		WebClient htmlSubmit: (self urlFor: TusLibrosServerController catalogEndpoint ) 
					 fields: Dictionary new.
		
	
	self assert: catalogResponse code equals: 200.
	
	aCatalog _ WebUtils jsonDecode: catalogResponse content readStream .
	self assert: aCatalog notEmpty .
	self assert: aCatalog equals: aSystemFacade catalog . 
	
		! !


!TusLibrosServerControllerTest methodsFor: 'test - checkout' stamp: 'tf 7/11/2019 11:55:06'!
test13ElServidorDeTusLibrosTieneUnEndpointParaHacerCheckoutDelCarrito
	
	self assert: 
		(aDefaultServerController webServer endpoints includes: TusLibrosServerController checkoutCartEndpoint). ! !

!TusLibrosServerControllerTest methodsFor: 'test - checkout' stamp: 'tf 7/11/2019 12:41:23'!
test14AlHacerCheckoutDeUnCarritoConElementosObtengoUnaRespuestaConCodigo200
	| cartId queryParams checkOutResponse expirationDate |
	
	cartId _ self createCart .
	self addToCartWithDefaultValuesWithCartId: cartId .
	
	expirationDate _ self encode: testObjectsFactory storeTestObjectsFactory notExpiredMonthOfYear printString.
	queryParams _ Dictionary newFromPairs: 
		{'cartId' . self encode: cartId printString . 
		'creditCardNumber' . self encode: testObjectsFactory storeTestObjectsFactory notExpiredCreditCardNumber . 
		'ownersName' . self encode: testObjectsFactory storeTestObjectsFactory notExpiredCreditCardOwner . 
		'expirationDate' . expirationDate }.
		
	checkOutResponse _ 
		WebClient htmlSubmit: (self urlFor: TusLibrosServerController checkoutCartEndpoint ) 
					 fields: queryParams .
		
	self assert: checkOutResponse code equals: 200.
	
		! !

!TusLibrosServerControllerTest methodsFor: 'test - checkout' stamp: 'tf 7/11/2019 12:41:40'!
test15AlHacerCheckoutDeUnCarritoInexistenteObtengoUnaRespuestaConCodigo404YMensajeDeError
	| cartId queryParams checkOutResponse expirationDate |
	
	cartId _ -10.
	
	expirationDate _ self encode: testObjectsFactory storeTestObjectsFactory notExpiredMonthOfYear printString.
	queryParams _ Dictionary newFromPairs: 
		{'cartId' . self encode: cartId printString . 
		'creditCardNumber' . self encode: testObjectsFactory storeTestObjectsFactory notExpiredCreditCardNumber . 
		'ownersName' . self encode: testObjectsFactory storeTestObjectsFactory notExpiredCreditCardOwner . 
		'expirationDate' . expirationDate }.
		
	checkOutResponse _ 
		WebClient htmlSubmit: (self urlFor: TusLibrosServerController checkoutCartEndpoint ) 
					 fields: queryParams .
					
	self assert: checkOutResponse code equals: 404.
	self assert: checkOutResponse content equals: 'Invalid cart id'
	
		! !

!TusLibrosServerControllerTest methodsFor: 'test - checkout' stamp: 'tf 7/11/2019 12:41:56'!
test16AlHacerCheckoutDeUnCarritoVacioObtengoUnaRespuestaConCodigo404YUnMensajeDeError
	| cartId queryParams checkOutResponse expirationDate |
	
	cartId _ self createCart .
	
	expirationDate _ self encode: testObjectsFactory storeTestObjectsFactory notExpiredMonthOfYear printString.
	queryParams _ Dictionary newFromPairs: 
		{'cartId' . self encode: cartId printString . 
		'creditCardNumber' . self encode: testObjectsFactory storeTestObjectsFactory notExpiredCreditCardNumber . 
		'ownersName' . self encode: testObjectsFactory storeTestObjectsFactory notExpiredCreditCardOwner . 
		'expirationDate' . expirationDate }.
		
	checkOutResponse _ 
		WebClient htmlSubmit: (self urlFor: TusLibrosServerController checkoutCartEndpoint ) 
					 fields: queryParams .
						
	self assert: checkOutResponse code equals: 404.
	self assert: checkOutResponse content equals: 'Can not check out an empty cart'.
	
		! !

!TusLibrosServerControllerTest methodsFor: 'test - checkout' stamp: 'tf 7/11/2019 12:42:11'!
test17AlHacerCheckoutDeUnCarritoConElementosConUnaTarjetaInvalidaObtengoUnaRespuestaConCodigo404YUnMensajeDeError
	| cartId queryParams checkOutResponse expirationDate |
	
	cartId _ self createCart .
	
	self addToCartWithDefaultValuesWithCartId: cartId .
	
	expirationDate _ self encode: testObjectsFactory storeTestObjectsFactory expiredMonthOfYear printString.
	queryParams _ Dictionary newFromPairs: 
		{'cartId' . self encode: cartId printString . 
		'creditCardNumber' . self encode: testObjectsFactory storeTestObjectsFactory notExpiredCreditCardNumber . 
		'ownersName' . self encode: testObjectsFactory storeTestObjectsFactory notExpiredCreditCardOwner . 
		'expirationDate' . expirationDate }.
		
	checkOutResponse _ 
		WebClient htmlSubmit: (self urlFor: TusLibrosServerController checkoutCartEndpoint ) 
					 fields: queryParams .
						
	self assert: checkOutResponse code equals: 404.
	self assert: checkOutResponse content equals: 'Can not charge an expired credit card'.
	
		! !


!TusLibrosServerControllerTest methodsFor: 'test - list purchase' stamp: 'tf 7/11/2019 11:57:54'!
test20ElServidorDeTusLibrosTieneUnEndpointParaHacerListPurchases
	
	self assert: 
		(aDefaultServerController webServer endpoints includes: TusLibrosServerController listPurchasesEndpoint). ! !

!TusLibrosServerControllerTest methodsFor: 'test - list purchase' stamp: 'tf 7/11/2019 12:42:20'!
test21ListPurchasesDeUnUsuarioQueNoHizoComprasDevuelveCodigo200YListaVacia
	| queryParams listPurchasesResponse |
	
	queryParams _ Dictionary newFromPairs: 
		{'username' . self encode: testObjectsFactory validUser . 
		  'password' . self encode: testObjectsFactory validUserPassword }.
		
	listPurchasesResponse _ WebClient htmlSubmit: 'http://localhost:8484/listpurchases' fields: queryParams .
		
	self assert: listPurchasesResponse code equals: 200.
	
		! !

!TusLibrosServerControllerTest methodsFor: 'test - list purchase' stamp: 'tf 7/11/2019 12:42:40'!
test22AlPedirLasComprasDeUnUsuarioConComprasReciboCodigo200YDiccionarioAcorde
	| cartId queryParams expirationDate purchasesResponse |
	
	cartId _ self createCart .
	
	self addToCartWithDefaultValuesWithCartId: cartId .
	
	
	expirationDate _ self encode: testObjectsFactory storeTestObjectsFactory notExpiredMonthOfYear printString.
	queryParams _ Dictionary newFromPairs: 
		{'cartId' . self encode: cartId printString . 
		'creditCardNumber' . self encode: testObjectsFactory storeTestObjectsFactory notExpiredCreditCardNumber . 
		'ownersName' . self encode: testObjectsFactory storeTestObjectsFactory notExpiredCreditCardOwner . 
		'expirationDate' . expirationDate }.
		
	WebClient htmlSubmit: 'http://localhost:8484/checkoutcart' fields: queryParams .
	
	queryParams _ Dictionary newFromPairs: 
		{'username' . self encode: testObjectsFactory validUser . 
		  'password' . self encode: testObjectsFactory validUserPassword }.
		
	purchasesResponse _ WebClient htmlSubmit: 'http://localhost:8484/listpurchases'  fields: queryParams.
		
	self assert: purchasesResponse code equals: 200.
	self assert: (WebUtils jsonDecode: (purchasesResponse content readStream )) 
		equals: (Dictionary new 
					at: 'validBook' 
					put: 3*(testObjectsFactory storeTestObjectsFactory itemSellByTheStorePrice); yourself ).
	
		! !

!TusLibrosServerControllerTest methodsFor: 'test - list purchase' stamp: 'tf 7/11/2019 12:42:48'!
test23AlPedirLasComprasDeUnUsuarioMalAutenticadoReciboError404ConMensajeAcorde
	| queryParams purchasesResponse |

	queryParams _ Dictionary newFromPairs: 
		{'username' . self encode: testObjectsFactory invalidUser . 
		  'password' . self encode: testObjectsFactory invalidUserPassword }.
		
	purchasesResponse _ WebClient htmlSubmit: 'http://localhost:8484/listpurchases'  fields: queryParams.
		
	self assert: purchasesResponse code equals: 404.
	self assert: purchasesResponse content
		equals: 'Invalid user and/or password'.
	
		! !


!TusLibrosServerControllerTest methodsFor: 'helpers' stamp: 'tf 7/11/2019 12:42:56'!
addToCartWithDefaultValuesWithCartId: cartId
	| queryParams |
	
	queryParams _ Dictionary newFromPairs: { 
		'cartId' . self encode: cartId printString . 
		'bookISBN' . self encode: testObjectsFactory storeTestObjectsFactory itemSellByTheStore . 
		'bookQuantity' . self encode: '3' 
	}.
	WebClient htmlSubmit: (self urlFor: TusLibrosServerController addToCartEndpoint) fields: queryParams.! !

!TusLibrosServerControllerTest methodsFor: 'helpers' stamp: 'tf 7/11/2019 12:43:01'!
createCart
	| cartCreationResponse cartId queryParams |
	
	queryParams _ Dictionary newFromPairs: 
		{'username' . self encode: testObjectsFactory validUser . 
		  'password' . self encode: testObjectsFactory validUserPassword }.
	
	cartCreationResponse _ WebClient htmlSubmit: 'http://localhost:8484/createCart' fields: queryParams.
	cartId _ WebUtils jsonDecode: cartCreationResponse content readStream.
	
	^cartId .! !

!TusLibrosServerControllerTest methodsFor: 'helpers' stamp: 'tf 7/11/2019 12:55:16'!
decode: anJsonEncoding
	^(WebUtils jsonDecode: anJsonEncoding readStream) copyReplaceAll: '%20' with: ' ' .! !

!TusLibrosServerControllerTest methodsFor: 'helpers' stamp: 'tf 7/11/2019 12:51:56'!
encode: anObject
	^(WebUtils jsonEncode: anObject) copyReplaceAll: ' ' with: '%20' .! !

!TusLibrosServerControllerTest methodsFor: 'helpers' stamp: 'tf 7/11/2019 11:51:02'!
urlFor: aMethodName
	^'http://localhost:8484', aMethodName. ! !


!classDefinition: #TusLibrosWebClientTest category: #'TusLibros-Web'!
TestCase subclass: #TusLibrosWebClientTest
	instanceVariableNames: 'port onHtmlSubmitBlock defaultWebClient testObjectFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Web'!

!TusLibrosWebClientTest methodsFor: 'test - port' stamp: 'ar 7/7/2019 11:42:55'!
test01ElClienteEnviaPorDefectoAlPuerto8080

	| webClient |
	
	webClient _ TusLibrosWebClient new.
	
	self assert: (webClient port = 8080).! !

!TusLibrosWebClientTest methodsFor: 'test - port' stamp: 'ar 7/7/2019 11:53:20'!
test02PuedoSetearAlClienteParaQueEnvieAUnPuertoEspecifico

	| webClient |
	
	webClient _ TusLibrosWebClient sendingToPort: 9876.
	
	self assert: (webClient port = 9876).! !

!TusLibrosWebClientTest methodsFor: 'test - port' stamp: 'ar 7/7/2019 11:53:20'!
test03ElClienteNoPuedeEnviarAUnPuertoNegativo
	self should: [TusLibrosWebClient sendingToPort: -1]
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo: [:anError |
			self assert: anError messageText equals: TusLibrosWebClient invalidPortNumberMessageError	
		].! !

!TusLibrosWebClientTest methodsFor: 'test - port' stamp: 'ar 7/7/2019 11:53:20'!
test04ElClienteNoPuedeEnviarAUnPuertoMayorA65535

	| webClient |
	
	self should: [webClient _ TusLibrosWebClient sendingToPort: 987654]
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo: [:anError |
			self assert: anError messageText equals: TusLibrosWebClient invalidPortNumberMessageError	
		].! !

!TusLibrosWebClientTest methodsFor: 'test - port' stamp: 'ar 7/7/2019 11:53:20'!
test05ElNumeroDePuertoDelClienteTieneQueSerUnNumeroEntero

	| webClient |
	
	self should: [webClient _ TusLibrosWebClient sendingToPort: 1.31]
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo: [:anError |
			self assert: anError messageText equals: TusLibrosWebClient invalidPortNumberMessageError	
		].! !


!TusLibrosWebClientTest methodsFor: 'test - list purchases' stamp: 'tf 7/11/2019 12:56:03'!
test14PuedoListarLasComprasDeUnUsuario
	| listPurchaseResponse|
		
	onHtmlSubmitBlock _ [:url :fields | 
		self assert: url equals: 'http://tusLibros.com:8484/listpurchases'.
		self assert: (self decode: (fields at: 'username')) equals: 'Teo' .
		self assert: (self decode: (fields at: 'password')) equals: 'freund'.
		
		(WebResponse protocol: 'http' code: 200) content: (WebUtils jsonEncode: '123') 
	].

	listPurchaseResponse _ defaultWebClient listPurchasesOf: 'Teo' authenticatingWith: 'freund'. 
	
	self assert: listPurchaseResponse equals: '123'.
! !

!TusLibrosWebClientTest methodsFor: 'test - list purchases' stamp: 'tf 7/9/2019 23:15:19'!
test15PuedoListarLasComprasDeUnUsuario
		
	onHtmlSubmitBlock _ [:url :fields | 
		(WebResponse protocol: 'http' code: 404) content: 'Error' 
	].

	self should: [defaultWebClient listPurchasesOf: 'Teo' authenticatingWith: 'freund'] 
		raise: Error - MessageNotUnderstood  
		withMessageText: 'Error'. 
	! !


!TusLibrosWebClientTest methodsFor: 'setUp/tearDown' stamp: 'TF 7/9/2019 15:19:19'!
setUp
	onHtmlSubmitBlock _ [:a :b |].
	defaultWebClient _ TusLibrosWebClient sendingToPort: 8484 withUrl: 'http://tusLibros.com'  withWebClient: self. 
	testObjectFactory _ TusLibrosWebTestObjectFactory new.! !


!TusLibrosWebClientTest methodsFor: 'webclient protocol' stamp: 'TF 7/9/2019 15:28:40'!
htmlSubmit: url fields: fields
	^onHtmlSubmitBlock value: url value: fields.! !


!TusLibrosWebClientTest methodsFor: 'test - createcart' stamp: 'tf 7/11/2019 12:56:41'!
test06PuedoCrearUnCarritoConUsuarioYContrasenaValidosYObtengoUnCartIdYSeLeEnviaElRequestAlServidor
	| cartId |
		
	onHtmlSubmitBlock _ [:url :fields | 
		self assert: url equals: 'http://tusLibros.com:8484/createcart'.
		self assert: (self decode: (fields at: 'username')) equals: testObjectFactory validUser .
		self assert: (self decode: (fields at: 'password')) equals: testObjectFactory validUserPassword .
		^(WebResponse protocol: 'http' code: 200) content: (WebUtils jsonEncode: 23); yourself. 
	].

	cartId _ defaultWebClient createCartFor: testObjectFactory validUser authenticatedWith: testObjectFactory validUserPassword .
	
	self assert: cartId equals: 23.! !

!TusLibrosWebClientTest methodsFor: 'test - createcart' stamp: 'tf 7/9/2019 23:06:53'!
test07SiElRequestAlServidorDeCrearUnCarritoDaErrorElWebClientLevantaUnaExcepcion
		
	onHtmlSubmitBlock _ [:url :fields | 
		^(WebResponse protocol: 'http' code: 404) content: 'Error!!'; yourself. 
	].

	self should: [defaultWebClient createCartFor: testObjectFactory validUser authenticatedWith: testObjectFactory validUserPassword ]
		 raise:  Error - MessageNotUnderstood 
		withMessageText: 'Error!!'.
	
! !


!TusLibrosWebClientTest methodsFor: 'test - catalog' stamp: 'ar 7/9/2019 19:50:51'!
test08PuedoPedirElCatalogoDeLibrosDelServidor
	| catalogResponse catalog|
	
	catalog _ Dictionary newFromPairs: {'book1' . 23 . 'book2' . 300 . 'book3'. 1000}.
		
	onHtmlSubmitBlock _ [:url :fields | 
		self assert: url equals: 'http://tusLibros.com:8484/catalog'.
		(WebResponse protocol: 'http' code: 200) content: (WebUtils jsonEncode: catalog) 
	].

	catalogResponse _ defaultWebClient catalog.
	
	self assert: catalogResponse equals: catalog.
! !

!TusLibrosWebClientTest methodsFor: 'test - catalog' stamp: 'tf 7/10/2019 12:18:26'!
test09SiAlPedirElCatalogoElServidorDevuelveUnErrorElWebClientLevantaUnaEXcepcion
		
	onHtmlSubmitBlock _ [:url :fields | 
		(WebResponse protocol: 'http' code: 404) content: 'Error!!!!' 
	].

	self should: [defaultWebClient catalog ]
		raise: Error - MessageNotUnderstood 
		withMessageText: 'Error!!!!'.
! !


!TusLibrosWebClientTest methodsFor: 'test - add to cart' stamp: 'tf 7/11/2019 12:57:05'!
test10PuedoAgregarCosasAUnCarrito
	| addToCartResponse|
		
	onHtmlSubmitBlock _ [:url :fields | 
		self assert: url equals: 'http://tusLibros.com:8484/addtocart'.
		self assert: (self decode: (fields at: 'cartId')) equals: 23 printString .
		self assert: (self decode: (fields at: 'bookISBN')) equals: 'validBook'.
		self assert: (self decode: (fields at: 'bookQuantity')) equals: 3 printString .
		(WebResponse protocol: 'http' code: 200) content: (WebUtils jsonEncode: 0) 
	].

	addToCartResponse _ defaultWebClient add: 3 of: 'validBook' toCartIdentifiedAs: 23 .
	
	self assert: addToCartResponse equals: 0.
! !

!TusLibrosWebClientTest methodsFor: 'test - add to cart' stamp: 'tf 7/9/2019 23:05:51'!
test11SiElServerDaUnErrorAlAgregarCosasAUnCarritoLevantoUnaExcepcion

		
	onHtmlSubmitBlock _ [:url :fields | 
		(WebResponse protocol: 'http' code: 404) content: 'Error!!'.
	].

	self should: [defaultWebClient add: 3 of: 'validBook' toCartIdentifiedAs: 23] 
		raise: Error - MessageNotUnderstood 
		withMessageText: 'Error!!'.

	

! !


!TusLibrosWebClientTest methodsFor: 'test - checkout' stamp: 'tf 7/11/2019 13:01:16'!
test12PuedoHacerCheckoutDeUnCarrito
	| checkoutResponse|
		
	onHtmlSubmitBlock _ [:url :fields | 
		self assert: url equals: 'http://tusLibros.com:8484/checkoutcart'.
		self assert: (self decode: (fields at: 'cartId')) equals: 23 printString .
		self assert: (self decode: (fields at: 'creditCardNumber')) equals: '0000111122223333'.
		self assert: (self decode: (fields at: 'ownersName')) equals: 'Teo'.
		self assert: (self decode: (fields at: 'expirationDate')) 
			equals: (Month month: 07 year: 2020 ) printString .
			
		(WebResponse protocol: 'http' code: 200) content: (WebUtils jsonEncode: 0) 
	].

	checkoutResponse _ defaultWebClient 
		checkOutCartIdentifiedAs: 23 
		withCreditCardNumbered: '0000111122223333' 
		ownedBy: 'Teo' 
		expiringOn: (Month month: 07 year: 2020) .
	
	self assert: checkoutResponse equals: 0.
! !

!TusLibrosWebClientTest methodsFor: 'test - checkout' stamp: 'tf 7/10/2019 12:20:31'!
test13LevantaUnaExcepcionAlRecibirUnErrorDelServerSiSeLePideHacerCheckout
		
	onHtmlSubmitBlock _ [:url :fields | 
		(WebResponse protocol: 'http' code: 404) content: 'Error'. 
	].

	self should: [
			defaultWebClient 
				checkOutCartIdentifiedAs: 23 
				withCreditCardNumbered: '0000111122223333' 
				ownedBy: 'Teo' 
				expiringOn: (Month month: 07 year: 2020) .]
		 raise: Error -  MessageNotUnderstood 
		 withMessageText: 'Error'.
	! !


!TusLibrosWebClientTest methodsFor: 'encoding' stamp: 'tf 7/11/2019 12:55:20'!
decode: anJsonEncoding
	^(WebUtils jsonDecode: anJsonEncoding readStream) copyReplaceAll: '%20' with: ' ' .! !

!TusLibrosWebClientTest methodsFor: 'encoding' stamp: 'tf 7/11/2019 12:55:00'!
encode: anObject
	^(WebUtils jsonEncode: anObject) copyReplaceAll: ' ' with: '%20' .! !


!classDefinition: #CheckOutWindowModel category: #'TusLibros-Web'!
Object subclass: #CheckOutWindowModel
	instanceVariableNames: 'cartId username password creditCardNumber ownersName expirationDate webClient transcript'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Web'!

!CheckOutWindowModel methodsFor: 'accessing' stamp: 'tf 7/11/2019 00:13:16'!
creditCardNumber
	^creditCardNumber! !

!CheckOutWindowModel methodsFor: 'accessing' stamp: 'tf 7/11/2019 00:14:01'!
creditCardNumber: aString 
	
	creditCardNumber _ aString! !

!CheckOutWindowModel methodsFor: 'accessing' stamp: 'tf 7/11/2019 00:19:07'!
expirationDate
	^expirationDate.! !

!CheckOutWindowModel methodsFor: 'accessing' stamp: 'tf 7/11/2019 00:19:52'!
expirationDate: aString 
	
	expirationDate _ aString! !

!CheckOutWindowModel methodsFor: 'accessing' stamp: 'tf 7/11/2019 00:15:25'!
ownersName
	^ownersName.! !

!CheckOutWindowModel methodsFor: 'accessing' stamp: 'tf 7/11/2019 00:16:01'!
ownersName: aString 
	
	ownersName _ aString! !

!CheckOutWindowModel methodsFor: 'accessing' stamp: 'tf 7/11/2019 09:56:48'!
transcript
	^transcript.! !


!CheckOutWindowModel methodsFor: 'events' stamp: 'tf 7/11/2019 13:07:28'!
checkout

	[
		webClient checkOutCartIdentifiedAs: cartId 
					withCreditCardNumbered:  creditCardNumber string
					ownedBy: ownersName  string
					expiringOn: (Month readFrom: expirationDate readStream).
		creditCardNumber _ creditCardNumber last: 4.
		self triggerEvent: #paymentDone.
		self updateTranscript.
		self triggerEvent: #updateTranscript.
		
	] on: Error 
	do: [:anError | self triggerEvent: #paymentFailed: with: anError messageText ].! !

!CheckOutWindowModel methodsFor: 'events' stamp: 'tf 7/11/2019 13:07:42'!
updateTranscript
	| originalTranscript |
	originalTranscript _ webClient listPurchasesOf: username string authenticatingWith: password string .
	
	transcript _ OrderedCollection new.
	originalTranscript keysAndValuesDo: [:key :value | transcript add: key, ' $', value printString ].! !


!CheckOutWindowModel methodsFor: 'initialization' stamp: 'tf 7/11/2019 09:57:01'!
initializeWithWebClient: aWebClient cartId: aCartId username: aUsername password: aPassword 
	webClient _ aWebClient .
	cartId _ aCartId .
	username _ aUsername .
	password _ aPassword .
	
	creditCardNumber _ ''.
	ownersName _ ''.
	expirationDate _ ''.
	transcript _ OrderedCollection new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CheckOutWindowModel class' category: #'TusLibros-Web'!
CheckOutWindowModel class
	instanceVariableNames: ''!

!CheckOutWindowModel class methodsFor: 'as yet unclassified' stamp: 'tf 7/11/2019 09:55:12'!
withCartId: aCartId username: aUsername password: aPassword 
	^self  withWebClient: TusLibrosWebClient new cartId: aCartId username: aUsername password: aPassword .! !

!CheckOutWindowModel class methodsFor: 'as yet unclassified' stamp: 'tf 7/11/2019 09:21:08'!
withWebClient: aWebClient cartId: aCartId username: aUsername password: aPassword
	^self new initializeWithWebClient: aWebClient cartId: aCartId  username: aUsername  password: aPassword .
	! !


!classDefinition: #CreateCartWindowModel category: #'TusLibros-Web'!
Object subclass: #CreateCartWindowModel
	instanceVariableNames: 'username password webClient cartId catalog catalogIndex cartContents cartContentsIndex listableCatalog catalogAsDict'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Web'!

!CreateCartWindowModel methodsFor: 'catalog' stamp: 'ar 7/9/2019 21:03:43'!
sendCatalogRequest
	catalogAsDict _ webClient catalog.
	catalog _ OrderedCollection new.
	catalogAsDict keysAndValuesDo: [ :titulo :valor | catalog add: titulo, '  $', valor asString].
	self triggerEvent: #catalogArrived.! !


!CreateCartWindowModel methodsFor: 'cart contents' stamp: 'TF 7/9/2019 16:14:41'!
cartId

	^cartId! !


!CreateCartWindowModel methodsFor: 'window transitions' stamp: 'tf 7/10/2019 17:53:20'!
goToStore
	StoreWindow withCartId: cartId username: username password: password .
! !


!CreateCartWindowModel methodsFor: 'initialization' stamp: 'ar 7/9/2019 21:02:40'!
initialize
	webClient _ TusLibrosWebClient new.
	username _ ''.
	password _ ''.
	catalogIndex _ 0.
	cartContents _ OrderedCollection new.
	cartContentsIndex _ 0.! !

!CreateCartWindowModel methodsFor: 'initialization' stamp: 'TF 7/9/2019 15:55:51'!
initializeWithWebClient: aWebClient
	webClient _ aWebClient.
	username _ ''.
	password _ ''.! !


!CreateCartWindowModel methodsFor: 'TextModelMorphSelectors' stamp: 'TF 7/9/2019 16:47:19'!
password
	^password.! !

!CreateCartWindowModel methodsFor: 'TextModelMorphSelectors' stamp: 'TF 7/9/2019 16:49:35'!
password: aPassword
	password _ aPassword.
	^true.! !

!CreateCartWindowModel methodsFor: 'TextModelMorphSelectors' stamp: 'ar 7/7/2019 11:02:07'!
username
	^username! !

!CreateCartWindowModel methodsFor: 'TextModelMorphSelectors' stamp: 'ar 7/7/2019 11:08:58'!
username: aUsername 
	username _ aUsername.
	^true.! !


!CreateCartWindowModel methodsFor: 'PluggableButtonSelectors' stamp: 'tf 7/11/2019 13:05:05'!
sendCreateCartRequest

	[
		cartId _ webClient createCartFor: username string authenticatedWith: password string.
		self triggerEvent: #cartCreationSuccess .
	] 
	on: Error 
	do: [:anError | self triggerEvent: #cartCreationFailed with: anError messageText]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreateCartWindowModel class' category: #'TusLibros-Web'!
CreateCartWindowModel class
	instanceVariableNames: ''!

!CreateCartWindowModel class methodsFor: 'as yet unclassified' stamp: 'TF 7/9/2019 15:55:23'!
withWebClient: aWebClient
	^self new initializeWithWebClient: aWebClient .! !


!classDefinition: #StoreWindowModel category: #'TusLibros-Web'!
Object subclass: #StoreWindowModel
	instanceVariableNames: 'username password webClient cartId catalog catalogIndex cartContents cartContentsIndex listableCatalog catalogAsDict catalogNames subTotal originalCatalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Web'!

!StoreWindowModel methodsFor: 'accessing' stamp: 'tf 7/10/2019 17:32:37'!
cartContents
	
	^cartContents! !

!StoreWindowModel methodsFor: 'accessing' stamp: 'tf 7/10/2019 18:19:16'!
cartContentsAsOrderedCollection
	| cartContentsAsOrderedCollection |
	
	cartContentsAsOrderedCollection _ OrderedCollection new.
	
	cartContents contents keysDo: [:key | cartContentsAsOrderedCollection add: key, ' #', (cartContents occurrencesOf: key) printString ].
	
	^cartContentsAsOrderedCollection .! !

!StoreWindowModel methodsFor: 'accessing' stamp: 'tf 7/10/2019 18:07:12'!
cartContentsIndex
	
	^cartContentsIndex! !

!StoreWindowModel methodsFor: 'accessing' stamp: 'tf 7/10/2019 18:07:53'!
cartContentsIndex: anIndex 
	
	cartContentsIndex _ anIndex! !

!StoreWindowModel methodsFor: 'accessing' stamp: 'tf 7/10/2019 17:13:24'!
catalog
	
	^catalog ifNil: [self initializeCatalog. catalog] ifNotNil: [catalog]. ! !

!StoreWindowModel methodsFor: 'accessing' stamp: 'tf 7/10/2019 16:58:26'!
catalogIndex
	
	^catalogIndex! !

!StoreWindowModel methodsFor: 'accessing' stamp: 'tf 7/10/2019 17:01:10'!
catalogIndex: anIndex 
	
	catalogIndex _ anIndex! !

!StoreWindowModel methodsFor: 'accessing' stamp: 'tf 7/10/2019 18:23:20'!
subTotal
	^subTotal.! !


!StoreWindowModel methodsFor: 'initialization' stamp: 'tf 7/10/2019 18:25:58'!
initializeCatalog
	
	catalog _ OrderedCollection new.
	catalogNames _ OrderedCollection new.
	[
		originalCatalog _ webClient catalog .
		originalCatalog keysAndValuesDo: [:key :value | 
			catalog add: key, ' $', value printString.
			catalogNames add: key.
		self triggerEvent: #catalogUpdated.
		].
	] on: Error 
		do: [:anError |  self triggerEvent: #catalogRequestFailed with: anError messageText ]! !

!StoreWindowModel methodsFor: 'initialization' stamp: 'tf 7/10/2019 18:23:32'!
initializewithWebClient: aWebClient 
	cartId: aCartId 
	username: aUsername 
	andPassword: aPassword 
	
	webClient _ aWebClient .
	username _ aUsername .
	password _ aPassword .
	cartId _ aCartId .
	
	cartContents _ Bag new.
	catalogIndex _ 0.
	cartContentsIndex _ 0.
	subTotal _ 0.

	
	! !


!StoreWindowModel methodsFor: 'events' stamp: 'tf 7/11/2019 12:33:09'!
addToCart
	| bookName |

	bookName _ catalogNames at: catalogIndex .
	
	[
		webClient add: 1 of: bookName  toCartIdentifiedAs: cartId.
		cartContents add: bookName.
		subTotal _ subTotal + originalCatalog at: bookName .
		self triggerEvent: #cartContentsUpdated.
	] on: Error 
	do: [:anError | self triggerEvent: #addToCartFailed with: anError messageText ].! !

!StoreWindowModel methodsFor: 'events' stamp: 'tf 7/10/2019 18:46:05'!
goToCheckout
	CheckOutWindow withCartId: cartId usernam: username password: password.
	self triggerEvent: #checkOutWindowCreated.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StoreWindowModel class' category: #'TusLibros-Web'!
StoreWindowModel class
	instanceVariableNames: ''!

!StoreWindowModel class methodsFor: 'as yet unclassified' stamp: 'tf 7/10/2019 16:37:26'!
withWebClient: aWebClient cartId: aCartId username: aUsername andPassword: aPassword
	^self new initializewithWebClient: aWebClient cartId: aCartId username: aUsername andPassword: aPassword.! !


!classDefinition: #TusLibrosLocalTester category: #'TusLibros-Web'!
Object subclass: #TusLibrosLocalTester
	instanceVariableNames: 'server debitsMade systemFacade'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Web'!

!TusLibrosLocalTester methodsFor: 'system facade values' stamp: 'tf 7/11/2019 12:24:37'!
createSalesBook
	^OrderedCollection new! !

!TusLibrosLocalTester methodsFor: 'system facade values' stamp: 'tf 7/11/2019 12:28:40'!
defaultCatalog
	^Dictionary new
		at: 'valid Book' put: 32;
		at: 'harry potter' put: 56.7;
		at: 'self help' put: 1;
		yourself.! !

!TusLibrosLocalTester methodsFor: 'system facade values' stamp: 'tf 7/11/2019 12:25:17'!
validUsersAndPasswords
	^Dictionary new at: 'teo' put: 'freund';
						at: 'andy' put: 'radunsky';
						yourself.! !


!TusLibrosLocalTester methodsFor: 'initialization' stamp: 'tf 7/11/2019 12:26:47'!
initialize
	debitsMade _ OrderedCollection new.
	systemFacade _ TusLibrosSystemFacade
		authenticatingWith: self validUsersAndPasswords 
		acceptingItemsOf:  self defaultCatalog
		registeringOn: self createSalesBook 
		debitingThrought: self
		measuringTimeWith: DateAndTime.
	server _ TusLibrosServerController listeningOn: self port withFacade:  systemFacade.
	
	CreateCartWindow open.! !


!TusLibrosLocalTester methodsFor: 'merchant processor protocol' stamp: 'tf 7/11/2019 13:35:47'!
debit: anAmount from: aCreditCard

	debitsMade add: anAmount@aCreditCard .! !


!TusLibrosLocalTester methodsFor: 'port' stamp: 'tf 7/11/2019 12:25:02'!
port
	^8080.! !


!classDefinition: #TusLibrosServerController category: #'TusLibros-Web'!
Object subclass: #TusLibrosServerController
	instanceVariableNames: 'port webServer tusLibrosFacade'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Web'!

!TusLibrosServerController methodsFor: 'accessing' stamp: 'ar 7/7/2019 11:51:07'!
port
	^port.! !

!TusLibrosServerController methodsFor: 'accessing' stamp: 'ar 7/7/2019 14:51:09'!
webServer
	^webServer.! !


!TusLibrosServerController methodsFor: 'services' stamp: 'tf 7/11/2019 12:44:30'!
registerAddToCart
	self addService: self class addToCartEndpoint 
		withBlock: [ :request |
					|cartId bookISBN bookQuantity|
					
					cartId _ (self decode: (request fields at: 'cartId')) asInteger.
					bookISBN _ self decode: (request fields at: 'bookISBN').
					bookQuantity _ (self decode: (request fields at: 'bookQuantity')) asInteger.
					tusLibrosFacade add: bookQuantity of: bookISBN toCartIdentifiedAs: cartId.
					request send200Response: (WebUtils jsonEncode: 0). 
				].
! !

!TusLibrosServerController methodsFor: 'services' stamp: 'tf 7/11/2019 12:04:40'!
registerCatalog
	self addService: self class catalogEndpoint 
		withBlock: [:request |
						request send200Response: (WebUtils jsonEncode: tusLibrosFacade catalog ).
						
					 ].
	! !

!TusLibrosServerController methodsFor: 'services' stamp: 'tf 7/11/2019 12:52:28'!
registerCheckoutCart
	self addService: self class checkoutCartEndpoint 
		withBlock: [:request |
						|cartId creditCardNumber expirationDate ownersName |

						cartId _ (self decode: (request fields at: 'cartId')) asInteger.
						creditCardNumber _ self decode: (request fields at: 'creditCardNumber').
						ownersName _ self decode: (request fields at: 'ownersName').
						expirationDate _ (self decode: (request fields at: 'expirationDate')).
						expirationDate _ Month readFrom: expirationDate readStream .
						
						tusLibrosFacade 
							checkOutCartIdentifiedAs:  cartId 
							withCreditCardNumbered:  creditCardNumber 
							ownedBy:  ownersName 
							expiringOn: expirationDate .
						
						request send200Response: (WebUtils jsonEncode: 0). 
					].
	! !

!TusLibrosServerController methodsFor: 'services' stamp: 'tf 7/11/2019 12:45:27'!
registerCreateCart
	self addService: self class createCartEndpoint 
		withBlock:  [:request |
					| cartId password username |
					
						username _ self decode: (request fields at: 'username').
						password _ self decode: (request fields at: 'password').
						cartId _ tusLibrosFacade createCartFor: username authenticatedWith: password.
						request send200Response: (WebUtils jsonEncode: cartId).
					].
! !

!TusLibrosServerController methodsFor: 'services' stamp: 'tf 7/11/2019 12:53:45'!
registerListPurchases
	self addService:  self class listPurchasesEndpoint 
		withBlock: [:request | | purchases password username |
					
						
							username _ self decode: ( request fields at: 'username').
							password _ self decode: (request fields at: 'password').
							purchases _ tusLibrosFacade listPurchasesOf: username authenticatingWith: password .
							request send200Response: (WebUtils jsonEncode: purchases).
						].
	! !


!TusLibrosServerController methodsFor: 'port' stamp: 'ar 7/7/2019 12:02:40'!
isValidPortNumber: aPort
	^ aPort isInteger  and: [aPort between: 1 and: 65535].! !

!TusLibrosServerController methodsFor: 'port' stamp: 'ar 7/7/2019 11:54:57'!
signalInvalidPort
	self error: self class invalidPortNumberMessageError.! !


!TusLibrosServerController methodsFor: 'initialization' stamp: 'TF 7/9/2019 14:39:39'!
listeningOn: aPort withFacade: aSystemFacade
	(self isValidPortNumber: aPort) ifFalse: [ self signalInvalidPort].
	
	port _ aPort.
	tusLibrosFacade _ aSystemFacade.
	webServer _ WebServer new listenOn: self port.
	
	self registerCreateCart.
	self registerAddToCart.
	self registerCheckoutCart.
	self registerCatalog .
	self registerListPurchases .! !


!TusLibrosServerController methodsFor: 'stopping' stamp: 'TF 7/8/2019 17:02:51'!
destroy
	webServer ifNotNil: [ webServer destroy ].! !

!TusLibrosServerController methodsFor: 'stopping' stamp: 'TF 7/8/2019 17:02:44'!
stopListening
	webServer stopListener.! !


!TusLibrosServerController methodsFor: 'services - private' stamp: 'tf 7/11/2019 12:03:11'!
addService: aServiceName withBlock: aBlock
	webServer addService: aServiceName 
				action: [ :request |
					[aBlock value: request ]
					on: Error
					do: [:anError |
						request send404Response: anError messageText.	
					]
				].! !


!TusLibrosServerController methodsFor: 'decoding' stamp: 'tf 7/11/2019 12:51:40'!
decode: anJsonEncoding
	^(WebUtils jsonDecode: anJsonEncoding readStream) copyReplaceAll: '%20' with: ' ' .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosServerController class' category: #'TusLibros-Web'!
TusLibrosServerController class
	instanceVariableNames: ''!

!TusLibrosServerController class methodsFor: 'endpoints' stamp: 'ar 7/7/2019 16:39:00'!
addToCartEndpoint
	^'/addtocart'.! !

!TusLibrosServerController class methodsFor: 'endpoints' stamp: 'TF 7/9/2019 14:31:30'!
catalogEndpoint
	^'/catalog'.! !

!TusLibrosServerController class methodsFor: 'endpoints' stamp: 'ar 7/7/2019 17:51:22'!
checkoutCartEndpoint
	^'/checkoutcart'.! !

!TusLibrosServerController class methodsFor: 'endpoints' stamp: 'ar 7/7/2019 14:51:03'!
createCartEndpoint
	^'/createcart'.! !

!TusLibrosServerController class methodsFor: 'endpoints' stamp: 'TF 7/9/2019 14:41:22'!
listPurchasesEndpoint
	^'/listpurchases'.! !


!TusLibrosServerController class methodsFor: 'error message' stamp: 'ar 7/7/2019 11:54:31'!
invalidPortNumberMessageError
	^ 'El numero de puerto tiene que ser un numero entero entre 1 y 65535'.! !


!TusLibrosServerController class methodsFor: 'instance creation' stamp: 'ar 7/7/2019 15:14:21'!
listeningOn: aPort withFacade: aSystemFacade
	^self new listeningOn: aPort withFacade: aSystemFacade .! !


!classDefinition: #TusLibrosWebClient category: #'TusLibros-Web'!
Object subclass: #TusLibrosWebClient
	instanceVariableNames: 'port url webClient'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Web'!

!TusLibrosWebClient methodsFor: 'error messages' stamp: 'ar 7/7/2019 11:31:14'!
signalInvalidPort
	self error: self class invalidPortNumberMessageError.! !


!TusLibrosWebClient methodsFor: 'server requests' stamp: 'tf 7/11/2019 12:58:45'!
add: anAmount of: aBook toCartIdentifiedAs: aCartId
	| queryParams response |

	queryParams _ Dictionary new 
			at: 'bookQuantity' put: (self encode: anAmount printString) ; 
			at: 'bookISBN' put: (self encode: aBook); 
			at: 'cartId' put: (self encode: aCartId printString) ; 
			yourself .
	response _ webClient htmlSubmit: (self url, TusLibrosServerController addToCartEndpoint ) fields: queryParams. 
	
	response isSuccess
		ifTrue: [
				^WebUtils jsonDecode: response content readStream .
			]
		ifFalse: [
				self error: response content .
			].! !

!TusLibrosWebClient methodsFor: 'server requests' stamp: 'ar 7/9/2019 19:51:43'!
catalog
	| response |

	response _ webClient htmlSubmit: (self url, TusLibrosServerController catalogEndpoint ) fields: Dictionary new. 
	
	response isSuccess
		ifTrue: [^WebUtils jsonDecode: response content readStream]
		ifFalse: [self error: response content].! !

!TusLibrosWebClient methodsFor: 'server requests' stamp: 'tf 7/11/2019 12:59:29'!
checkOutCartIdentifiedAs: aCartId 
withCreditCardNumbered: aCreditCartNumber 
ownedBy: anOwner 
expiringOn: anExpirationMonthOfYear
	| queryParams response |

	queryParams _ Dictionary new 
			at: 'cartId' put: (self encode: aCartId printString ); 
			at: 'creditCardNumber' put: (self encode: aCreditCartNumber) ;
			at:  'ownersName' put: (self encode: anOwner ); 
			at: 'expirationDate' put: (self encode: anExpirationMonthOfYear printString );
			yourself .
	response _ webClient 
		htmlSubmit: (self url, TusLibrosServerController checkoutCartEndpoint ) fields: queryParams. 
	
	response isSuccess
		ifTrue: [
				^WebUtils jsonDecode: response content readStream .
			]
		ifFalse: [
				self error: response content .
			].! !

!TusLibrosWebClient methodsFor: 'server requests' stamp: 'tf 7/11/2019 13:07:56'!
createCartFor: aUser authenticatedWith: aPassword 
	| queryParams response |

	queryParams _ Dictionary new 
		at: 'username' put: (self encode: aUser); 
		at: 'password' put: (self encode: aPassword); 
		yourself .
	response _ webClient htmlSubmit: (self url, TusLibrosServerController createCartEndpoint ) fields: queryParams. 
	
	response isSuccess
		ifTrue: [
				^WebUtils jsonDecode: response content readStream .
			]
		ifFalse: [
				self error: response content .
			].! !

!TusLibrosWebClient methodsFor: 'server requests' stamp: 'tf 7/11/2019 13:00:09'!
listPurchasesOf: aUser authenticatingWith: aPassword
	| queryParams response |

	queryParams _ Dictionary new 
			at: 'username' put: (self encode: aUser) ; 
			at: 'password' put: (self encode: aPassword) ;
			yourself .
			
	response _ webClient 
		htmlSubmit: (self url, TusLibrosServerController listPurchasesEndpoint ) fields: queryParams. 
	
	response isSuccess
		ifTrue: [
				^WebUtils jsonDecode: response content readStream .
			]
		ifFalse: [
				self error: response content .
			].! !


!TusLibrosWebClient methodsFor: 'initialization' stamp: 'TF 7/9/2019 15:12:38'!
initialize
	self sendingToPort: 8080 withUrl: 'http://localhost'  andWebClient: WebClient .! !

!TusLibrosWebClient methodsFor: 'initialization' stamp: 'ar 7/7/2019 11:57:02'!
sendingToPort: aPort
	(self isValidPortNumber: aPort) ifFalse: [ self signalInvalidPort ].
	port _ aPort.! !

!TusLibrosWebClient methodsFor: 'initialization' stamp: 'TF 7/9/2019 15:11:42'!
sendingToPort: aPort withUrl: anUrl andWebClient: aWebClient .
	(self isValidPortNumber: aPort) ifFalse: [ self signalInvalidPort ].
	url _ anUrl .
	port _ aPort.
	webClient _ aWebClient .! !


!TusLibrosWebClient methodsFor: 'properties' stamp: 'ar 7/7/2019 11:20:32'!
port
	^port.! !

!TusLibrosWebClient methodsFor: 'properties' stamp: 'TF 7/9/2019 15:27:49'!
url
	^url, ':',  self port asString.! !


!TusLibrosWebClient methodsFor: 'testing' stamp: 'ar 7/7/2019 11:34:11'!
isValidPortNumber: aPort

	^ aPort isInteger and: [aPort between: 1 and: 65535].! !


!TusLibrosWebClient methodsFor: 'encoding' stamp: 'tf 7/11/2019 12:57:53'!
decode: anJsonEncoding
	^(WebUtils jsonDecode: anJsonEncoding readStream) copyReplaceAll: '%20' with: ' ' .! !

!TusLibrosWebClient methodsFor: 'encoding' stamp: 'tf 7/11/2019 12:58:01'!
encode: anObject
	^(WebUtils jsonEncode: anObject) copyReplaceAll: ' ' with: '%20' .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosWebClient class' category: #'TusLibros-Web'!
TusLibrosWebClient class
	instanceVariableNames: ''!

!TusLibrosWebClient class methodsFor: 'as yet unclassified' stamp: 'ar 7/7/2019 11:54:27'!
invalidPortNumberMessageError
	^ 'El numero de puerto tiene que ser un numero entero entre 1 y 65535'.! !

!TusLibrosWebClient class methodsFor: 'as yet unclassified' stamp: 'TF 7/9/2019 15:10:39'!
sendingToPort: aPort
	^self sendingToPort: aPort withUrl: 'http://localhost'  withWebClient: WebClient .! !

!TusLibrosWebClient class methodsFor: 'as yet unclassified' stamp: 'TF 7/9/2019 15:10:02'!
sendingToPort: aPort withUrl: anUrl withWebClient: aWebClient
	^self new sendingToPort: aPort withUrl: anUrl andWebClient: aWebClient .! !


!classDefinition: #TusLibrosWebTestObjectFactory category: #'TusLibros-Web'!
Object subclass: #TusLibrosWebTestObjectFactory
	instanceVariableNames: 'storeTestObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Web'!

!TusLibrosWebTestObjectFactory methodsFor: 'accessing' stamp: 'TF 7/8/2019 16:41:52'!
storeTestObjectsFactory
	^storeTestObjectsFactory .! !

!TusLibrosWebTestObjectFactory methodsFor: 'accessing' stamp: 'tf 7/9/2019 22:43:24'!
tusLibrosSystemFacade
	
	^TusLibrosSystemFacade
		authenticatingWith: self validUsersAndPasswords 
		acceptingItemsOf:  storeTestObjectsFactory defaultCatalog
		registeringOn: self createSalesBook 
		debitingThrought: self
		measuringTimeWith: DateAndTime
! !


!TusLibrosWebTestObjectFactory methodsFor: 'merchant processor protocol' stamp: 'TF 7/8/2019 17:58:27'!
debit: arg1 from: arg2
	^ self.! !


!TusLibrosWebTestObjectFactory methodsFor: 'initialization' stamp: 'tf 7/9/2019 22:43:32'!
initialize
	storeTestObjectsFactory _ StoreTestObjectsFactory new.! !


!TusLibrosWebTestObjectFactory methodsFor: 'users' stamp: 'TF 7/9/2019 14:55:00'!
invalidUser
	^ 'noPrueba'! !

!TusLibrosWebTestObjectFactory methodsFor: 'users' stamp: 'TF 7/9/2019 14:55:43'!
invalidUserPassword
	^ 'noPrueba'! !

!TusLibrosWebTestObjectFactory methodsFor: 'users' stamp: 'ar 7/7/2019 16:01:19'!
validUser
	^ 'Prueba'! !

!TusLibrosWebTestObjectFactory methodsFor: 'users' stamp: 'ar 7/7/2019 16:01:32'!
validUserPassword
	^ 'Prueba'! !

!TusLibrosWebTestObjectFactory methodsFor: 'users' stamp: 'ar 7/7/2019 16:00:35'!
validUsersAndPasswords

	^Dictionary new
		at: self validUser put: self validUserPassword;
		yourself! !


!TusLibrosWebTestObjectFactory methodsFor: 'salesbook' stamp: 'ar 7/7/2019 15:58:19'!
createSalesBook
	^OrderedCollection new! !
