as yet unclassified
parserMethodCallPart: part fromCollections: parts 
	
| messageRegex index methodcallRegex |

	index := parts indexOf: part.
	messageRegex :='\w+\:'.
	
methodcallRegex := '',$' asString ,'\s*\(.*\)\s*', $' asString,''.
	(part matchesRegex: messageRegex) ifTrue:[ ((parts at: (index + 1)) matchesRegex: methodcallRegex ) ifTrue: [|newpart methodcallString| 
			methodcallString := (parts at: (index + 1)).
			methodcallString := methodcallString  copyWithRegex: (($' asString),'+')  matchesReplacedWith:''. 
			newpart := part copyWithRegex: '\:' matchesReplacedWith:('' ,methodcallString ) . 
			"parts at: index put: newpart ".  PythonString = '' ifFalse:[PythonString := PythonString ,'.'] . PythonString := PythonString ,newpart.]].