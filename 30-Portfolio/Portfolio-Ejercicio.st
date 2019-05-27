!classDefinition: #PortfolioTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'TF 5/23/2019 20:53:07'!
test01PortfolioHasZeroBalanceWhenCreatedEmpty

	| portfolio |
	
	portfolio := Portfolio new.
	
	self assert: portfolio balance equals: 0. 
! !

!PortfolioTest methodsFor: 'tests' stamp: 'TF 5/23/2019 21:14:12'!
test02EmptyPortfolioDoesNotKnowTransactionsNotContainedInItself

	| portfolio deposit withdraw |
	
	portfolio := Portfolio new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (portfolio hasRegistered: deposit).
	self deny: (portfolio hasRegistered:withdraw).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'TF 5/23/2019 20:53:18'!
test03EmptyPortfolioDoesNotHaveTransactions

	| portfolio |
	
	portfolio := Portfolio new.
		
	self assert: portfolio transactions isEmpty .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'atr 5/26/2019 18:32:08'!
test04APortfolioBalanceEqualsTheSumOfItsElements

	| portfolio anotherPortfolio anAccount anotherAccount |
	
	anAccount := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	
	portfolio := Portfolio new.
	anotherPortfolio := Portfolio new.
	
	portfolio add:  anAccount.
	anotherPortfolio add: anotherAccount .
	portfolio add: anotherPortfolio.
	
	Deposit register: 100 on: anAccount.
	Withdraw register: 50 on: anAccount.
	
	Deposit register: 75 on:  anotherAccount .
	self assert: portfolio balance equals: (anAccount balance + anotherAccount balance ).! !

!PortfolioTest methodsFor: 'tests' stamp: 'TF 5/23/2019 21:25:12'!
test05APortfolioKnowsTheTransactionsOfTheAccountsItHasRegistered

	| portfolio anAccount aDeposit |
	
	anAccount := ReceptiveAccount new.
	
	portfolio := Portfolio new.
	portfolio add:  anAccount.

	aDeposit := Deposit for: 100.

	anAccount register: aDeposit .
	
	self assert: (portfolio hasRegistered: aDeposit) .! !

!PortfolioTest methodsFor: 'tests' stamp: 'TF 5/23/2019 21:26:45'!
test06APortfolioHasTheTransactionsOfTheAccountsItHasRegistered

	| portfolio anAccount aDeposit |
	
	anAccount := ReceptiveAccount new.
	
	portfolio := Portfolio new.
	portfolio add:  anAccount.

	aDeposit := Deposit for: 100.

	anAccount register: aDeposit .
	
	self assert: portfolio transactions equals: anAccount transactions .! !

!PortfolioTest methodsFor: 'tests' stamp: 'TF 5/23/2019 21:40:42'!
test07APortfolioCannotHaveElementTwice

	| portfolio anAccount |
	
	anAccount := ReceptiveAccount new.
	
	portfolio := Portfolio new.
	portfolio add:  anAccount.
	
	self should: [portfolio add: anAccount]  raise: Error withMessageText:  Portfolio CannotHaveElementRepeated.! !

!PortfolioTest methodsFor: 'tests' stamp: 'atr 5/26/2019 18:47:48'!
test08APortfolioCannotIndirectlyDownwardHaveElementTwice

	| portfolio anotherPortfolio anAccount |
	
	anAccount := ReceptiveAccount new.
	
	portfolio := Portfolio new.
	portfolio add:  anAccount.
	
	anotherPortfolio := Portfolio new.
	anotherPortfolio add: anAccount. 
	
	self should: [portfolio add: anotherPortfolio.]  raise: Error withMessageText:  Portfolio CannotHaveElementRepeated.! !

!PortfolioTest methodsFor: 'tests' stamp: 'atr 5/26/2019 19:09:29'!
test09APortfolioCannotIndirectlyUpwardsHaveElementTwice

	| portfolio anotherPortfolio anAccount |
	
	anAccount := ReceptiveAccount new.
	
	portfolio := Portfolio new.

	
	anotherPortfolio := Portfolio new.
	anotherPortfolio add: anAccount. 
	anotherPortfolio add: portfolio .
		
	self should: [portfolio add: anAccount .]  raise: Error withMessageText:  Portfolio CannotHaveElementRepeated.! !


!classDefinition: #ReceptiveAccountTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

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


!classDefinition: #AccountTransaction category: #'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'TF 5/23/2019 20:32:21'!
netValue 

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #Deposit category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'TF 5/23/2019 20:32:21'!
netValue

	^ value! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'TF 5/23/2019 20:32:21'!
netValue

	^ value negated.! !

!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Portfolio category: #'Portfolio-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'portfoliosThatManageMe managedPortfoliosAndAccounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'initialization' stamp: 'TF 5/27/2019 15:11:43'!
initialize
	managedPortfoliosAndAccounts := OrderedCollection new.
	portfoliosThatManageMe := OrderedCollection new.! !

!Portfolio methodsFor: 'initialization' stamp: 'TF 5/27/2019 15:22:53'!
transactions
	^managedPortfoliosAndAccounts 
		inject: OrderedCollection new 
		into: [:anOrderedCollection :aPortfolioOrAnAccount | anOrderedCollection addAll: aPortfolioOrAnAccount transactions ].! !


!Portfolio methodsFor: 'accessing' stamp: 'TF 5/27/2019 15:12:37'!
balance
	^ managedPortfoliosAndAccounts sum: [ :aPortfolioOrAccount | aPortfolioOrAccount balance.] ifEmpty: [0].! !

!Portfolio methodsFor: 'accessing' stamp: 'atr 5/26/2019 19:08:14'!
hasRegistered: aDeposit 
	^self transactions includes: aDeposit .
! !


!Portfolio methodsFor: 'operations' stamp: 'TF 5/27/2019 15:24:29'!
add: anAccountOrPortfolio

	self assertNoDuplicateInformationByAdding: anAccountOrPortfolio.
	
	managedPortfoliosAndAccounts add: anAccountOrPortfolio.
	anAccountOrPortfolio addPortfolioThatManages: self.! !

!Portfolio methodsFor: 'operations' stamp: 'TF 5/27/2019 15:24:40'!
addPortfolioThatManages: aPortfolio
	portfoliosThatManageMe add: aPortfolio .! !


!Portfolio methodsFor: 'operations - private' stamp: 'TF 5/27/2019 15:26:01'!
accountsOrPortfoliosManagedByAnyoneThatManagesMe
	| allAccountsOrPortfoliosManagedByAnyoneThatManagesMe |
	
	allAccountsOrPortfoliosManagedByAnyoneThatManagesMe := Set new .
	
	self portfoliosThatManageMe do: 
		[:aPortfolio | allAccountsOrPortfoliosManagedByAnyoneThatManagesMe addAll: aPortfolio managedAccountsOrPortfolios.].
	
	^allAccountsOrPortfoliosManagedByAnyoneThatManagesMe .
	
	! !

!Portfolio methodsFor: 'operations - private' stamp: 'TF 5/27/2019 15:19:05'!
managedAccountsOrPortfolios
	| allManagedAccountsOrPortfolios |
	
	allManagedAccountsOrPortfolios := Set with: self.
	
	managedPortfoliosAndAccounts do: 
		[:aPortfolioOrAccount | allManagedAccountsOrPortfolios addAll: aPortfolioOrAccount managedAccountsOrPortfolios.].
	
	^allManagedAccountsOrPortfolios .
	
	! !

!Portfolio methodsFor: 'operations - private' stamp: 'TF 5/27/2019 15:25:33'!
portfoliosThatManageMe
	| allPortfoliosThatManageMe |
	
	allPortfoliosThatManageMe := Set with: self .
	
	portfoliosThatManageMe do: 
		[:aPortfolio | allPortfoliosThatManageMe addAll: aPortfolio portfoliosThatManageMe.].
	
	^allPortfoliosThatManageMe .
	
	! !


!Portfolio methodsFor: 'assertions' stamp: 'TF 5/27/2019 15:23:55'!
assertNoDuplicateInformationByAdding: anAccountOrPortfolio

	^(self accountsOrPortfoliosManagedByAnyoneThatManagesMe 
		intersection: 
			(anAccountOrPortfolio managedAccountsOrPortfolios )) 
				ifNotEmpty: [^self error: self class CannotHaveElementRepeated .].
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'TF 5/23/2019 21:37:32'!
CannotHaveElementRepeated
	^'The element is already in the portfolio.'! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'TF 5/23/2019 20:37:11'!
balance

	^transactions sum: [ :aTransaction | aTransaction netValue ] ifEmpty: [ 0 ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 10/11/2018 16:53:54'!
hasRegistered: aTtransaction

	^ transactions includes: aTtransaction 
! !


!ReceptiveAccount methodsFor: 'portfolio operations - private' stamp: 'TF 5/27/2019 15:08:52'!
managedAccountsOrPortfolios
	^Set with: self.! !


!ReceptiveAccount methodsFor: 'portfolio operations' stamp: 'TF 5/27/2019 15:24:52'!
addPortfolioThatManages: aPortfolio! !
