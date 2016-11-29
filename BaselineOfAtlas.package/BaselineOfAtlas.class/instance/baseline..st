baselines
baseline: spec
	<baseline>
	spec
		for: #pharo
		do:
			[
			spec
				baseline: 'Atlas' with: [ spec repository: 'github://kilonr/Atlas' ];
				import: 'Atlas' provides: #('default').
				 
			spec package: 'Atlas'	with: [ spec requires: 'default' ]. 
 ]	