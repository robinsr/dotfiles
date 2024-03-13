/**
 * Store user's OSX preferences in JSON/JS
 * Produce a set of `default write` commands to apply settings
 */


const mySettings = [
	{
		domain: "NSGlobalDomain",
		key: "NSAutomaticSpellingCorrectionEnabled",
		type: "-bool",
		current: "false",
		// Seems redundant for boolean
		values: [ true, false ]
	},
]


