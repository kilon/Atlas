as yet unclassified
e
	"send the message through socket"

	Ephestos sendMessage: pythonString.
	Transcript show: 'pythonString : ',pythonString ;cr.
	pythonString := referencedString 