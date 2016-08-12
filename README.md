# Deprecation notice

This module was designed for Puppet versions 2 and 3. It should work also on Puppet 4 but doesn't use any of its features.

The current Puppet 3 compatible codebase is no longer actively maintained by example42.

Still, Pull Requests that fix bugs or introduce backwards compatible features will be accepted.


#java

[![Build Status](https://travis-ci.org/example42/puppet-java.png?branch=master)](https://travis-ci.org/example42/puppet-java)

####Table of Contents

1. [Overview](#overview)
2. [Setup](#setup)
3. [Usage](#usage)


##Overview

This module installs java (JDK + JRE) versions

##Setup

###Setup Requirements
* PuppetLabs [stdlib module](https://github.com/puppetlabs/puppetlabs-stdlib)
* Example42 [puppet module](https://github.com/example42/puppi)

##Usage

The main class is used only.

        class { 'java':
          jdk     => false, # default - whether to install the jdk or the jre only
          version => '6', # Java version to install
        }

##Development

Pull requests (PR) and bug reports via GitHub are welcomed.

When submitting PR please follow these quidelines:
- Provide puppet-lint compliant code
- If possible provide rspec tests
- Follow the module style and stdmod naming standards

When submitting bug report please include or link:
- The Puppet code that triggers the error
- The output of facter on the system where you try it
- All the relevant error logs
- Any other information useful to undestand the context

