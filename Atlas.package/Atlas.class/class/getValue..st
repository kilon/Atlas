as yet unclassified
getValue: aString
	"similar to sendMessage but this method also return the python value "

|stream errString retValue |
stream := SocketStream openConnectionToHostNamed: '127.0.0.1'  port: 4000 .
stream sendCommand: 'RetValue: ',aString.
errString := stream nextLineLf .
[errString matchesRegex: '.*end of error.*'] whileFalse:[
Transcript show: 'iterating with error:',errString ;cr.
(errString matchesRegex:  '.*no error.*') ifFalse: [  
	(errString matchesRegex: '.*end of error.*') ifFalse:[
		(errString matchesRegex: '') ifFalse: [
			(errString matchesRegex: 'RetValue\:.*') ifTrue: 
			
				[Transcript show: ' I am getting error:' , errString ;cr.
				(errString regex: '[^(RetValue:)].*'  matchesDo: 
					[ :word|  Transcript show: 'Returned' , word;cr. retValue := word]) .
				
				^ retValue] ifFalse: [
self error: errString .]]]].errString:=stream nextLineLf ].

stream close.

	