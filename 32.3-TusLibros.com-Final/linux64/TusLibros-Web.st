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

!CreateCartWindow methodsFor: 'as yet unclassified' stamp: 'TF 7/9/2019 17:13:21'!
goToStore
	| cartId |
	
	cartId _ model cartId.
	
	self delete .! !

!CreateCartWindow methodsFor: 'as yet unclassified' stamp: 'TF 7/9/2019 17:11:23'!
initializeWith: aTitle
	self titleMorph showButtonsNamed: #(#close #collapse).
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
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Web'!


!classDefinition: #CreateCartWindowModelTest category: #'TusLibros-Web'!
TestCase subclass: #CreateCartWindowModelTest
	instanceVariableNames: 'webClientRequestBlock windowModel'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Web'!

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

!CreateCartWindowModelTest methodsFor: 'as yet unclassified' stamp: 'TF 7/9/2019 16:20:06'!
test06SiElWebClientCreaElCarritoElModeloGuardaElIdYDisparaElEventoDeCreacionExitosa
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


!classDefinition: #TusLibrosServerControllerTest category: #'TusLibros-Web'!
TestCase subclass: #TusLibrosServerControllerTest
	instanceVariableNames: 'port aSystemFacade testObjectsFactory storeTestObjectsFactory aDefaultServerController'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Web'!

!TusLibrosServerControllerTest methodsFor: 'test - port' stamp: 'ar 7/7/2019 15:42:09'!
test02PuedoCrearUnaInstanciaDelServidorQueEscucheEnUnPuertoEspecifico
	| aServerController |
	
	aServerController _ TusLibrosServerController listeningOn: 8888 withFacade: aSystemFacade.
	self assert: (aServerController port = 8888).! !

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


!TusLibrosWebClientTest methodsFor: 'as yet unclassified' stamp: 'TF 7/9/2019 15:28:40'!
htmlSubmit: url fields: fields
	^onHtmlSubmitBlock value: url value: fields.! !

!TusLibrosWebClientTest methodsFor: 'as yet unclassified' stamp: 'TF 7/9/2019 15:19:19'!
setUp
	onHtmlSubmitBlock _ [:a :b |].
	defaultWebClient _ TusLibrosWebClient sendingToPort: 8484 withUrl: 'http://tusLibros.com'  withWebClient: self. 
	testObjectFactory _ TusLibrosWebTestObjectFactory new.! !

!TusLibrosWebClientTest methodsFor: 'as yet unclassified' stamp: 'TF 7/9/2019 16:59:55'!
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

!TusLibrosWebClientTest methodsFor: 'as yet unclassified' stamp: 'TF 7/9/2019 16:59:44'!
test07SiElRequestAlServidorDeCrearUnCarritoDaErrorElWebClientLevantaUnaExcepcion
		
	onHtmlSubmitBlock _ [:url :fields | 
		self assert: url equals: 'http://tusLibros.com:8484/createcart'.
		self assert: (fields at: 'username') equals: testObjectFactory validUser .
		self assert: (fields at: 'password') equals: testObjectFactory validUserPassword .
		^(WebResponse protocol: 'http' code: 404) content: 'Error!!'; yourself. 
	].

	self should: [defaultWebClient createCartFor: testObjectFactory validUser authenticatedWith: testObjectFactory validUserPassword ]
		 raise:  Error - MessageNotUnderstood 
		withMessageText: 'Error!!'.
	
! !


!classDefinition: #CreateCartWindowModel category: #'TusLibros-Web'!
Object subclass: #CreateCartWindowModel
	instanceVariableNames: 'username password webClient cartId'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Web'!

!CreateCartWindowModel methodsFor: 'accessing' stamp: 'TF 7/9/2019 15:56:05'!
initialize
	webClient _ TusLibrosWebClient new.
	username _ ''.
	password _ ''.! !

!CreateCartWindowModel methodsFor: 'accessing' stamp: 'TF 7/9/2019 15:55:51'!
initializeWithWebClient: aWebClient
	webClient _ aWebClient.
	username _ ''.
	password _ ''.! !

!CreateCartWindowModel methodsFor: 'accessing' stamp: 'TF 7/9/2019 16:47:19'!
password
	^password.! !

!CreateCartWindowModel methodsFor: 'accessing' stamp: 'TF 7/9/2019 16:49:55'!
sendCreateCartRequest

	[
		cartId _ webClient createCartFor: username authenticatedWith: password.
		self triggerEvent: #cartCreationSuccess .
	] on: Error 
	 do: [:anError |
			self triggerEvent: #cartCreationFailed with: anError messageText .
		]! !

!CreateCartWindowModel methodsFor: 'accessing' stamp: 'ar 7/7/2019 11:02:07'!
username
	^username! !


!CreateCartWindowModel methodsFor: 'as yet unclassified' stamp: 'TF 7/9/2019 16:14:41'!
cartId

	^cartId! !

!CreateCartWindowModel methodsFor: 'as yet unclassified' stamp: 'ar 7/7/2019 11:08:58'!
username: aUsername 
	username _ aUsername.
	^true.! !


!CreateCartWindowModel methodsFor: 'binding' stamp: 'TF 7/9/2019 16:49:35'!
password: aPassword
	password _ aPassword.
	^true.! !

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

!TusLibrosWebClient methodsFor: 'as yet unclassified' stamp: 'TF 7/9/2019 16:59:32'!
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

!TusLibrosWebClient methodsFor: 'as yet unclassified' stamp: 'TF 7/9/2019 15:12:38'!
initialize
	self sendingToPort: 8080 withUrl: 'http://localhost'  andWebClient: WebClient .! !

!TusLibrosWebClient methodsFor: 'as yet unclassified' stamp: 'ar 7/7/2019 11:34:11'!
isValidPortNumber: aPort

	^ aPort isInteger and: [aPort between: 1 and: 65535].! !

!TusLibrosWebClient methodsFor: 'as yet unclassified' stamp: 'ar 7/7/2019 11:20:32'!
port
	^port.! !

!TusLibrosWebClient methodsFor: 'as yet unclassified' stamp: 'TF 7/9/2019 15:11:42'!
sendingToPort: aPort withUrl: anUrl andWebClient: aWebClient .
	(self isValidPortNumber: aPort) ifFalse: [ self signalInvalidPort ].
	url _ anUrl .
	port _ aPort.
	webClient _ aWebClient .! !

!TusLibrosWebClient methodsFor: 'as yet unclassified' stamp: 'TF 7/9/2019 15:27:49'!
url
	^url, ':',  self port asString.! !


!TusLibrosWebClient methodsFor: 'error messages' stamp: 'ar 7/7/2019 11:31:14'!
signalInvalidPort
	self error: self class invalidPortNumberMessageError.! !

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

!TusLibrosWebTestObjectFactory methodsFor: 'as yet unclassified' stamp: 'TF 7/9/2019 14:55:00'!
invalidUser
	^ 'noPrueba'! !

!TusLibrosWebTestObjectFactory methodsFor: 'as yet unclassified' stamp: 'TF 7/9/2019 14:55:43'!
invalidUserPassword
	^ 'noPrueba'! !

!TusLibrosWebTestObjectFactory methodsFor: 'as yet unclassified' stamp: 'TF 7/8/2019 16:41:52'!
storeTestObjectsFactory
	^storeTestObjectsFactory .! !

!TusLibrosWebTestObjectFactory methodsFor: 'as yet unclassified' stamp: 'TF 7/8/2019 17:58:40'!
tusLibrosSystemFacade
	
	storeTestObjectsFactory _ StoreTestObjectsFactory new.
	
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
