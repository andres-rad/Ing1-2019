!classDefinition: #AccountSummaryTest category: #'Portfolio-Solucion'!
TestCase subclass: #AccountSummaryTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummaryTest methodsFor: 'tests' stamp: 'TF 6/2/2019 11:06:41'!
test01AccountSummaryOfEmptyAccountIsEmpty
	| anAccount aSummary aReport |
	
	anAccount := ReceptiveAccount new.
	aSummary := AccountSummary from: anAccount .
	aReport := aSummary get.
	
	self assert: aReport size equals: 1.
	self assert: (aReport at: 1) equals: 'Balance = 0'. ! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'TF 6/2/2019 15:35:00'!
test02AccountSummaryOfAccountWithOnlyDepositIsExpected
	| anAccount aSummary aReport |
	
	anAccount := ReceptiveAccount new .
	Deposit register: 18 on: anAccount .
	aSummary := AccountSummary from: anAccount .
	aReport := aSummary get.
	
	self assert: aReport size equals: 2.
	self assert: aReport first equals: 'Depósito por 18.'. 
	self assert: aReport last equals: 'Balance = 18'.! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'TF 6/2/2019 15:35:04'!
test03AccountSummaryOfAccountWithOnlyWithdrawIsExpected
	| anAccount aSummary aReport |
	
	anAccount := ReceptiveAccount new .
	Withdraw register: 18 on: anAccount .
	aSummary := AccountSummary from: anAccount .
	aReport := aSummary get.
	
	self assert: aReport size equals: 2.
	self assert: aReport first equals: 'Extracción por 18.'. 
	self assert: aReport last equals: 'Balance = -18'.! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'TF 6/2/2019 15:35:07'!
test04AccountSummaryOfAccountWithOnlyTransferWithdrawIsExpected
	| anAccount aSummary aReport |
	
	anAccount := ReceptiveAccount new .
	Transfer register: 18 from: anAccount to: ReceptiveAccount new.
	aSummary := AccountSummary from: anAccount .
	aReport := aSummary get.
	
	self assert: aReport size equals: 2.
	self assert: aReport first equals: 'Salida por transferencia de 18.'. 
	self assert: aReport last equals: 'Balance = -18'.! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'TF 6/2/2019 15:35:11'!
test05AccountSummaryOfAccountWithOnlyTransferDepositIsExpected
	| anAccount aSummary aReport |
	
	anAccount := ReceptiveAccount new .
	Transfer register: 18 from:  ReceptiveAccount new to: anAccount.
	aSummary := AccountSummary from: anAccount .
	aReport := aSummary get.
	
	self assert: aReport size equals: 2.
	self assert: aReport first equals: 'Entrada por transferencia de 18.'. 
	self assert: aReport last equals: 'Balance = 18'.! !


!classDefinition: #PortfolioStructureTest category: #'Portfolio-Solucion'!
TestCase subclass: #PortfolioStructureTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioStructureTest methodsFor: 'tests' stamp: 'TF 6/3/2019 13:22:52'!
test01PortfolioStructureOfEmptyPortfolioHasOnlyOneElement
	| aPortfolioStructure aPortfolio |
	
	aPortfolio := Portfolio named: 'Mi Portfolio'.
	aPortfolioStructure := PortfolioStructure from: aPortfolio .
	
	self assert: aPortfolioStructure get first equals: 'Mi Portfolio'. 
	
	self assert: aPortfolioStructure get size equals: 1. ! !

!PortfolioStructureTest methodsFor: 'tests' stamp: 'TF 6/3/2019 11:35:55'!
test02PortfolioWithDepth2ShowsCorrectlyIndented
	| aPortfolioStructure aPortfolio anotherPortfolio aReceptiveAccount aPortfolioStructureReport |
	
	anotherPortfolio := Portfolio named: 'Mi Portfolio de abajo'.
	aReceptiveAccount := ReceptiveAccount named: 'Mi Cuenta'.
	aPortfolio := Portfolio named: 'Mi Portfolio raiz' with: anotherPortfolio with: aReceptiveAccount .
	
	aPortfolioStructure := PortfolioStructure from: aPortfolio .
	aPortfolioStructureReport := aPortfolioStructure get.
	
	self assert: aPortfolioStructureReport first equals: 'Mi Portfolio raiz'. 
	self assert: aPortfolioStructureReport second equals:  '    ', 'Mi Portfolio de abajo'.
	self assert: aPortfolioStructureReport third equals:  '    ', 'Mi Cuenta'.
	
	self assert: aPortfolioStructureReport size equals: 3.! !

!PortfolioStructureTest methodsFor: 'tests' stamp: 'TF 6/3/2019 11:47:47'!
test03PortfolioWithDepth3OrMoreShowsRight
	| aPortfolioStructure aPortfolioStructureReport angiesAccount childrenPortfolio familyPortfolio johnsAccount myAccount |
	
	johnsAccount := ReceptiveAccount named: 'Cuenta de Juan'.
	angiesAccount := ReceptiveAccount named: 'Cuenta de Angeles'.
	childrenPortfolio := Portfolio named: 'Portfolio de hijos' with: johnsAccount with: angiesAccount.
	myAccount := ReceptiveAccount named: 'Cuenta Mia'.
	familyPortfolio := Portfolio named: 'Portfolio de la familia' with: myAccount with: childrenPortfolio.
	
	aPortfolioStructure := PortfolioStructure from: familyPortfolio .
	aPortfolioStructureReport := aPortfolioStructure get.
	
	self assert: aPortfolioStructureReport first equals: 'Portfolio de la familia'. 
	self assert: aPortfolioStructureReport second equals:  '    ', 'Cuenta Mia'.
	self assert: aPortfolioStructureReport third equals:  '    ', 'Portfolio de hijos'.
	self assert: aPortfolioStructureReport fourth equals:  '    ', '    ', 'Cuenta de Juan'.
	self assert: aPortfolioStructureReport fifth equals:  '    ', '    ', 'Cuenta de Angeles'.
	
	self assert: aPortfolioStructureReport size equals: 5.! !


!classDefinition: #PortfolioTest category: #'Portfolio-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:17:51'!
test02BalanceOfPortfolioWithOneAccountIsAccountBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:15'!
test08PortfolioTransasctionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!PortfolioTest methodsFor: 'tests - Transfers' stamp: 'TF 5/31/2019 23:02:46'!
test16ADefaultTransferHasValueZero
	| aTransfer |
	
	aTransfer := Transfer new.
	
	self assert: aTransfer value equals: 0.
! !

!PortfolioTest methodsFor: 'tests - Transfers' stamp: 'TF 5/31/2019 23:06:46'!
test17ADefaultTransferHasADepositLegPointingToIt
	| aTransfer |
	
	aTransfer := Transfer new.
	
	self assert: aTransfer depositLeg transfer equals: aTransfer .
! !

!PortfolioTest methodsFor: 'tests - Transfers' stamp: 'TF 5/31/2019 23:06:36'!
test18ADefaultTransferHasAWithdrawLegPointingToIt
	| aTransfer |
	
	aTransfer := Transfer new.
	
	self assert: aTransfer withdrawLeg transfer equals: aTransfer .
! !

!PortfolioTest methodsFor: 'tests - Transfers' stamp: 'TF 5/31/2019 23:10:44'!
test19ATransferAndItsLegsHaveTheCorrectValue
	| aTransfer anAmount |
	
	anAmount := 42.
	
	aTransfer := Transfer with: anAmount.
	
	self assert: aTransfer value equals: anAmount .
	self assert: aTransfer depositLeg value equals: anAmount .
	self assert: aTransfer withdrawLeg value equals: anAmount .
! !

!PortfolioTest methodsFor: 'tests - Transfers' stamp: 'TF 6/2/2019 10:38:17'!
test20ATransferModifiesBothOfItsAccounts
	| anAccount anotherAccount anAmount |
	
	anAmount := 42.
	anAccount := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	Transfer register: anAmount from: anAccount to: anotherAccount .
	
	self assert: anAccount balance equals: anAmount negated .
	self assert: anotherAccount balance equals: anAmount  .

! !


!PortfolioTest methodsFor: 'tests - Name' stamp: 'TF 6/3/2019 11:18:05'!
test21PortfolioKnowsItsName
	
	| aPortfolio aName |
	
	aName := ' el portfolio de todos'.
	aPortfolio := Portfolio named: aName.
	
	self assert: aPortfolio name equals: aName .! !

!PortfolioTest methodsFor: 'tests - Name' stamp: 'TF 6/3/2019 11:18:34'!
test22PortfolioWithoutANameHasAGenericOne
	
	| aPortfolio |

	aPortfolio := Portfolio new.
	
	self assert: aPortfolio name equals: 'a Portfolio' .! !


!classDefinition: #ReceptiveAccountTest category: #'Portfolio-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'TF 6/3/2019 11:12:17'!
test08ReceptiveAccountKnowsItsName

	| anAccountName account1 |
	
	anAccountName := 'la cuenta de pepe'.
	account1 := ReceptiveAccount named: anAccountName .
	
	self assert: account1 name equals: anAccountName .! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'TF 6/3/2019 11:15:13'!
test09ReceptiveAccountWithoutNameHasAGenericOne

	| account1 |
	
	
	account1 := ReceptiveAccount new .
	
	self assert: account1 name equals: 'a ReceptiveAccount' .! !


!classDefinition: #SpecialAccountSummaryTest category: #'Portfolio-Solucion'!
TestCase subclass: #SpecialAccountSummaryTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!SpecialAccountSummaryTest methodsFor: 'tests' stamp: 'TF 6/3/2019 12:36:49'!
test01SpecialAccountSummaryOfEmptyPortfolioHasOnlyOneElement
	| aSpecialSummary aPortfolio |
	
	aPortfolio := Portfolio named: 'Mi Portfolio'.
	aSpecialSummary := SpecialAccountSummary from: aPortfolio .
	
	self assert: aSpecialSummary get first equals: 'Mi Portfolio'. 
	
	self assert: aSpecialSummary get size equals: 1. ! !

!SpecialAccountSummaryTest methodsFor: 'tests' stamp: 'TF 6/3/2019 12:42:57'!
test02PortfolioWithOnlyPortfoliosShowsCorrectlyIndented
	| aSpecialAccountSummary aRootPortfolio aMiddlePortfolio aSpecialAccountSummaryReport aBottomPortfolio |
	
	aBottomPortfolio := Portfolio named: 'Mi Portfolio de abajo'.
	aMiddlePortfolio := Portfolio named: 'Mi Portfolio del medio' with: aBottomPortfolio.
	aRootPortfolio := Portfolio named: 'Mi Portfolio raiz' with: aMiddlePortfolio .
	
	aSpecialAccountSummary := SpecialAccountSummary from: aRootPortfolio .
	aSpecialAccountSummaryReport := aSpecialAccountSummary get.
	
	self assert: aSpecialAccountSummaryReport first equals: 'Mi Portfolio raiz'. 
	self assert: aSpecialAccountSummaryReport second equals:  '    ', 'Mi Portfolio del medio'.
	self assert: aSpecialAccountSummaryReport third equals:  '    ', '    ', 'Mi Portfolio de abajo'.
	
	self assert: aSpecialAccountSummaryReport size equals: 3.! !

!SpecialAccountSummaryTest methodsFor: 'tests' stamp: 'TF 6/3/2019 13:01:42'!
test03PortfolioWithEmptyAccountsShowsAsExpected
	| aSpecialAccountSummary aSpecialAccountSummaryReport angiesAccount childrenPortfolio familyPortfolio johnsAccount myAccount |
	
	johnsAccount := ReceptiveAccount named: 'Cuenta de Juan'.
	angiesAccount := ReceptiveAccount named: 'Cuenta de Angeles'.
	childrenPortfolio := Portfolio named: 'Portfolio de hijos' with: johnsAccount with: angiesAccount.
	myAccount := ReceptiveAccount named: 'Cuenta Mia'.
	familyPortfolio := Portfolio named: 'Portfolio de la familia' with: myAccount with: childrenPortfolio.
	
	aSpecialAccountSummary := SpecialAccountSummary from: familyPortfolio .
	aSpecialAccountSummaryReport := aSpecialAccountSummary get.
	
	self assert: aSpecialAccountSummaryReport first equals: 'Portfolio de la familia'. 
	self assert: aSpecialAccountSummaryReport second equals:  '    ', 'Cuenta Mia'.
	self assert: aSpecialAccountSummaryReport third equals:  '    ', '    ', 'Balance = 0'.
	self assert: aSpecialAccountSummaryReport fourth equals:  '    ', 'Portfolio de hijos'.
	self assert: aSpecialAccountSummaryReport fifth equals:  '    ', '    ', 'Cuenta de Juan'.
	self assert: aSpecialAccountSummaryReport sixth equals:  '    ', '    ', '    ', 'Balance = 0'.
	self assert: aSpecialAccountSummaryReport seventh equals:  '    ', '    ', 'Cuenta de Angeles'.
	self assert: aSpecialAccountSummaryReport eighth equals:  '    ', '    ', '    ', 'Balance = 0'.
	
	self assert: aSpecialAccountSummaryReport size equals: 8.! !

!SpecialAccountSummaryTest methodsFor: 'tests' stamp: 'TF 6/3/2019 13:03:29'!
test04PortfolioWithAccountsAndTransactionsShowsAsExpected
	| aSpecialAccountSummary aSpecialAccountSummaryReport angiesAccount childrenPortfolio familyPortfolio johnsAccount myAccount |
	
	johnsAccount := ReceptiveAccount named: 'Cuenta de Juan'.
	Deposit register: 250 on: johnsAccount.
	
	angiesAccount := ReceptiveAccount named: 'Cuenta de Angeles'.
	Transfer register: 50 from: angiesAccount  to: johnsAccount .
	Withdraw register: 25 on: angiesAccount.
	
	childrenPortfolio := Portfolio named: 'Portfolio de hijos' with: johnsAccount with: angiesAccount.
	myAccount := ReceptiveAccount named: 'Cuenta Mia'.
	Transfer register: 100 from: johnsAccount  to: myAccount .
	
	familyPortfolio := Portfolio named: 'Portfolio de la familia' with: myAccount with: childrenPortfolio.
	
	aSpecialAccountSummary := SpecialAccountSummary from: familyPortfolio .
	aSpecialAccountSummaryReport := aSpecialAccountSummary get.
	
	self assert: aSpecialAccountSummaryReport first equals: 'Portfolio de la familia'. 
	self assert: aSpecialAccountSummaryReport second equals:  '    ', 'Cuenta Mia'.
	self assert: aSpecialAccountSummaryReport third equals:  '    ', '    ', 'Entrada por transferencia de 100.'.
	self assert: aSpecialAccountSummaryReport fourth equals:  '    ', '    ', 'Balance = 100'.
	self assert: aSpecialAccountSummaryReport fifth equals:  '    ', 'Portfolio de hijos'.
	self assert: aSpecialAccountSummaryReport sixth equals:  '    ', '    ', 'Cuenta de Juan'.
	self assert: aSpecialAccountSummaryReport seventh equals:  '    ', '    ', '    ', 'Depósito por 250.'.
	self assert: aSpecialAccountSummaryReport eighth equals:  '    ', '    ', '    ', 'Entrada por transferencia de 50.'.
	self assert: aSpecialAccountSummaryReport ninth equals:  '    ', '    ', '    ', 'Salida por transferencia de 100.'.
	self assert: (aSpecialAccountSummaryReport at: 10) equals:  '    ', '    ', '    ', 'Balance = 200'.
	self assert: (aSpecialAccountSummaryReport at: 11) equals:  '    ', '    ', 'Cuenta de Angeles'.
	self assert: (aSpecialAccountSummaryReport at: 12) equals:  '    ', '    ', '    ', 'Salida por transferencia de 50.'.
	self assert: (aSpecialAccountSummaryReport at: 13) equals:  '    ', '    ', '    ', 'Extracción por 25.'.
	self assert: (aSpecialAccountSummaryReport at: 14) equals:  '    ', '    ', '    ', 'Balance = -75'.
	
	self assert: aSpecialAccountSummaryReport size equals: 14.! !


!classDefinition: #TransferNetTest category: #'Portfolio-Solucion'!
TestCase subclass: #TransferNetTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNetTest methodsFor: 'tests' stamp: 'TF 6/2/2019 10:58:59'!
test01TransferNetFromEmptyAccountIsZero
	| anAccount transferNet |
	
	anAccount := ReceptiveAccount new.
	
	transferNet := TransferNet from: anAccount .
	
	self assert: transferNet get equals: 0 .

! !

!TransferNetTest methodsFor: 'tests' stamp: 'TF 6/2/2019 10:59:09'!
test02TransferNetFromAccountIsTheSumOfTransfersWhenTheresOnlyTransfers
	| anAccount transferNet |
	
	anAccount := ReceptiveAccount new.

	Transfer register: 10 from: anAccount to: ReceptiveAccount new.
	Transfer register: 20 from: ReceptiveAccount new to: anAccount .
	
	transferNet := TransferNet from: anAccount .
	
	self assert: transferNet get equals: 10 .

! !

!TransferNetTest methodsFor: 'tests' stamp: 'TF 6/2/2019 10:59:21'!
test03TransferNetFromAccountIsTheSumOfTransfersWhenTheresAlsoOtherOperations
	| anAccount transferNet |
	
	anAccount := ReceptiveAccount new.
	
	Deposit register: 15 on: anAccount .
	Withdraw register: 35 on: anAccount .
	Transfer register: 10 from: anAccount to: ReceptiveAccount new.
	Transfer register: 20 from: ReceptiveAccount new to: anAccount .
	
	transferNet := TransferNet from: anAccount .
	
	self assert: transferNet get equals: 10 .

! !


!classDefinition: #Account category: #'Portfolio-Solucion'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!Account methodsFor: 'visitor' stamp: 'TF 6/3/2019 11:56:25'!
accept: aVisitor
	self subclassResponsibility .! !


!classDefinition: #Portfolio category: #'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Portfolio methodsFor: 'accounts management' stamp: 'TF 6/3/2019 11:39:37'!
accounts
	
	^accounts! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'TF 6/3/2019 11:18:52'!
initialize

	name := super name.
	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !

!Portfolio methodsFor: 'initialization' stamp: 'TF 6/3/2019 11:17:39'!
initializeWithName: aName 
	self initialize .
	name := aName .! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !

!Portfolio methodsFor: 'testing' stamp: 'TF 6/3/2019 11:17:54'!
name
	^name.! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'visitor' stamp: 'TF 6/3/2019 11:57:00'!
accept: aVisitor
	^aVisitor visitPortfolio: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'TF 6/3/2019 11:17:24'!
named: aName 
	^self new initializeWithName: aName .! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'TF 6/3/2019 12:43:54'!
named: aName with: anAccount 

	| aPortfolio |
	aPortfolio := self new initializeWithName: aName.
	aPortfolio add: anAccount .

	^aPortfolio .! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'TF 6/3/2019 11:40:35'!
named: aName with: anAccount with: anotherAccount 
	| aPortfolio |
	aPortfolio := self new initializeWithName: aName.
	aPortfolio add: anAccount .
	aPortfolio add: anotherAccount .
	
	^aPortfolio .! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'TF 6/3/2019 11:15:37'!
initialize

	super initialize.
	transactions := OrderedCollection new.
	name := super name.! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'TF 6/3/2019 11:13:52'!
initializeWithName: aName 
	self initialize .
	name := aName .! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'TF 6/3/2019 11:14:31'!
name
	^name.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 10/11/2018 16:53:54'!
hasRegistered: aTtransaction

	^ transactions includes: aTtransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'visitor' stamp: 'TF 6/3/2019 11:57:05'!
accept: aVisitor
	^aVisitor visitReceptiveAccount: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: #'Portfolio-Solucion'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'as yet unclassified' stamp: 'TF 6/3/2019 11:12:45'!
named: aName 
	^self new initializeWithName: aName .! !


!classDefinition: #AccountTransaction category: #'Portfolio-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'visitor' stamp: 'TF 6/3/2019 10:52:49'!
accept: aVisitor
	self subclassResponsibility .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Solucion'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #Deposit category: #'Portfolio-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'visitor' stamp: 'TF 6/3/2019 10:53:11'!
accept: aVisitor
	^aVisitor visitDeposit: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferDeposit category: #'Portfolio-Solucion'!
AccountTransaction subclass: #TransferDeposit
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferDeposit methodsFor: 'visitor' stamp: 'TF 6/3/2019 10:53:21'!
accept: aVisitor
	^aVisitor visitTransferDeposit: self.! !


!TransferDeposit methodsFor: 'balance' stamp: 'TF 5/31/2019 23:20:21'!
affectBalance: aBalance

	^aBalance + self value .! !


!TransferDeposit methodsFor: 'value' stamp: 'TF 5/31/2019 23:12:42'!
value
	^transfer value .! !


!TransferDeposit methodsFor: 'initialization' stamp: 'TF 5/31/2019 23:05:39'!
initializeWith: aTransfer
	transfer := aTransfer .! !


!TransferDeposit methodsFor: 'testing' stamp: 'TF 5/31/2019 23:06:12'!
transfer
	
	^transfer! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferDeposit class' category: #'Portfolio-Solucion'!
TransferDeposit class
	instanceVariableNames: ''!

!TransferDeposit class methodsFor: 'as yet unclassified' stamp: 'TF 5/31/2019 23:05:55'!
with: aTransfer
	^self new initializeWith: aTransfer .! !


!classDefinition: #TransferWithdraw category: #'Portfolio-Solucion'!
AccountTransaction subclass: #TransferWithdraw
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferWithdraw methodsFor: 'testing' stamp: 'TF 5/31/2019 23:07:48'!
transfer
	^transfer! !


!TransferWithdraw methodsFor: 'visitor' stamp: 'TF 6/3/2019 10:53:36'!
accept: aVisitor
	^aVisitor visitTransferWithdraw: self.! !


!TransferWithdraw methodsFor: 'balance' stamp: 'TF 6/2/2019 10:42:21'!
affectBalance: aBalance

	^aBalance - (self value). ! !


!TransferWithdraw methodsFor: 'value' stamp: 'TF 5/31/2019 23:12:51'!
value
	^transfer value.! !


!TransferWithdraw methodsFor: 'initialization' stamp: 'TF 5/31/2019 23:07:26'!
initializeWith: aTransfer
	transfer := aTransfer .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferWithdraw class' category: #'Portfolio-Solucion'!
TransferWithdraw class
	instanceVariableNames: ''!

!TransferWithdraw class methodsFor: 'as yet unclassified' stamp: 'TF 5/31/2019 23:07:38'!
with: aTransfer
	^self new initializeWith: aTransfer .! !


!classDefinition: #Withdraw category: #'Portfolio-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'visitor' stamp: 'TF 6/3/2019 10:53:48'!
accept: aVisitor
	^aVisitor visitWithdraw: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Report category: #'Portfolio-Solucion'!
Object subclass: #Report
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Report methodsFor: 'visitors' stamp: 'TF 6/3/2019 10:48:14'!
visitDeposit: aDeposit
	self subclassResponsibility.! !

!Report methodsFor: 'visitors' stamp: 'TF 6/3/2019 11:49:37'!
visitPortfolio: aPortfolio
	self subclassResponsibility .! !

!Report methodsFor: 'visitors' stamp: 'TF 6/3/2019 11:49:29'!
visitReceptiveAccount: aReceptiveAccount
	self subclassResponsibility .! !

!Report methodsFor: 'visitors' stamp: 'TF 6/3/2019 10:48:21'!
visitTransferDeposit: aTransferDeposit
	self subclassResponsibility.! !

!Report methodsFor: 'visitors' stamp: 'TF 6/3/2019 10:48:30'!
visitTransferWithdraw: aTransferWithdraw
	self subclassResponsibility.! !

!Report methodsFor: 'visitors' stamp: 'TF 6/3/2019 10:48:36'!
visitWithdraw: aWithdraw
	self subclassResponsibility.! !


!Report methodsFor: 'accessing' stamp: 'TF 6/2/2019 12:49:30'!
get
	self subclassResponsibility .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Report class' category: #'Portfolio-Solucion'!
Report class
	instanceVariableNames: ''!

!Report class methodsFor: 'as yet unclassified' stamp: 'TF 6/2/2019 11:02:02'!
from: anAccount 
	^self new initializeWith: anAccount .! !


!classDefinition: #AccountSummary category: #'Portfolio-Solucion'!
Report subclass: #AccountSummary
	instanceVariableNames: 'theAccount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummary methodsFor: 'accessing' stamp: 'TF 6/3/2019 10:58:37'!
get
	| report |
	
	report := OrderedCollection new.
	
	theAccount transactions do: [:aTransaction | report add: (aTransaction accept: self)].
	
	^report add: 'Balance = ', theAccount balance asString; yourself .! !


!AccountSummary methodsFor: 'visitors' stamp: 'TF 6/3/2019 10:57:51'!
visitDeposit: aDeposit
	^'Depósito por ', aDeposit value asString , '.'.! !

!AccountSummary methodsFor: 'visitors' stamp: 'TF 6/3/2019 10:58:16'!
visitTransferDeposit: aTransferDeposit
	^'Entrada por transferencia de ', aTransferDeposit value asString, '.'.! !

!AccountSummary methodsFor: 'visitors' stamp: 'TF 6/3/2019 10:58:27'!
visitTransferWithdraw: aTransferWithdraw
	^'Salida por transferencia de ', aTransferWithdraw value asString, '.'.! !

!AccountSummary methodsFor: 'visitors' stamp: 'TF 6/3/2019 10:58:03'!
visitWithdraw: aWithdraw
	^'Extracción por ', aWithdraw value asString, '.'.! !


!AccountSummary methodsFor: 'initialization' stamp: 'TF 6/2/2019 11:02:26'!
initializeWith: anAccount 
	theAccount := anAccount .! !


!classDefinition: #PortfolioStructure category: #'Portfolio-Solucion'!
Report subclass: #PortfolioStructure
	instanceVariableNames: 'theAccount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioStructure methodsFor: 'accessing' stamp: 'TF 6/3/2019 11:55:31'!
get
	^theAccount accept: self.! !


!PortfolioStructure methodsFor: 'visitors' stamp: 'TF 6/3/2019 11:59:42'!
visitPortfolio: aPortfolio
	| thisPortfolioReport |
	
	thisPortfolioReport := OrderedCollection new.
	
	aPortfolio accounts do: [:anAccount | thisPortfolioReport addAll: (anAccount accept: self)].
	
	thisPortfolioReport := thisPortfolioReport collect: [:aReportLine | '    ', aReportLine ].
	
	thisPortfolioReport addFirst: aPortfolio name.
	
	^thisPortfolioReport .! !

!PortfolioStructure methodsFor: 'visitors' stamp: 'TF 6/3/2019 11:51:05'!
visitReceptiveAccount: aReceptiveAccount
	^OrderedCollection with: aReceptiveAccount name.! !


!PortfolioStructure methodsFor: 'initialization' stamp: 'TF 6/3/2019 11:39:17'!
initializeWith: anAccount 
	theAccount := anAccount .! !


!classDefinition: #SpecialAccountSummary category: #'Portfolio-Solucion'!
Report subclass: #SpecialAccountSummary
	instanceVariableNames: 'theAccount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!SpecialAccountSummary methodsFor: 'accessing' stamp: 'TF 6/3/2019 12:44:56'!
get
	^theAccount accept: self.! !


!SpecialAccountSummary methodsFor: 'visitors' stamp: 'TF 6/3/2019 12:45:45'!
visitPortfolio: aPortfolio
	| thisPortfolioReport |
	
	thisPortfolioReport := OrderedCollection new.
	
	aPortfolio accounts do: [:anAccount | thisPortfolioReport addAll: (anAccount accept: self)].
	
	thisPortfolioReport := thisPortfolioReport collect: [:aReportLine | '    ', aReportLine ].
	
	thisPortfolioReport addFirst: aPortfolio name.
	
	^thisPortfolioReport .! !

!SpecialAccountSummary methodsFor: 'visitors' stamp: 'TF 6/3/2019 13:01:03'!
visitReceptiveAccount: aReceptiveAccount
	| accountSumaryReport thisAccountReport |
	
	accountSumaryReport := (AccountSummary from: aReceptiveAccount) get.
	
	thisAccountReport := accountSumaryReport collect: [:aReportLine | '    ', aReportLine ].
	
	thisAccountReport addFirst: aReceptiveAccount name.
	
	^thisAccountReport .! !


!SpecialAccountSummary methodsFor: 'initialization' stamp: 'TF 6/3/2019 12:37:11'!
initializeWith: anAccount 
	theAccount := anAccount.! !


!classDefinition: #TransferNet category: #'Portfolio-Solucion'!
Report subclass: #TransferNet
	instanceVariableNames: 'theAccount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNet methodsFor: 'accessing' stamp: 'TF 6/3/2019 10:55:19'!
get
	^theAccount transactions sum: [:aTransaction | aTransaction accept: self] ifEmpty: [0].
		! !


!TransferNet methodsFor: 'visitors' stamp: 'TF 6/3/2019 10:51:46'!
visitDeposit: aDeposit
	^0.! !

!TransferNet methodsFor: 'visitors' stamp: 'TF 6/3/2019 10:51:58'!
visitTransferDeposit: aTransferDeposit
	^aTransferDeposit value.! !

!TransferNet methodsFor: 'visitors' stamp: 'TF 6/3/2019 10:52:19'!
visitTransferWithdraw: aTransferWithdraw
	^aTransferWithdraw value negated .! !

!TransferNet methodsFor: 'visitors' stamp: 'TF 6/3/2019 10:52:32'!
visitWithdraw: aWithdraw
	^0 .! !


!TransferNet methodsFor: 'initialization' stamp: 'TF 6/2/2019 11:02:43'!
initializeWith: anAccountOrPortfolio 
	theAccount := anAccountOrPortfolio .! !


!classDefinition: #Transfer category: #'Portfolio-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'amount depositLeg withdrawLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'initialization' stamp: 'TF 5/31/2019 23:08:14'!
initialize
	amount := 0.
	depositLeg := TransferDeposit with: self.
	withdrawLeg := TransferWithdraw with: self.! !

!Transfer methodsFor: 'initialization' stamp: 'TF 5/31/2019 23:11:45'!
initializeWith: anAmount 
	self initialize.
	amount := anAmount .! !


!Transfer methodsFor: 'accessing' stamp: 'TF 5/31/2019 23:04:00'!
depositLeg
	^depositLeg! !

!Transfer methodsFor: 'accessing' stamp: 'TF 5/31/2019 23:01:04'!
value
	^amount ! !

!Transfer methodsFor: 'accessing' stamp: 'TF 5/31/2019 23:07:00'!
withdrawLeg
	
	^withdrawLeg! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: #'Portfolio-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'as yet unclassified' stamp: 'TF 6/2/2019 10:38:17'!
register: anAmount from: anAccount to: anotherAccount 
	| aTransfer |
	aTransfer := self with: anAmount .
	
	anAccount register: aTransfer withdrawLeg .
	anotherAccount register: aTransfer depositLeg .! !

!Transfer class methodsFor: 'as yet unclassified' stamp: 'TF 5/31/2019 23:11:14'!
with: anAmount 
	^self new initializeWith: anAmount .! !
