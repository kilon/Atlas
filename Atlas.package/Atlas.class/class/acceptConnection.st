as yet unclassified
acceptConnection
	|stream errString |
stream := SocketStream openConnectionToHostNamed: '127.0.0.1'  port: 4000 .
errString := ''.
[errString := stream nextLineLf.
Transcript show: 'received : ', errString. self error: errString.] fork.

stream close.