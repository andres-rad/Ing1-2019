!classDefinition: #CreateCartWindow category: #'TusLibros-Web'!
Panel subclass: #CreateCartWindow
	instanceVariableNames: 'usernameTextBox passwordTextBox errorTextBox'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Web'!

!CreateCartWindow methodsFor: 'as yet unclassified' stamp: 'TF 7/9/2019 17:06:02'!
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

!CreateCartWindow methodsFor: 'as yet unclassified' stamp: 'TF 7/9/2019 16:25:03'!
buildMorphicWindow
	self layoutMorph beColumn;
		separation: 15;
		padding: #left;
		addMorph: self buildUsernameRow;
		addMorph: self buildPasswordRow;
		addMorph: self buildCreateCartButtonRow.! !

!CreateCartWindow methodsFor: 'as yet unclassified' stamp: 'TF 7/9/2019 16:49:20'!
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
		borderColor: Color skyBlue.
		
	^ (LayoutMorph newRow) separation: 25;
		padding: #left;
		addMorph: (StringMorph contents: 'Contraseña:');
		addMorph: passwordTextBox;
		yourself.! !

!CreateCartWindow methodsFor: 'as yet unclassified' stamp: 'TF 7/9/2019 16:49:06'!
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
		borderColor: Color skyBlue.
		
	^ (LayoutMorph newRow) separation: 25;
		padding: #left;
		addMorph: (StringMorph contents: 'Usuario:');
		addMorph: usernameTextBox;
		yourself.! !

!CreateCartWindow methodsFor: 'as yet unclassified' stamp: 'ar 7/9/2019 20:24:48'!
goToStore
	self delete.
	self model goToStore.
	
	! !

!CreateCartWindow methodsFor: 'as yet unclassified' stamp: 'ar 7/9/2019 19:03:49'!
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

!CreateCartWindow methodsFor: 'as yet unclassified' stamp: 'TF 7/9/2019 17:14:55'!
showWrongUser: anErrorMessage
	errorTextBox contents: anErrorMessage.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreateCartWindow class' category: #'TusLibros-Web'!
CreateCartWindow class
	instanceVariableNames: ''!

!CreateCartWindow class methodsFor: 'as yet unclassified' stamp: 'TF 7/9/2019 16:22:05'!
open
	^ self new initializeWith: 'TusLibros.com'.! !


!classDefinition: #StoreWindow category: #'TusLibros-Web'!
Panel subclass: #StoreWindow
	instanceVariableNames: 'catalogList cartContentsList'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Web'!

!StoreWindow methodsFor: 'as yet unclassified' stamp: 'ar 7/9/2019 20:40:56'!
buildCartContentsColumn
	|checkoutButton |
	cartContentsList _ 
		PluggableListMorph model: self model
								listGetter: #cartContents
								indexGetter: #cartContentsIndex
								indexSetter: #cartContentsIndex:.
	
	checkoutButton _ 
		PluggableButtonMorph model: self model
									stateGetter: nil
									action: #CheckoutCart
									label: 'Checkout'.
	
		     
	^ (LayoutMorph newColumn)
		    padding: #left;
		    separation: 15;
		    addMorph: (StringMorph contents: 'Tu carrito:');
		    addMorph: cartContentsList;
    	    addMorph: checkoutButton;
  	          addMorph: (StringMorph contents: 'Total: $0').
		! !

!StoreWindow methodsFor: 'as yet unclassified' stamp: 'ar 7/9/2019 20:58:15'!
buildCatalogColumn
	|addToCartButton|
	catalogList _ 
		PluggableListMorph model: self model
								listGetter: #catalog
								indexGetter: #catalogIndex
								indexSetter: #catalogIndex:.
	
	addToCartButton _ 
		PluggableButtonMorph model: self model
									stateGetter: nil
									action: #addToCartList
									label: 'Agregar al carrito'.
	
	^ (LayoutMorph newColumn)
					    separation: 15;
					    padding: #left;
					    addMorph: (StringMorph contents: 'Catálogo:');
					    addMorph: catalogList;
					    addMorph: addToCartButton.! !

!StoreWindow methodsFor: 'as yet unclassified' stamp: 'ar 7/9/2019 19:06:39'!
buildMorphicWindow
	self layoutMorph beRow;
		 separation: 15;
		 padding: #left;
		 addMorph: self buildCatalogColumn;
		 addMorph: self buildCartContentsColumn.! !

!StoreWindow methodsFor: 'as yet unclassified' stamp: 'ar 7/9/2019 20:21:17'!
initializeWith: aTitle
	self withModel: (CreateCartWindowModel new) andTitle: aTitle.! !

!StoreWindow methodsFor: 'as yet unclassified' stamp: 'ar 7/9/2019 19:59:46'!
setCatalog
	catalogList updateList.
	catalogList setSelectionIndex: 0.! !

!StoreWindow methodsFor: 'as yet unclassified' stamp: 'ar 7/9/2019 20:05:58'!
withModel: aModel andTitle: aTitle
	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: aTitle;
		 model: (aModel);
		 morphExtent: 640@480;
		 buildMorphicWindow;
		 openInWorld.
	self model when: #catalogArrived 
			     send: #setCatalog
			     to: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StoreWindow class' category: #'TusLibros-Web'!
StoreWindow class
	instanceVariableNames: ''!

!StoreWindow class methodsFor: 'as yet unclassified' stamp: 'ar 7/9/2019 19:18:06'!
open
	self new initializeWith: 'Tus Libros - Tienda'.! !

!StoreWindow class methodsFor: 'as yet unclassified' stamp: 'ar 7/9/2019 20:05:36'!
withModel: aStoreWindowModel
	self new withModel:  aStoreWindowModel  andTitle: 'Tus Libros - Tienda'.! !


!classDefinition: #CreateCartWindowModelTest category: #'TusLibros-Web'!
TestCase subclass: #CreateCartWindowModelTest
	instanceVariableNames: 'webClientRequestBlock windowModel'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Web'!

!CreateCartWindowModelTest methodsFor: 'as yet unclassified' stamp: 'ar 7/9/2019 19:57:04'!
catalog
	^webClientRequestBlock value.! !

!CreateCartWindowModelTest methodsFor: 'as yet unclassified' stamp: 'TF 7/9/2019 16:16:10'!
createCartFor: aUsername authenticatedWith: aPassword
	^webClientRequestBlock value: aUsername value: aPassword.! !

!CreateCartWindowModelTest methodsFor: 'as yet unclassified' stamp: 'TF 7/9/2019 15:59:42'!
setUp
	windowModel _ CreateCartWindowModel withWebClient: self.! !

!CreateCartWindowModelTest methodsFor: 'as yet unclassified' stamp: 'ar 7/7/2019 17:53:46'!
test01NewModelUsernameValueIsEmpty
	| LoginModel |
	
	LoginModel _ CreateCartWindowModel new.
	
	self assert: (LoginModel username = '').! !

!CreateCartWindowModelTest methodsFor: 'as yet unclassified' stamp: 'ar 7/7/2019 17:53:46'!
test02NewModelPasswordValueIsEmpty
	| LoginModel |
	
	LoginModel _ CreateCartWindowModel new.
	
	self assert: (LoginModel password = '').! !

!CreateCartWindowModelTest methodsFor: 'as yet unclassified' stamp: 'ar 7/7/2019 17:53:46'!
test03ModelUsernameValueUpdatesWithInputtedValue
	| LoginModel |
	
	LoginModel _ CreateCartWindowModel new.
	
	LoginModel username: 'ValidUser'.
	self assert: (LoginModel username = 'ValidUser').! !

!CreateCartWindowModelTest methodsFor: 'as yet unclassified' stamp: 'ar 7/7/2019 17:53:46'!
test04ModelPasswordValueUpdatesWithInputtedValue
	| LoginModel |
	
	LoginModel _ CreateCartWindowModel new.
	
	LoginModel password: 'ValidPass'.
	self assert: (LoginModel password = 'ValidPass').! !

!CreateCartWindowModelTest methodsFor: 'as yet unclassified' stamp: 'TF 7/9/2019 16:17:15'!
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

!CreateCartWindowModelTest methodsFor: 'as yet unclassified' stamp: 'ar 7/9/2019 19:33:52'!
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

!CreateCartWindowModelTest methodsFor: 'as yet unclassified' stamp: 'ar 7/9/2019 19:57:59'!
test07SiElWebClientTraeElCatalogoDeLaTiendaYDisparaEventoIndicandoQueSeActualizo
	| flag aCatalog|
	
	aCatalog _ Dictionary newFromPairs: {'validBook' . 10 . 'anotherBook' . 30 }.
	webClientRequestBlock _ [
		aCatalog
	].

	flag _ false.
	windowModel when: #catalogArrived evaluate: [flag _ true].
	
	windowModel sendCatalogRequest.
	
	self assert: windowModel catalog equals: aCatalog. 
	self assert: flag .! !


!classDefinition: #TusLibrosServerControllerTest category: #'TusLibros-Web'!
TestCase subclass: #TusLibrosServerControllerTest
	instanceVariableNames: 'port aSystemFacade testObjectsFactory storeTestObjectsFactory aDefaultServerController'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Web'!

!TusLibrosServerControllerTest methodsFor: 'as yet unclassified' stamp: 'ar 7/7/2019 17:48:10'!
test11ReciboUnaRespuesta404AlAgregarItemsAUnCarritoInexistente
	| aServerController queryParams addToCartResponse cartCreationResponse cartId |
	
	aServerController _ TusLibrosServerController listeningOn: 8484 withFacade: aSystemFacade.
	
	queryParams _ Dictionary newFromPairs: {'username' . testObjectsFactory validUser . 'password' . testObjectsFactory validUserPassword }.
	
	cartCreationResponse _ WebClient htmlSubmit: 'http://localhost:8484/createCart' fields: queryParams.
	cartId _ WebUtils jsonDecode: cartCreationResponse content readStream.
	
	queryParams _ Dictionary newFromPairs: { 'cartId' . cartId printString . 'bookISBN' . 'invalidBook' . 'bookQuantity' . '3' }.
	addToCartResponse  _ WebClient htmlSubmit: 'http://localhost:8484/addToCart' fields: queryParams.
	
	self assert: addToCartResponse code = 404.
	self assert: addToCartResponse content = 'Item is not in catalog'.! !


!TusLibrosServerControllerTest methodsFor: 'test - port' stamp: 'tf 7/9/2019 22:40:44'!
test02PuedoCrearUnaInstanciaDelServidorQueEscucheEnUnPuertoEspecifico
	| aServerController |
	
	aServerController _ TusLibrosServerController listeningOn: 8888 withFacade: aSystemFacade.
	self assert: (aServerController port = 8888).
	
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


!TusLibrosServerControllerTest methodsFor: 'test - create cart' stamp: 'TF 7/9/2019 14:07:37'!
test06ElServidorDeTusLibrosTieneUnEndpointParaCrearUnCarrito
	
	self assert: ( aDefaultServerController webServer endpoints includes: TusLibrosServerController createCartEndpoint). ! !

!TusLibrosServerControllerTest methodsFor: 'test - create cart' stamp: 'TF 7/9/2019 14:11:50'!
test07IntentarCrearUnCarritoConUnUsuarioMalAutenticadoGeneraUnaRespuestaDeError404
	| httpResponse queryParams |
	
	queryParams _ Dictionary newFromPairs:  { 'user' . 'badUser' . 'password' . ''}.
	httpResponse _ WebClient htmlSubmit: 'http://localhost:8484/createCart' fields: queryParams.
	
	self deny: httpResponse isSuccess.
	self assert: httpResponse code = 404.! !

!TusLibrosServerControllerTest methodsFor: 'test - create cart' stamp: 'TF 7/9/2019 14:12:00'!
test08AlCrearUnCarritoConUnUsuarioValidoTengoUnaRespuesta200
	| httpResponse queryParams |
	
	queryParams _ Dictionary newFromPairs:  { 'username' . 'Prueba' . 'password' . 'Prueba'}.
	httpResponse _ WebClient htmlSubmit: 'http://localhost:8484/createCart' fields: queryParams.
	
	self assert: httpResponse isSuccess.
	self assert: httpResponse code = 200.! !


!TusLibrosServerControllerTest methodsFor: 'test - add items' stamp: 'TF 7/9/2019 14:12:23'!
test09ElServidorDeTusLibrosTieneUnEndpointParaAgregarItemsAlCarrito
	
	self assert: ( aDefaultServerController webServer endpoints includes: TusLibrosServerController addToCartEndpoint). ! !

!TusLibrosServerControllerTest methodsFor: 'test - add items' stamp: 'TF 7/9/2019 14:12:34'!
test10ReciboUnaRespuesta200AlAgregarItemsAlCarrito
	| cartId queryParams cartCreationResponse addToCartResponse|
	
	queryParams _ Dictionary newFromPairs: {'username' . testObjectsFactory validUser . 'password' . testObjectsFactory validUserPassword }.
	
	cartCreationResponse _ WebClient htmlSubmit: 'http://localhost:8484/createCart' fields: queryParams.
	cartId _ WebUtils jsonDecode: cartCreationResponse content readStream.
	
	queryParams _ Dictionary newFromPairs: { 'cartId' . cartId printString . 'bookISBN' . 'validBook' . 'bookQuantity' . '3' }.
	addToCartResponse  _ WebClient htmlSubmit: 'http://localhost:8484/addToCart' fields: queryParams.

	self assert: addToCartResponse code = 200.! !

!TusLibrosServerControllerTest methodsFor: 'test - add items' stamp: 'TF 7/9/2019 14:12:45'!
test11ReciboUnaRespuesta404AlAgregarItemsDeUnLibroInexistente
	| queryParams addToCartResponse cartCreationResponse cartId |
	
	queryParams _ Dictionary newFromPairs: {'username' . testObjectsFactory validUser . 'password' . testObjectsFactory validUserPassword }.
	
	cartCreationResponse _ WebClient htmlSubmit: 'http://localhost:8484/createCart' fields: queryParams.
	cartId _ WebUtils jsonDecode: cartCreationResponse content readStream.
	
	queryParams _ Dictionary newFromPairs: { 'cartId' . cartId printString . 'bookISBN' . 'invalidBook' . 'bookQuantity' . '3' }.
	addToCartResponse  _ WebClient htmlSubmit: 'http://localhost:8484/addToCart' fields: queryParams.
	
	self assert: addToCartResponse code = 404.
	self assert: addToCartResponse content = 'Item is not in catalog'.! !

!TusLibrosServerControllerTest methodsFor: 'test - add items' stamp: 'TF 7/9/2019 14:12:54'!
test12ReciboUnaRespuesta404AlAgregarItemsAUnCarritoInexistente
	| queryParams addToCartResponse|
	
	queryParams _ Dictionary newFromPairs: { 'cartId' . '-1835140' . 'bookISBN' . 'validBook' . 'bookQuantity' . '3' }.
	addToCartResponse  _ WebClient htmlSubmit: 'http://localhost:8484/addToCart' fields: queryParams.
	
	self assert: addToCartResponse code = 404.
	self assert: addToCartResponse content = 'Invalid cart id'.! !


!TusLibrosServerControllerTest methodsFor: 'test - catalogo' stamp: 'TF 7/9/2019 14:31:02'!
test18ElServidorDeTusLibrosTieneUnEndpointParaHacerCatalogDelSistema
	
	self assert: ( aDefaultServerController webServer endpoints includes: TusLibrosServerController catalogEndpoint). ! !

!TusLibrosServerControllerTest methodsFor: 'test - catalogo' stamp: 'TF 7/9/2019 14:37:17'!
test19AlPedirElCatalogoMeLoDevuelveConCodigo200
	| catalogResponse aCatalog |

		
	catalogResponse _ WebClient htmlSubmit: 'http://localhost:8484/catalog'  fields: Dictionary new.
		
	
	self assert: catalogResponse code equals: 200.
	aCatalog _ WebUtils jsonDecode: catalogResponse content readStream .
	self assert: aCatalog notEmpty .
	self assert: aCatalog equals: aSystemFacade catalog . 
	
		! !


!TusLibrosServerControllerTest methodsFor: 'test - checkout' stamp: 'TF 7/9/2019 14:13:08'!
test13ElServidorDeTusLibrosTieneUnEndpointParaHacerCheckoutDelCarrito
	
	self assert: ( aDefaultServerController webServer endpoints includes: TusLibrosServerController checkoutCartEndpoint). ! !

!TusLibrosServerControllerTest methodsFor: 'test - checkout' stamp: 'TF 7/9/2019 14:17:41'!
test14AlHacerCheckoutDeUnCarritoConElementosObtengoUnaRespuestaConCodigo200
	| cartCreationResponse cartId queryParams checkOutResponse expirationDate |
	
	queryParams _ Dictionary newFromPairs: 
		{'username' . testObjectsFactory validUser . 
		  'password' . testObjectsFactory validUserPassword }.
	
	cartCreationResponse _ WebClient htmlSubmit: 'http://localhost:8484/createCart' fields: queryParams.
	cartId _ WebUtils jsonDecode: cartCreationResponse content readStream.
	
	queryParams _ Dictionary newFromPairs: { 'cartId' . cartId printString . 'bookISBN' . 'validBook' . 'bookQuantity' . '3' }.
	WebClient htmlSubmit: 'http://localhost:8484/addToCart' fields: queryParams.

	expirationDate _ testObjectsFactory storeTestObjectsFactory notExpiredMonthOfYear printString copyReplaceAll: ' ' with: '%20'.
	queryParams _ Dictionary newFromPairs: 
		{'cartId' . cartId printString . 
		'creditCardNumber' . testObjectsFactory storeTestObjectsFactory notExpiredCreditCardNumber . 
		'ownersName' . testObjectsFactory storeTestObjectsFactory notExpiredCreditCardOwner . 
		'expirationDate' . expirationDate }.
		
	checkOutResponse _ WebClient htmlSubmit: 'http://localhost:8484/checkoutcart' fields: queryParams .
		
	self assert: checkOutResponse code equals: 200.
	
		! !

!TusLibrosServerControllerTest methodsFor: 'test - checkout' stamp: 'TF 7/9/2019 14:16:03'!
test15AlHacerCheckoutDeUnCarritoInexistenteObtengoUnaRespuestaConCodigo404YMensajeDeError
	| cartId queryParams checkOutResponse expirationDate |
	
	cartId _ 10.
	
	expirationDate _ testObjectsFactory storeTestObjectsFactory notExpiredMonthOfYear printString copyReplaceAll: ' ' with: '%20'.
	queryParams _ Dictionary newFromPairs: 
		{'cartId' . cartId printString . 
		'creditCardNumber' . testObjectsFactory storeTestObjectsFactory notExpiredCreditCardNumber . 
		'ownersName' . testObjectsFactory storeTestObjectsFactory notExpiredCreditCardOwner . 
		'expirationDate' . expirationDate }.
		
	checkOutResponse _ WebClient htmlSubmit: 'http://localhost:8484/checkoutcart' fields: queryParams .
		
	self assert: checkOutResponse code equals: 404.
	self assert: checkOutResponse content equals: 'Invalid cart id'
	
		! !

!TusLibrosServerControllerTest methodsFor: 'test - checkout' stamp: 'TF 7/9/2019 14:17:31'!
test16AlHacerCheckoutDeUnCarritoVacioObtengoUnaRespuestaConCodigo404YUnMensajeDeError
	| cartCreationResponse cartId queryParams checkOutResponse expirationDate |
	
	queryParams _ Dictionary newFromPairs: 
		{'username' . testObjectsFactory validUser . 
		  'password' . testObjectsFactory validUserPassword }.
	
	cartCreationResponse _ WebClient htmlSubmit: 'http://localhost:8484/createCart' fields: queryParams.
	cartId _ WebUtils jsonDecode: cartCreationResponse content readStream.
	
	expirationDate _ testObjectsFactory storeTestObjectsFactory notExpiredMonthOfYear printString copyReplaceAll: ' ' with: '%20'.
	queryParams _ Dictionary newFromPairs: 
		{'cartId' . cartId printString . 
		'creditCardNumber' . testObjectsFactory storeTestObjectsFactory notExpiredCreditCardNumber . 
		'ownersName' . testObjectsFactory storeTestObjectsFactory notExpiredCreditCardOwner . 
		'expirationDate' . expirationDate }.
		
	checkOutResponse _ WebClient htmlSubmit: 'http://localhost:8484/checkoutcart' fields: queryParams .
		
	self assert: checkOutResponse code equals: 404.
	self assert: checkOutResponse content equals: 'Can not check out an empty cart'.
	
		! !

!TusLibrosServerControllerTest methodsFor: 'test - checkout' stamp: 'TF 7/9/2019 14:19:10'!
test17AlHacerCheckoutDeUnCarritoConElementosConUnaTarjetaInvalidaObtengoUnaRespuestaConCodigo404YUnMensajeDeError
	| cartCreationResponse cartId queryParams checkOutResponse expirationDate |
	
	queryParams _ Dictionary newFromPairs: 
		{'username' . testObjectsFactory validUser . 
		  'password' . testObjectsFactory validUserPassword }.
	
	cartCreationResponse _ WebClient htmlSubmit: 'http://localhost:8484/createCart' fields: queryParams.
	cartId _ WebUtils jsonDecode: cartCreationResponse content readStream.
	
	queryParams _ Dictionary newFromPairs: { 'cartId' . cartId printString . 'bookISBN' . 'validBook' . 'bookQuantity' . '3' }.
	WebClient htmlSubmit: 'http://localhost:8484/addToCart' fields: queryParams.

	expirationDate _ testObjectsFactory storeTestObjectsFactory expiredMonthOfYear printString copyReplaceAll: ' ' with: '%20'.
	queryParams _ Dictionary newFromPairs: 
		{'cartId' . cartId printString . 
		'creditCardNumber' . testObjectsFactory storeTestObjectsFactory notExpiredCreditCardNumber . 
		'ownersName' . testObjectsFactory storeTestObjectsFactory notExpiredCreditCardOwner . 
		'expirationDate' . expirationDate }.
		
	checkOutResponse _ WebClient htmlSubmit: 'http://localhost:8484/checkoutcart' fields: queryParams .
		
	self assert: checkOutResponse code equals: 404.
	self assert: checkOutResponse content equals: 'Can not charge an expired credit card'.
	
		! !


!TusLibrosServerControllerTest methodsFor: 'test - list purchase' stamp: 'TF 7/9/2019 14:38:01'!
test20ElServidorDeTusLibrosTieneUnEndpointParaHacerListPurchases
	
	self assert: ( aDefaultServerController webServer endpoints includes: TusLibrosServerController listPurchasesEndpoint). ! !

!TusLibrosServerControllerTest methodsFor: 'test - list purchase' stamp: 'TF 7/9/2019 14:43:55'!
test21ListPurchasesDeUnUsuarioQueNoHizoComprasDevuelveCodigo200YListaVacia
	| queryParams listPurchasesResponse |
	
	queryParams _ Dictionary newFromPairs: 
		{'username' . testObjectsFactory validUser . 
		  'password' . testObjectsFactory validUserPassword }.
		
	listPurchasesResponse _ WebClient htmlSubmit: 'http://localhost:8484/listpurchases' fields: queryParams .
		
	self assert: listPurchasesResponse code equals: 200.
	
		! !

!TusLibrosServerControllerTest methodsFor: 'test - list purchase' stamp: 'TF 7/9/2019 14:52:44'!
test22AlPedirLasComprasDeUnUsuarioConComprasReciboCodigo200YDiccionarioAcorde
	| cartCreationResponse cartId queryParams expirationDate purchasesResponse |
	
	queryParams _ Dictionary newFromPairs: 
		{'username' . testObjectsFactory validUser . 
		  'password' . testObjectsFactory validUserPassword }.
	
	cartCreationResponse _ WebClient htmlSubmit: 'http://localhost:8484/createCart' fields: queryParams.
	cartId _ WebUtils jsonDecode: cartCreationResponse content readStream.
	
	queryParams _ Dictionary newFromPairs: { 'cartId' . cartId printString . 'bookISBN' . 'validBook' . 'bookQuantity' . '3' }.
	WebClient htmlSubmit: 'http://localhost:8484/addToCart' fields: queryParams.

	expirationDate _ testObjectsFactory storeTestObjectsFactory notExpiredMonthOfYear printString copyReplaceAll: ' ' with: '%20'.
	queryParams _ Dictionary newFromPairs: 
		{'cartId' . cartId printString . 
		'creditCardNumber' . testObjectsFactory storeTestObjectsFactory notExpiredCreditCardNumber . 
		'ownersName' . testObjectsFactory storeTestObjectsFactory notExpiredCreditCardOwner . 
		'expirationDate' . expirationDate }.
		
	WebClient htmlSubmit: 'http://localhost:8484/checkoutcart' fields: queryParams .
	
	queryParams _ Dictionary newFromPairs: 
		{'username' . testObjectsFactory validUser . 
		  'password' . testObjectsFactory validUserPassword }.
		
	purchasesResponse _ WebClient htmlSubmit: 'http://localhost:8484/listpurchases'  fields: queryParams.
		
	self assert: purchasesResponse code equals: 200.
	self assert: (WebUtils jsonDecode: (purchasesResponse content readStream )) 
		equals: (Dictionary new 
					at: 'validBook' 
					put: 3*(testObjectsFactory storeTestObjectsFactory itemSellByTheStorePrice); yourself ).
	
		! !

!TusLibrosServerControllerTest methodsFor: 'test - list purchase' stamp: 'TF 7/9/2019 14:58:59'!
test23AlPedirLasComprasDeUnUsuarioMalAutenticadoReciboError404ConMensajeAcorde
	| queryParams purchasesResponse |

	queryParams _ Dictionary newFromPairs: 
		{'username' . testObjectsFactory invalidUser . 
		  'password' . testObjectsFactory invalidUserPassword }.
		
	purchasesResponse _ WebClient htmlSubmit: 'http://localhost:8484/listpurchases'  fields: queryParams.
		
	self assert: purchasesResponse code equals: 404.
	self assert: purchasesResponse content
		equals: 'Invalid user and/or password'.
	
		! !


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


!TusLibrosWebClientTest methodsFor: 'as yet unclassified' stamp: 'ar 7/9/2019 19:50:51'!
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

!TusLibrosWebClientTest methodsFor: 'as yet unclassified' stamp: 'tf 7/9/2019 23:06:31'!
test09
		
	onHtmlSubmitBlock _ [:url :fields | 
		(WebResponse protocol: 'http' code: 404) content: 'Error!!!!' 
	].

	self should: [defaultWebClient catalog ]
		raise: Error - MessageNotUnderstood 
		withMessageText: 'Error!!!!'.
! !

!TusLibrosWebClientTest methodsFor: 'as yet unclassified' stamp: 'tf 7/9/2019 23:06:15'!
test10PuedoAgregarCosasAUnCarrito
	| addToCartResponse|
		
	onHtmlSubmitBlock _ [:url :fields | 
		self assert: url equals: 'http://tusLibros.com:8484/addtocart'.
		self assert: (fields at: 'cartId') equals: 23 printString .
		self assert: (fields at: 'bookISBN') equals: 'validBook'.
		self assert: (fields at: 'bookQuantity') equals: 3 printString .
		(WebResponse protocol: 'http' code: 200) content: (WebUtils jsonEncode: 0) 
	].

	addToCartResponse _ defaultWebClient add: 3 of: 'validBook' toCartIdentifiedAs: 23 .
	
	self assert: addToCartResponse equals: 0.
! !

!TusLibrosWebClientTest methodsFor: 'as yet unclassified' stamp: 'tf 7/9/2019 23:05:51'!
test11SiElServerDaUnErrorAlAgregarCosasAUnCarritoLevantoUnaExcepcion

		
	onHtmlSubmitBlock _ [:url :fields | 
		(WebResponse protocol: 'http' code: 404) content: 'Error!!'.
	].

	self should: [defaultWebClient add: 3 of: 'validBook' toCartIdentifiedAs: 23] 
		raise: Error - MessageNotUnderstood 
		withMessageText: 'Error!!'.

	

! !

!TusLibrosWebClientTest methodsFor: 'as yet unclassified' stamp: 'tf 7/9/2019 23:04:41'!
test12PuedoHacerCheckoutDeUnCarrito
	| checkoutResponse|
		
	onHtmlSubmitBlock _ [:url :fields | 
		self assert: url equals: 'http://tusLibros.com:8484/checkoutcart'.
		self assert: (fields at: 'cartId') equals: 23 printString .
		self assert: (fields at: 'creditCardNumber') equals: '0000111122223333'.
		self assert: (fields at: 'ownersName') equals: 'Teo'.
		self assert: (fields at: 'expirationDate') 
			equals: ((Month month: 07 year: 2020) printString copyReplaceAll: ' ' with: '%20') .
			
		(WebResponse protocol: 'http' code: 200) content: (WebUtils jsonEncode: 0) 
	].

	checkoutResponse _ defaultWebClient 
		checkOutCartIdentifiedAs: 23 
		withCreditCardNumbered: '0000111122223333' 
		ownedBy: 'Teo' 
		expiringOn: (Month month: 07 year: 2020) .
	
	self assert: checkoutResponse equals: 0.
! !

!TusLibrosWebClientTest methodsFor: 'as yet unclassified' stamp: 'tf 7/9/2019 23:09:29'!
test13LevantaUnaExcepcionAlRecibirUnErrorDelServer
		
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

!TusLibrosWebClientTest methodsFor: 'as yet unclassified' stamp: 'tf 7/9/2019 23:12:56'!
test14PuedoListarLasComprasDeUnUsuario
	| listPurchaseResponse|
		
	onHtmlSubmitBlock _ [:url :fields | 
		self assert: url equals: 'http://tusLibros.com:8484/listpurchases'.
		self assert: (fields at: 'username') equals: 'Teo' .
		self assert: (fields at: 'password') equals: 'freund'.



			
		(WebResponse protocol: 'http' code: 200) content: (WebUtils jsonEncode: '123') 
	].

	listPurchaseResponse _ defaultWebClient listPurchasesOf: 'Teo' authenticatingWith: 'freund'. 
	
	self assert: listPurchaseResponse equals: '123'.
! !

!TusLibrosWebClientTest methodsFor: 'as yet unclassified' stamp: 'tf 7/9/2019 23:15:19'!
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


!TusLibrosWebClientTest methodsFor: 'test - createcart' stamp: 'TF 7/9/2019 16:59:55'!
test06PuedoCrearUnCarritoConUsuarioYContrasenaValidosYObtengoUnCartIdYSeLeEnviaElRequestAlServidor
	| cartId |
		
	onHtmlSubmitBlock _ [:url :fields | 
		self assert: url equals: 'http://tusLibros.com:8484/createcart'.
		self assert: (fields at: 'username') equals: testObjectFactory validUser .
		self assert: (fields at: 'password') equals: testObjectFactory validUserPassword .
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


!classDefinition: #CreateCartWindowModel category: #'TusLibros-Web'!
Object subclass: #CreateCartWindowModel
	instanceVariableNames: 'username password webClient cartId catalog catalogIndex cartContents cartContentsIndex listableCatalog catalogAsDict'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Web'!

!CreateCartWindowModel methodsFor: 'accessing' stamp: 'ar 7/9/2019 21:02:40'!
initialize
	webClient _ TusLibrosWebClient new.
	username _ ''.
	password _ ''.
	catalogIndex _ 0.
	cartContents _ OrderedCollection new.
	cartContentsIndex _ 0.! !

!CreateCartWindowModel methodsFor: 'accessing' stamp: 'TF 7/9/2019 15:55:51'!
initializeWithWebClient: aWebClient
	webClient _ aWebClient.
	username _ ''.
	password _ ''.! !

!CreateCartWindowModel methodsFor: 'accessing' stamp: 'TF 7/9/2019 16:47:19'!
password
	^password.! !

!CreateCartWindowModel methodsFor: 'accessing' stamp: 'ar 7/9/2019 20:12:54'!
sendCreateCartRequest

	[
		cartId _ webClient createCartFor: username authenticatedWith: password.
		self triggerEvent: #cartCreationSuccess .
	] 
	on: Error 
	do: [:anError | self triggerEvent: #cartCreationFailed with: anError messageText]! !

!CreateCartWindowModel methodsFor: 'accessing' stamp: 'ar 7/7/2019 11:02:07'!
username
	^username! !


!CreateCartWindowModel methodsFor: 'binding' stamp: 'TF 7/9/2019 16:49:35'!
password: aPassword
	password _ aPassword.
	^true.! !

!CreateCartWindowModel methodsFor: 'binding' stamp: 'ar 7/7/2019 11:08:58'!
username: aUsername 
	username _ aUsername.
	^true.! !


!CreateCartWindowModel methodsFor: 'catalog' stamp: 'ar 7/9/2019 21:05:46'!
catalog
	^catalog! !

!CreateCartWindowModel methodsFor: 'catalog' stamp: 'ar 7/9/2019 19:20:34'!
catalogIndex
	^catalogIndex.! !

!CreateCartWindowModel methodsFor: 'catalog' stamp: 'ar 7/9/2019 19:26:24'!
catalogIndex: anIndex
	catalogIndex _ anIndex.! !

!CreateCartWindowModel methodsFor: 'catalog' stamp: 'ar 7/9/2019 21:03:43'!
sendCatalogRequest
	catalogAsDict _ webClient catalog.
	catalog _ OrderedCollection new.
	catalogAsDict keysAndValuesDo: [ :titulo :valor | catalog add: titulo, '  $', valor asString].
	self triggerEvent: #catalogArrived.! !


!CreateCartWindowModel methodsFor: 'cart contents' stamp: 'ar 7/9/2019 19:23:08'!
cartContents
	^cartContents! !

!CreateCartWindowModel methodsFor: 'cart contents' stamp: 'ar 7/9/2019 19:25:02'!
cartContentsIndex
	^cartContentsIndex! !

!CreateCartWindowModel methodsFor: 'cart contents' stamp: 'ar 7/9/2019 19:26:34'!
cartContentsIndex: anIndex
	cartContentsIndex _ anIndex.
! !

!CreateCartWindowModel methodsFor: 'cart contents' stamp: 'TF 7/9/2019 16:14:41'!
cartId

	^cartId! !


!CreateCartWindowModel methodsFor: 'window transitions' stamp: 'ar 7/9/2019 20:06:47'!
goToStore
	StoreWindow withModel: self.
	self sendCatalogRequest. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreateCartWindowModel class' category: #'TusLibros-Web'!
CreateCartWindowModel class
	instanceVariableNames: ''!

!CreateCartWindowModel class methodsFor: 'as yet unclassified' stamp: 'TF 7/9/2019 15:55:23'!
withWebClient: aWebClient
	^self new initializeWithWebClient: aWebClient .! !


!classDefinition: #TusLibrosServerController category: #'TusLibros-Web'!
Object subclass: #TusLibrosServerController
	instanceVariableNames: 'port webServer tusLibrosFacade'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Web'!

!TusLibrosServerController methodsFor: 'accessing' stamp: 'ar 7/7/2019 11:51:07'!
port
	^port.! !


!TusLibrosServerController methodsFor: 'as yet unclassified' stamp: 'TF 7/8/2019 17:02:51'!
destroy
	webServer ifNotNil: [ webServer destroy ].! !

!TusLibrosServerController methodsFor: 'as yet unclassified' stamp: 'ar 7/7/2019 12:02:40'!
isValidPortNumber: aPort
	^ aPort isInteger  and: [aPort between: 1 and: 65535].! !

!TusLibrosServerController methodsFor: 'as yet unclassified' stamp: 'TF 7/9/2019 14:39:39'!
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

!TusLibrosServerController methodsFor: 'as yet unclassified' stamp: 'ar 7/7/2019 11:54:57'!
signalInvalidPort
	self error: self class invalidPortNumberMessageError.! !

!TusLibrosServerController methodsFor: 'as yet unclassified' stamp: 'TF 7/8/2019 17:02:44'!
stopListening
	webServer stopListener.! !

!TusLibrosServerController methodsFor: 'as yet unclassified' stamp: 'ar 7/7/2019 14:51:09'!
webServer
	^webServer.! !


!TusLibrosServerController methodsFor: 'services' stamp: 'ar 7/7/2019 17:35:53'!
registerAddToCart
	webServer addService: self class addToCartEndpoint 
				action: [ :request |
					|cartId bookISBN bookQuantity|
					[
						cartId _ (request fields at: 'cartId') asInteger.
						bookISBN _ request fields at: 'bookISBN'.
						bookQuantity _ (request fields at: 'bookQuantity') asInteger.
						tusLibrosFacade add: bookQuantity of: bookISBN toCartIdentifiedAs: cartId.
						request send200Response: (WebUtils jsonEncode: 0). 
					]
					on: Error
					do: [:anError |
						request send404Response: anError messageText.	
					]
				].! !

!TusLibrosServerController methodsFor: 'services' stamp: 'TF 7/9/2019 14:36:41'!
registerCatalog
	webServer addService: self class catalogEndpoint 
				action: [:request |
						request send200Response: (WebUtils jsonEncode: tusLibrosFacade catalog ).
						
					 ].! !

!TusLibrosServerController methodsFor: 'services' stamp: 'TF 7/8/2019 17:59:43'!
registerCheckoutCart
	webServer addService: self class checkoutCartEndpoint 
				action: [:request |
						|cartId creditCardNumber expirationDate ownersName |
					[ 
						cartId _ (request fields at: 'cartId') asInteger.
						creditCardNumber _ request fields at: 'creditCardNumber'.
						ownersName _ request fields at: 'ownersName'.
						expirationDate _ (request fields at: 'expirationDate') copyReplaceAll: '%20' with: ' ' .
						expirationDate _ Month readFrom: expirationDate readStream .
						
						tusLibrosFacade 
							checkOutCartIdentifiedAs:  cartId 
							withCreditCardNumbered:  creditCardNumber 
							ownedBy:  ownersName 
							expiringOn: expirationDate .
						
						request send200Response: (WebUtils jsonEncode: 0). 
					]
					on: Error
					do: [:anError |
						request send404Response: anError messageText .	
					]
					].! !

!TusLibrosServerController methodsFor: 'services' stamp: 'ar 7/7/2019 17:35:38'!
registerCreateCart
	webServer addService: self class createCartEndpoint 
				action: [ :request |
					| cartId password username |
					[
						username _ request fields at: 'username'.
						password _ request fields at: 'password'.
						cartId _ tusLibrosFacade createCartFor: username authenticatedWith: password.
						request send200Response: (WebUtils jsonEncode: cartId).
					]
					on: Error
					do: [ :anError |
						request send404Response: anError messageText.
					].
				].! !

!TusLibrosServerController methodsFor: 'services' stamp: 'TF 7/9/2019 14:57:09'!
registerListPurchases
	webServer addService: self class listPurchasesEndpoint 
				action: [:request | | purchases password username |
					
						[
							username _ request fields at: 'username'.
							password _ request fields at: 'password'.
							purchases _ tusLibrosFacade listPurchasesOf: username authenticatingWith: password .
							request send200Response: (WebUtils jsonEncode: purchases).
						] on: Error 
						do: [:anError |
							request send404Response: anError messageText .	
					]
					
					].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosServerController class' category: #'TusLibros-Web'!
TusLibrosServerController class
	instanceVariableNames: ''!

!TusLibrosServerController class methodsFor: 'as yet unclassified' stamp: 'ar 7/7/2019 16:39:00'!
addToCartEndpoint
	^'/addtocart'.! !

!TusLibrosServerController class methodsFor: 'as yet unclassified' stamp: 'TF 7/9/2019 14:31:30'!
catalogEndpoint
	^'/catalog'.! !

!TusLibrosServerController class methodsFor: 'as yet unclassified' stamp: 'ar 7/7/2019 17:51:22'!
checkoutCartEndpoint
	^'/checkoutcart'.! !

!TusLibrosServerController class methodsFor: 'as yet unclassified' stamp: 'ar 7/7/2019 14:51:03'!
createCartEndpoint
	^'/createcart'.! !

!TusLibrosServerController class methodsFor: 'as yet unclassified' stamp: 'ar 7/7/2019 11:54:31'!
invalidPortNumberMessageError
	^ 'El numero de puerto tiene que ser un numero entero entre 1 y 65535'.! !

!TusLibrosServerController class methodsFor: 'as yet unclassified' stamp: 'TF 7/9/2019 14:41:22'!
listPurchasesEndpoint
	^'/listpurchases'.! !

!TusLibrosServerController class methodsFor: 'as yet unclassified' stamp: 'ar 7/7/2019 15:14:21'!
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


!TusLibrosWebClient methodsFor: 'server requests' stamp: 'tf 7/9/2019 23:07:36'!
add: anAmount of: aBook toCartIdentifiedAs: aCartId
	| queryParams response |

	queryParams _ Dictionary new 
			at: 'bookQuantity' put: anAmount printString ; 
			at: 'bookISBN' put: aBook; 
			at: 'cartId' put: aCartId printString ; 
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

!TusLibrosWebClient methodsFor: 'server requests' stamp: 'tf 7/9/2019 23:03:40'!
checkOutCartIdentifiedAs: aCartId 
withCreditCardNumbered: aCreditCartNumber 
ownedBy: anOwner 
expiringOn: anExpirationMonthOfYear
	| queryParams response |

	queryParams _ Dictionary new 
			at: 'cartId' put: aCartId printString ; 
			at: 'creditCardNumber' put: aCreditCartNumber ;
			at:  'ownersName' put: anOwner ; 
			at: 'expirationDate' put: (anExpirationMonthOfYear printString copyReplaceAll: ' ' with: '%20') ;
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

!TusLibrosWebClient methodsFor: 'server requests' stamp: 'ar 7/9/2019 20:15:47'!
createCartFor: aUser authenticatedWith: aPassword 
	| queryParams response |

	queryParams _ Dictionary new at: 'username' put: aUser; at: 'password' put: aPassword; yourself .
	response _ webClient htmlSubmit: (self url, TusLibrosServerController createCartEndpoint ) fields: queryParams. 
	
	response isSuccess
		ifTrue: [
				^WebUtils jsonDecode: response content readStream .
			]
		ifFalse: [
				self error: response content .
			].! !

!TusLibrosWebClient methodsFor: 'server requests' stamp: 'tf 7/9/2019 23:13:09'!
listPurchasesOf: aUser authenticatingWith: aPassword
	| queryParams response |

	queryParams _ Dictionary new 
			at: 'username' put: aUser ; 
			at: 'password' put: aPassword ;
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

!TusLibrosWebTestObjectFactory methodsFor: 'as yet unclassified' stamp: 'ar 7/7/2019 15:58:19'!
createSalesBook
	^OrderedCollection new! !

!TusLibrosWebTestObjectFactory methodsFor: 'as yet unclassified' stamp: 'TF 7/8/2019 17:58:27'!
debit: arg1 from: arg2
	^ self.! !

!TusLibrosWebTestObjectFactory methodsFor: 'as yet unclassified' stamp: 'tf 7/9/2019 22:43:32'!
initialize
	storeTestObjectsFactory _ StoreTestObjectsFactory new.! !

!TusLibrosWebTestObjectFactory methodsFor: 'as yet unclassified' stamp: 'TF 7/9/2019 14:55:00'!
invalidUser
	^ 'noPrueba'! !

!TusLibrosWebTestObjectFactory methodsFor: 'as yet unclassified' stamp: 'TF 7/9/2019 14:55:43'!
invalidUserPassword
	^ 'noPrueba'! !

!TusLibrosWebTestObjectFactory methodsFor: 'as yet unclassified' stamp: 'TF 7/8/2019 16:41:52'!
storeTestObjectsFactory
	^storeTestObjectsFactory .! !

!TusLibrosWebTestObjectFactory methodsFor: 'as yet unclassified' stamp: 'tf 7/9/2019 22:43:24'!
tusLibrosSystemFacade
	
	^TusLibrosSystemFacade
		authenticatingWith: self validUsersAndPasswords 
		acceptingItemsOf:  storeTestObjectsFactory defaultCatalog
		registeringOn: self createSalesBook 
		debitingThrought: self
		measuringTimeWith: DateAndTime
! !

!TusLibrosWebTestObjectFactory methodsFor: 'as yet unclassified' stamp: 'ar 7/7/2019 16:01:19'!
validUser
	^ 'Prueba'! !

!TusLibrosWebTestObjectFactory methodsFor: 'as yet unclassified' stamp: 'ar 7/7/2019 16:01:32'!
validUserPassword
	^ 'Prueba'! !

!TusLibrosWebTestObjectFactory methodsFor: 'as yet unclassified' stamp: 'ar 7/7/2019 16:00:35'!
validUsersAndPasswords

	^Dictionary new
		at: self validUser put: self validUserPassword;
		yourself! !
