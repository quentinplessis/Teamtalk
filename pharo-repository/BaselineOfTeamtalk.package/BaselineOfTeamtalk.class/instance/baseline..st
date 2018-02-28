baselines
baseline: spec
	<baseline>
	spec
		for: #common
		do: [ 
			spec
				project: 'VerStix'
					with: [ 
							spec
								className: 'ConfigurationOfVerStix';
								versionString: #stable;
								repository: 'http://smalltalkhub.com/mc/MasashiUmezawa/VerStix/main' ].
			spec
				package: 'TT-Core' with: [ spec requires: #('VerStix') ];
				package: 'TT-Samples' with: [ spec requires: #('TT-Core') ].]