as yet unclassified
parseValuePart: part fromCollection: parts 
| messageRegex index valueRegex |

index := parts indexOf: part.
messageRegex :='\w+\:'.
valueRegex := '',$' asString ,'\s*=.+', $' asString,''.

	(part matchesRegex: messageRegex) ifTrue:[ ((parts at: (index + 1)) matchesRegex: valueRegex  ) ifTrue: [|newpart valueString| 
			valueString := (parts at: (index + 1)).
			valueString := valueString copyWithRegex: (($' asString),'+')  matchesReplacedWith:''. 
			newpart := part copyWithRegex: '\:' matchesReplacedWith:('' ,valueString ) . 
			"parts at: index put: newpart ".  PythonString = '' ifFalse:[PythonString := PythonString ,'.'] .PythonString := PythonString ,newpart.]].