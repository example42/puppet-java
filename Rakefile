require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-lint/tasks/puppet-lint'
PuppetLint.configuration.send("disable_80chars")
PuppetLint.configuration.send("disable_140chars")
PuppetLint.configuration.send('disable_class_parameter_defaults')
PuppetLint.configuration.relative = true
PuppetLint.configuration.ignore_paths = ["spec/**/*.pp", "pkg/**/*.pp"]
