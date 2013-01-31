'From Cuis 4.1 of 12 December 2012 [latest update: #1572] on 31 January 2013 at 5:00:15 pm'!
'Description Please enter a description for this package '!
!classDefinition: #OSBootStrapper category: #'Openshift-Bootstrapper'!
Object subclass: #OSBootStrapper
	instanceVariableNames: 'aLogger'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Openshift-Bootstrapper'!
!classDefinition: 'OSBootStrapper class' category: #'Openshift-Bootstrapper'!
OSBootStrapper class
	instanceVariableNames: ''!

!classDefinition: #OSBootStrapperEnvironment category: #'Openshift-Bootstrapper'!
Object subclass: #OSBootStrapperEnvironment
	instanceVariableNames: 'osEnvironment'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Openshift-Bootstrapper'!
!classDefinition: 'OSBootStrapperEnvironment class' category: #'Openshift-Bootstrapper'!
OSBootStrapperEnvironment class
	instanceVariableNames: 'UniqueInstance'!


!OSBootStrapper commentStamp: 'gsa 1/31/2013 16:11' prior: 0!
Some snippets:

(Smalltalk at: #ConfigurationOfIliad) project latestVersion load.

SwazooIliad startOn: 8080.
IliadConsole fullView.  IliadConsole 

Gofer new
	squeaksource: 'MetacelloRepository';
	package: 'ConfigurationOfOSProcess';
	load.
  (Smalltalk at: #ConfigurationOfOSProcess) project bleedingEdge load.

Gofer new
	squeaksource: 'CommandShell';
	package: 'CommandShell-Piping';
	load. 
	
OSProcess thisOSProcess environment.

(PipeableOSProcess command: 'pwd') output.

(PipeableOSProcess command: '$OPENSHIFT_INTERNAL_IP') output.

ILSite defaultIp.

SwazooIliad stop.
SwazooIliad startOn: 8080.

OSBootStrapper initialize.
OSBootStrapper new register.
	
(OSProcess thisOSProcess environment) at: #OPENSHIFT_INTERNAL_IP.

SwazooServer singleton sites do: [:each | each uriPattern do: [:oeach | Transcript show: oeach ip, oeach port asString, oeach host; cr. ]].
SwazooServer singleton sites size.

Para resetear valores del ILsite default:
ILSite default host: '*' ip: '*' port: 8080.

Modificaciones en Iliad:

ILSite class 
defaultIp
	"^'*'"
	^(OSProcess thisOSProcess environment) at: #OPENSHIFT_INTERNAL_IP.

SwazooIliad class
startOn: aPort
	" las dos siguiente son las originales"
	"ILSite default port: aPort.
	SwazooServer startSite: ILSite defaultName."
	" Esta fue una prueba"
	"SwazooServer startSite: (ILSite newDefaultOn: 8080)."
	(ILSite default port: aPort) host: '*' ip: ILSite defaultIp port: aPort.
	SwazooServer startSite: ILSite defaultName.
	
		

!

!OSBootStrapper methodsFor: 'as yet unclassified' stamp: 'GermanArduino 4/10/2012 20:53'!
initializeBAK

!OSBootStrapper methodsFor: 'as yet unclassified' stamp: 'gsa 1/31/2013 16:12'!
initializeBAK1
	super initialize.
	Smalltalk isHeadless ifTrue: [self startServices]
	! !

!OSBootStrapper methodsFor: 'as yet unclassified' stamp: 'GermanArduino 4/15/2012 16:13'!
initializeEnvironment

!OSBootStrapper methodsFor: 'as yet unclassified' stamp: 'GermanArduino 4/10/2012 23:24'!
initializeXXX

!OSBootStrapper methodsFor: 'as yet unclassified' stamp: 'GermanArduino 4/15/2012 16:15'!
osEnvironment

!OSBootStrapper methodsFor: 'as yet unclassified' stamp: 'gsa 1/31/2013 16:12'!
register
	"Ask for start/stop to be sent to me on System startUp/shutDown"
	
	self class register: self! !

!OSBootStrapper methodsFor: 'as yet unclassified' stamp: 'GermanArduino 4/15/2012 20:58'!
startServices

!OSBootStrapper class methodsFor: 'as yet unclassified' stamp: 'gsa 1/31/2013 16:12'!
initialize
	Smalltalk addToStartUpList: self.
	"Smalltalk addToShutDownList: self"! !

!OSBootStrapper class methodsFor: 'as yet unclassified' stamp: 'gsa 1/31/2013 16:12'!
startUp
	"self halt."
	"OSBootStrapper new."	
	"^self new initialize."
"^self new startServices."
		^self basicNew initialize startServices.


		! !

!OSBootStrapperEnvironment methodsFor: 'as yet unclassified' stamp: 'GermanArduino 4/15/2012 18:12'!
initialize

!OSBootStrapperEnvironment methodsFor: 'as yet unclassified' stamp: 'GermanArduino 4/15/2012 18:14'!
osEnvironment

!OSBootStrapperEnvironment methodsFor: 'as yet unclassified' stamp: 'GermanArduino 4/15/2012 18:13'!
osEnvironment: aDictionary

!OSBootStrapperEnvironment methodsFor: 'as yet unclassified' stamp: 'GermanArduino 4/15/2012 20:43'!
readOpenShiftEnvironment

!OSBootStrapperEnvironment class methodsFor: 'as yet unclassified' stamp: 'gsa 1/31/2013 16:54'!
singleton
	UniqueInstance ifNil: [UniqueInstance := self basicNew initialize].
       ^UniqueInstance! !
OSBootStrapper initialize!