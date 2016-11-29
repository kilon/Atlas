baselines
baseline: spec
	<baseline>
	spec
		for: #pharo
		do:
			[
			spec
				preLoadDoIt: #preload:package:;
				postLoadDoIt: #postload:package:.
			spec package: 'Atlas'	. 
 ]	