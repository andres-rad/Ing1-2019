!classDefinition: #CreateCartWindowModelTest category: #'TusLibros-Web'!
TestCase subclass: #CreateCartWindowModelTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Web'!

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


!classDefinition: #TusLibrosServerControllerTest category: #'TusLibros-Web'!
TestCase subclass: #TusLibrosServerControllerTest
	instanceVariableNames: 'port aSystemFacade testObjectsFactory storeTestObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Web'!

!TusLibrosServerControllerTest methodsFor: 'as yet unclassified' stamp: 'ar 7/7/2019 16:44:57'!
setUp
	testObjectsFactory _ TusLibrosWebTestObjectFactory new.
	aSystemFacade _ testObjectsFactory tusLibrosSystemFacade. ! !

!TusLibrosServerControllerTest methodsFor: 'as yet unclassified' stamp: 'ar 7/7/2019 15:42:09'!
test02PuedoCrearUnaInstanciaDelServidorQueEscucheEnUnPuertoEspecifico
	| aServerController |
	
	aServerController _ TusLibrosServerController listeningOn: 8888 withFacade: aSystemFacade.
	self assert: (aServerController port = 8888).! !

!TusLibrosServerControllerTest methodsFor: 'as yet unclassified' stamp: 'ar 7/7/2019 15:46:46'!
test03ElServerNoPuedeEscucharEnUnPuertoNegativo
	
	self should: [TusLibrosServerController listeningOn: -1 withFacade: aSystemFacade ]
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo: [:anError |
			self assert: anError messageText equals: TusLibrosServerController invalidPortNumberMessageError	
		].! !

!TusLibrosServerControllerTest methodsFor: 'as yet unclassified' stamp: 'ar 7/7/2019 15:46:52'!
test04ElServerNoPuedeEscucharEnUnMayorA65535
	
	self should: [TusLibrosServerController listeningOn: 3598102 withFacade: aSystemFacade ]
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo: [:anError |
			self assert: anError messageText equals: TusLibrosServerController invalidPortNumberMessageError	
		].! !

!TusLibrosServerControllerTest methodsFor: 'as yet unclassified' stamp: 'ar 7/7/2019 15:46:59'!
test05ElNumeroDePuertoTieneQueSerEntero
	
	self should: [TusLibrosServerController listeningOn: 80.5 withFacade: aSystemFacade ]
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo: [:anError |
			self assert: anError messageText equals: TusLibrosServerController invalidPortNumberMessageError	
		].! !

!TusLibrosServerControllerTest methodsFor: 'as yet unclassified' stamp: 'ar 7/7/2019 15:47:25'!
test06ElServidorDeTusLibrosTieneUnEndpointParaCrearUnCarrito
	| aServerController |
	
	aServerController _ TusLibrosServerController listeningOn: 8484 withFacade: aSystemFacade.
	
	self assert: ( aServerController webServer endpoints includes: TusLibrosServerController createCartEndpoint). ! !

!TusLibrosServerControllerTest methodsFor: 'as yet unclassified' stamp: 'ar 7/7/2019 16:24:11'!
test07IntentarCrearUnCarritoConUnUsuarioMalAutenticadoGeneraUnaRespuestaDeError404
	| httpResponse aServerController queryParams |
	
	aServerController _ TusLibrosServerController listeningOn: 8484 withFacade: aSystemFacade.
	queryParams _ Dictionary newFromPairs:  { 'user' . 'badUser' . 'password' . ''}.
	httpResponse _ WebClient htmlSubmit: 'http://localhost:8484/createCart' fields: queryParams.
	
	self deny: httpResponse isSuccess.
	self assert: httpResponse code = 404.! !

!TusLibrosServerControllerTest methodsFor: 'as yet unclassified' stamp: 'ar 7/7/2019 16:29:31'!
test08AlCrearUnCarritoConUnUsuarioValidoTengoUnaRespuesta200
	| httpResponse aServerController queryParams |
	
	aServerController _ TusLibrosServerController listeningOn: 8484 withFacade: aSystemFacade.
	queryParams _ Dictionary newFromPairs:  { 'username' . 'Prueba' . 'password' . 'Prueba'}.
	httpResponse _ WebClient htmlSubmit: 'http://localhost:8484/createCart' fields: queryParams.
	
	self assert: httpResponse isSuccess.
	self assert: httpResponse code = 200.! !

!TusLibrosServerControllerTest methodsFor: 'as yet unclassified' stamp: 'ar 7/7/2019 16:38:12'!
test09ElServidorDeTusLibrosTieneUnEndpointParaAgregarItemsAlCarrito
	| aServerController |
	
	aServerController _ TusLibrosServerController listeningOn: 8484 withFacade: aSystemFacade.
	
	self assert: ( aServerController webServer endpoints includes: TusLibrosServerController addToCartEndpoint). ! !

!TusLibrosServerControllerTest methodsFor: 'as yet unclassified' stamp: 'ar 7/7/2019 17:07:59'!
test10ReciboUnaRespuesta200AlAgregarItemsAlCarrito
	| aServerController cartId queryParams cartCreationResponse addToCartResponse|
	
	aServerController _ TusLibrosServerController listeningOn: 8484 withFacade: aSystemFacade.
	
	queryParams _ Dictionary newFromPairs: {'username' . testObjectsFactory validUser . 'password' . testObjectsFactory validUserPassword }.
	
	cartCreationResponse _ WebClient htmlSubmit: 'http://localhost:8484/createCart' fields: queryParams.
	cartId _ WebUtils jsonDecode: cartCreationResponse content readStream.
	
	queryParams _ Dictionary newFromPairs: { 'cartId' . cartId printString . 'bookISBN' . 'validBook' . 'bookQuantity' . '3' }.
	addToCartResponse  _ WebClient htmlSubmit: 'http://localhost:8484/addToCart' fields: queryParams.

	self assert: addToCartResponse code = 200.! !

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

!TusLibrosServerControllerTest methodsFor: 'as yet unclassified' stamp: 'ar 7/7/2019 17:49:37'!
test11ReciboUnaRespuesta404AlAgregarItemsDeUnLibroInexistente
	| aServerController queryParams addToCartResponse cartCreationResponse cartId |
	
	aServerController _ TusLibrosServerController listeningOn: 8484 withFacade: aSystemFacade.
	
	queryParams _ Dictionary newFromPairs: {'username' . testObjectsFactory validUser . 'password' . testObjectsFactory validUserPassword }.
	
	cartCreationResponse _ WebClient htmlSubmit: 'http://localhost:8484/createCart' fields: queryParams.
	cartId _ WebUtils jsonDecode: cartCreationResponse content readStream.
	
	queryParams _ Dictionary newFromPairs: { 'cartId' . cartId printString . 'bookISBN' . 'invalidBook' . 'bookQuantity' . '3' }.
	addToCartResponse  _ WebClient htmlSubmit: 'http://localhost:8484/addToCart' fields: queryParams.
	
	self assert: addToCartResponse code = 404.
	self assert: addToCartResponse content = 'Item is not in catalog'.! !

!TusLibrosServerControllerTest methodsFor: 'as yet unclassified' stamp: 'ar 7/7/2019 17:49:14'!
test12ReciboUnaRespuesta404AlAgregarItemsAUnCarritoInexistente
	| aServerController queryParams addToCartResponse|
	
	aServerController _ TusLibrosServerController listeningOn: 8484 withFacade: aSystemFacade.
	
	queryParams _ Dictionary newFromPairs: { 'cartId' . '-1835140' . 'bookISBN' . 'validBook' . 'bookQuantity' . '3' }.
	addToCartResponse  _ WebClient htmlSubmit: 'http://localhost:8484/addToCart' fields: queryParams.
	
	self assert: addToCartResponse code = 404.
	self assert: addToCartResponse content = 'Invalid cart id'.! !

!TusLibrosServerControllerTest methodsFor: 'as yet unclassified' stamp: 'ar 7/7/2019 17:50:55'!
test13ElServidorDeTusLibrosTieneUnEndpointParaHacerCheckoutDelCarrito
	| aServerController |
	
	aServerController _ TusLibrosServerController listeningOn: 8484 withFacade: aSystemFacade.
	
	self assert: ( aServerController webServer endpoints includes: TusLibrosServerController checkoutCartEndpoint). ! !


!classDefinition: #TusLibrosWebClientTest category: #'TusLibros-Web'!
TestCase subclass: #TusLibrosWebClientTest
	instanceVariableNames: 'port'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Web'!

!TusLibrosWebClientTest methodsFor: 'as yet unclassified' stamp: 'ar 7/7/2019 11:42:55'!
test01ElClienteEnviaPorDefectoAlPuerto8080

	| webClient |
	
	webClient _ TusLibrosWebClient new.
	
	self assert: (webClient port = 8080).! !

!TusLibrosWebClientTest methodsFor: 'as yet unclassified' stamp: 'ar 7/7/2019 11:53:20'!
test02PuedoSetearAlClienteParaQueEnvieAUnPuertoEspecifico

	| webClient |
	
	webClient _ TusLibrosWebClient sendingToPort: 9876.
	
	self assert: (webClient port = 9876).! !

!TusLibrosWebClientTest methodsFor: 'as yet unclassified' stamp: 'ar 7/7/2019 11:53:20'!
test03ElClienteNoPuedeEnviarAUnPuertoNegativo
	self should: [TusLibrosWebClient sendingToPort: -1]
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo: [:anError |
			self assert: anError messageText equals: TusLibrosWebClient invalidPortNumberMessageError	
		].! !

!TusLibrosWebClientTest methodsFor: 'as yet unclassified' stamp: 'ar 7/7/2019 11:53:20'!
test04ElClienteNoPuedeEnviarAUnPuertoMayorA65535

	| webClient |
	
	self should: [webClient _ TusLibrosWebClient sendingToPort: 987654]
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo: [:anError |
			self assert: anError messageText equals: TusLibrosWebClient invalidPortNumberMessageError	
		].! !

!TusLibrosWebClientTest methodsFor: 'as yet unclassified' stamp: 'ar 7/7/2019 11:53:20'!
test05ElNumeroDePuertoDelClienteTieneQueSerUnNumeroEntero

	| webClient |
	
	self should: [webClient _ TusLibrosWebClient sendingToPort: 1.31]
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo: [:anError |
			self assert: anError messageText equals: TusLibrosWebClient invalidPortNumberMessageError	
		].! !


!classDefinition: #CreateCartWindowModel category: #'TusLibros-Web'!
Object subclass: #CreateCartWindowModel
	instanceVariableNames: 'username password'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Web'!

!CreateCartWindowModel methodsFor: 'accessing' stamp: 'ar 7/7/2019 11:03:20'!
initialize
	username _ ''.
	password _ ''.! !

!CreateCartWindowModel methodsFor: 'accessing' stamp: 'ar 7/7/2019 11:03:02'!
password
	^password.! !

!CreateCartWindowModel methodsFor: 'accessing' stamp: 'ar 7/7/2019 11:02:07'!
username
	^username! !


!CreateCartWindowModel methodsFor: 'as yet unclassified' stamp: 'ar 7/7/2019 11:08:58'!
username: aUsername 
	username _ aUsername.
	^true.! !


!CreateCartWindowModel methodsFor: 'binding' stamp: 'ar 7/7/2019 11:09:15'!
password: aPassword
	password _ aPassword.
	^true.! !


!classDefinition: #TusLibrosServerController category: #'TusLibros-Web'!
Object subclass: #TusLibrosServerController
	instanceVariableNames: 'port webServer tusLibrosFacade'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Web'!

!TusLibrosServerController methodsFor: 'accessing' stamp: 'ar 7/7/2019 11:51:07'!
port
	^port.! !


!TusLibrosServerController methodsFor: 'as yet unclassified' stamp: 'ar 7/7/2019 12:02:40'!
isValidPortNumber: aPort
	^ aPort isInteger  and: [aPort between: 1 and: 65535].! !

!TusLibrosServerController methodsFor: 'as yet unclassified' stamp: 'ar 7/7/2019 17:52:37'!
listeningOn: aPort withFacade: aSystemFacade
	(self isValidPortNumber: aPort) ifFalse: [ self signalInvalidPort].
	
	port _ aPort.
	tusLibrosFacade _ aSystemFacade.
	webServer _ WebServer new listenOn: self port.
	
	self registerCreateCart.
	self registerAddToCart.
	self registerCheckoutCart.! !

!TusLibrosServerController methodsFor: 'as yet unclassified' stamp: 'ar 7/7/2019 11:54:57'!
signalInvalidPort
	self error: self class invalidPortNumberMessageError.! !

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

!TusLibrosServerController methodsFor: 'services' stamp: 'ar 7/7/2019 17:51:56'!
registerCheckoutCart
	webServer addService: self class checkoutCartEndpoint 
				action: [].! !

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

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosServerController class' category: #'TusLibros-Web'!
TusLibrosServerController class
	instanceVariableNames: ''!

!TusLibrosServerController class methodsFor: 'as yet unclassified' stamp: 'ar 7/7/2019 16:39:00'!
addToCartEndpoint
	^'/addtocart'.! !

!TusLibrosServerController class methodsFor: 'as yet unclassified' stamp: 'ar 7/7/2019 17:51:22'!
checkoutCartEndpoint
	^'/checkoutcart'.! !

!TusLibrosServerController class methodsFor: 'as yet unclassified' stamp: 'ar 7/7/2019 14:51:03'!
createCartEndpoint
	^'/createcart'.! !

!TusLibrosServerController class methodsFor: 'as yet unclassified' stamp: 'ar 7/7/2019 11:54:31'!
invalidPortNumberMessageError
	^ 'El numero de puerto tiene que ser un numero entero entre 1 y 65535'.! !

!TusLibrosServerController class methodsFor: 'as yet unclassified' stamp: 'ar 7/7/2019 15:14:21'!
listeningOn: aPort withFacade: aSystemFacade
	^self new listeningOn: aPort withFacade: aSystemFacade .! !


!classDefinition: #TusLibrosWebClient category: #'TusLibros-Web'!
Object subclass: #TusLibrosWebClient
	instanceVariableNames: 'port'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Web'!

!TusLibrosWebClient methodsFor: 'as yet unclassified' stamp: 'ar 7/7/2019 11:21:24'!
initialize
	port _ 8080.! !

!TusLibrosWebClient methodsFor: 'as yet unclassified' stamp: 'ar 7/7/2019 11:34:11'!
isValidPortNumber: aPort

	^ aPort isInteger and: [aPort between: 1 and: 65535].! !

!TusLibrosWebClient methodsFor: 'as yet unclassified' stamp: 'ar 7/7/2019 11:20:32'!
port
	^port.! !

!TusLibrosWebClient methodsFor: 'as yet unclassified' stamp: 'ar 7/7/2019 17:53:22'!
sendUserLogin: aUser withPassword: aPassword
	! !

!TusLibrosWebClient methodsFor: 'as yet unclassified' stamp: 'ar 7/7/2019 11:57:02'!
sendingToPort: aPort
	(self isValidPortNumber: aPort) ifFalse: [ self signalInvalidPort ].
	port _ aPort.! !

!TusLibrosWebClient methodsFor: 'as yet unclassified' stamp: 'ar 7/7/2019 11:16:36'!
url
	^'http://localhost:',  self port asString.! !


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

!TusLibrosWebClient class methodsFor: 'as yet unclassified' stamp: 'ar 7/7/2019 11:53:20'!
sendingToPort: aPort
	^self new sendingToPort: aPort.! !


!classDefinition: #TusLibrosWebTestObjectFactory category: #'TusLibros-Web'!
Object subclass: #TusLibrosWebTestObjectFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Web'!

!TusLibrosWebTestObjectFactory methodsFor: 'as yet unclassified' stamp: 'ar 7/7/2019 15:58:19'!
createSalesBook
	^OrderedCollection new! !

!TusLibrosWebTestObjectFactory methodsFor: 'as yet unclassified' stamp: 'ar 7/7/2019 16:01:05'!
tusLibrosSystemFacade
	| testObjectsFactory |
	
	testObjectsFactory _ StoreTestObjectsFactory new.
	
	^TusLibrosSystemFacade
		authenticatingWith: self validUsersAndPasswords 
		acceptingItemsOf:  testObjectsFactory defaultCatalog
		registeringOn: self createSalesBook 
		debitingThrought: nil
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
