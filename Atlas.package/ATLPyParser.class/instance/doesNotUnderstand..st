as yet unclassified
doesNotUnderstand: aMessage

|messageRegex dictindexRegex 
valueRegex fullRegex parts message
methodcallRegex accessObjectRegex unaryRegex|


message := aMessage asString.

messageRegex :='\w+\:'.
unaryRegex := '\w+'.
accessObjectRegex := 'nil'.
dictindexRegex := $' asString ,'\s*\[\s*"*\s*\w+\s*"*\s*\]\s*', $' asString.
valueRegex := '',$' asString ,'\s*=.+', $' asString,''.
methodcallRegex := '',$' asString ,'\s*\(.*\)\s*', $' asString,''.

fullRegex := '((',messageRegex,')|(',dictindexRegex,')|(',valueRegex,')|(',methodcallRegex,')|(',accessObjectRegex,')|(',unaryRegex ,'))'.

parts := message allRegexMatches: fullRegex.

parts do:[:part||index|
	
	index := parts indexOf: part.
	
	(index  < parts size) ifTrue: [  
	
	self parseDictIndexPart: part fromCollection: parts .	
     self parseValuePart: part fromCollection: parts .
	self parserMethodCallPart: part fromCollections: parts.
	
	]].
((parts size) = 1) ifTrue: [|part| part:= (parts at: 1) asString. (part matchesRegex: unaryRegex) ifTrue:[ 

		(pythonString = '') ifTrue: [ pythonString := part]
		                            ifFalse: [ pythonString := pythonString,'.',part ]]].

Transcript show: 'PythonString :' ,pythonString ;cr.
badMessage :=  aMessage.


