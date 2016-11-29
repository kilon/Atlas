as yet unclassified
er
|stringToSend|
	"comment stating purpose of message"
	Transcript show: 'pythonString : ',PythonString ;cr.
	Transcript show: '-------------END OF MESSAGE-------------';cr.
	stringToSend := PythonString .
	self PythonString:''.
	^ Ephestos getValue: stringToSend .


