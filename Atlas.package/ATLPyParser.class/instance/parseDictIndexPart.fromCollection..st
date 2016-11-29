as yet unclassified
parseDictIndexPart: part fromCollection: parts
	
	| messageRegex index dictindexRegex |
	index := parts indexOf: part.
	messageRegex :='\w+\:'.
	dictindexRegex := $' asString ,'\s*\[\s*"*\s*\w+\s*"*\s*\]\s*', $' asString.
	
	(part matchesRegex: messageRegex) ifTrue:[ ((parts at: (index + 1)) matchesRegex: dictindexRegex  ) ifTrue: [|newpart dictIndexString| 
			dictIndexString := (parts at: (index + 1)).
			dictIndexString := dictIndexString copyWithRegex: (($' asString),'+')  matchesReplacedWith:''. 
			newpart := part copyWithRegex: '\:' matchesReplacedWith:('' ,dictIndexString,'' ) . 
			"parts at: index put: newpart" .  pythonString = '' ifFalse:[pythonString := pythonString ,'.'] .pythonString := pythonString ,newpart]].