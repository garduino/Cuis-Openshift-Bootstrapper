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
initializeBAK	"Bootstrapp the web server on the OpenShift internal ip and port"	"Log the stuff"	| ip port dir startedIp startedHost startedPort |	ip := (OSProcess thisOSProcess environment) at: #OPENSHIFT_INTERNAL_IP.	"ip := '127.0.0.1'."	port := (OSProcess thisOSProcess environment) at: #OPENSHIFT_INTERNAL_PORT.	"port := 8080."	"dir := (PipeableOSProcess command: 'pwd') output."		" Prueba Proxy "	"	HTTPSocket httpProxyServer: ((OSProcess thisOSProcess environment) at: #OPENSHIFT_INTERNAL_IP).	HTTPSocket httpProxyPort: ((OSProcess thisOSProcess environment) at: #OPENSHIFT_INTERNAL_PORT).	"	aLogger := G9Logger new.	aLogger logWithTimeStamp: 'Parameters: ip address: ',ip,' port: ', port asString, ' folder: '. dir.	aLogger logWithTimeStamp: 'Stopping running site ...'.	"SwazooIliad stop."	aLogger logWithTimeStamp: 'Starting site on ip: ', ip.	"SwazooIliad startOn: 8080."	"SwazooIliad startOn: port ip: ip."	"SwazooServer singleton sites do: [:each | each uriPattern do: [:oeach | startedIp := oeach ip. startedPort := oeach port. startedHost := oeach host. ]]."	aLogger logWithTimeStamp: 'Site started at ip: ',startedIp, ' port: ', startedPort asString, ' host: ', startedHost. 	"aLogger logWithTimeStamp: 'Currently exist ', SwazooServer singleton sites size asString, ' site started.'."	aLogger closeLogFile.	"SmalltalkImage current snapshot: false andQuit: true"! !

!OSBootStrapper methodsFor: 'as yet unclassified' stamp: 'gsa 1/31/2013 16:12'!
initializeBAK1
	super initialize.
	Smalltalk isHeadless ifTrue: [self startServices]
	! !

!OSBootStrapper methodsFor: 'as yet unclassified' stamp: 'GermanArduino 4/15/2012 16:13'!
initializeEnvironment		self environment:  (OSProcess thisOSProcess environment).! !

!OSBootStrapper methodsFor: 'as yet unclassified' stamp: 'GermanArduino 4/10/2012 23:24'!
initializeXXX	"Bootstrapp the web server on the OpenShift internal ip and port"	"Log the stuff"	| ip port  startedIp startedHost startedPort |		aLogger := G9Logger new.	aLogger logWithTimeStamp: (OSProcess thisOSProcess environment) asString.		ip := (OSProcess thisOSProcess environment) at: #OPENSHIFT_INTERNAL_IP.	port := (OSProcess thisOSProcess environment) at: #OPENSHIFT_INTERNAL_PORT.			" Prueba Proxy "	"	HTTPSocket httpProxyServer: ((OSProcess thisOSProcess environment) at: #OPENSHIFT_INTERNAL_IP).	HTTPSocket httpProxyPort: ((OSProcess thisOSProcess environment) at: #OPENSHIFT_INTERNAL_PORT).	"		aLogger logWithTimeStamp: 'Parameters: ip address: ',ip,' port: ', port asString.	aLogger logWithTimeStamp: 'Stopping running site ...'.		ZnServer stopDefault.		aLogger logWithTimeStamp: 'Starting site on ip: ', ip.		(ZnServer startDefaultOn: port) interface: ip.				"SwazooServer singleton sites do: [:each | each uriPattern do: [:oeach | startedIp := oeach ip. startedPort := oeach port. startedHost := oeach host. ]]."	aLogger logWithTimeStamp: 'Site started at ip: ',startedIp, ' port: ', startedPort asString, ' host: ', startedHost. 	"aLogger logWithTimeStamp: 'Currently exist ', SwazooServer singleton sites size asString, ' site started.'."	aLogger closeLogFile.	"SmalltalkImage current snapshot: false andQuit: true"! !

!OSBootStrapper methodsFor: 'as yet unclassified' stamp: 'GermanArduino 4/15/2012 16:15'!
osEnvironment	^OSProcess thisOSProcess environment.! !

!OSBootStrapper methodsFor: 'as yet unclassified' stamp: 'gsa 1/31/2013 16:12'!
register
	"Ask for start/stop to be sent to me on System startUp/shutDown"
	
	self class register: self! !

!OSBootStrapper methodsFor: 'as yet unclassified' stamp: 'GermanArduino 4/15/2012 20:58'!
startServices	| ip port ipByteArray startedIp startedHost startedPort osEnv |	"osEnv := self osEnvironment."	"Smalltalk garbageCollect."	osEnv := OSBootStrapperEnvironment singleton readOpenShiftEnvironment osEnvironment.	aLogger := G9Logger new.	aLogger logWithTimeStamp: 'OpenShift Environment: ',osEnv asString.	aLogger closeLogFile.	ip := osEnv				at: #OPENSHIFT_INTERNAL_IP				ifAbsent: [ip := '127.13.21.129'].	port := osEnv				at: #OPENSHIFT_INTERNAL_PORT				ifAbsent: [port := 8080].	"aLogger logWithTimeStamp: 'Parameters: ip address: ' , ip asString , ' port: ' , port asString."	"aLogger logWithTimeStamp: 'Stopping running site ...'."	ZnServer stopDefault.	"aLogger logWithTimeStamp: 'Starting site on ip: ' , ip asString."	ipByteArray := ((ip findTokens: '.')				collect: [:each | each asInteger]) asByteArray.	(ZnServer defaultOn: port) bindingAddress: ipByteArray;		 start.	"aLogger closeLogFile"! !

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
initializeosEnvironment  := OSProcess thisOSProcess environment.         ^self! !

!OSBootStrapperEnvironment methodsFor: 'as yet unclassified' stamp: 'GermanArduino 4/15/2012 18:14'!
osEnvironment^osEnvironment ! !

!OSBootStrapperEnvironment methodsFor: 'as yet unclassified' stamp: 'GermanArduino 4/15/2012 18:13'!
osEnvironment: aDictionary	osEnvironment := aDictionary ! !

!OSBootStrapperEnvironment methodsFor: 'as yet unclassified' stamp: 'GermanArduino 4/15/2012 20:43'!
readOpenShiftEnvironmentosEnvironment  := OSProcess thisOSProcess environment.         ^self! !

!OSBootStrapperEnvironment class methodsFor: 'as yet unclassified' stamp: 'gsa 1/31/2013 16:54'!
singleton
	UniqueInstance ifNil: [UniqueInstance := self basicNew initialize].
       ^UniqueInstance! !
OSBootStrapper initialize!
