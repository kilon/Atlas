as yet unclassified
sendMessage: aString
|stream errString  |
stream := SocketStream openConnectionToHostNamed: '127.0.0.1'  port: 4000 .
stream sendCommand: aString.
errString := stream nextLineLf .
[errString matchesRegex: '.*end of error.*'] whileFalse:[

(errString matchesRegex:  '.*no error.*') ifFalse: [  
	(errString matchesRegex: '.*end of error.*') ifFalse:[
		(errString matchesRegex: '') ifFalse: [   
self error: errString .]]].errString:= stream nextLineLf ].

stream close.
