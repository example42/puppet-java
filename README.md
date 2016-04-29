#java

[![Build Status](https://travis-ci.org/example42/puppet-java.png?branch=master)](https://travis-ci.org/example42/puppet-java)

####Table of Contents

1. [Overview](#overview)
1. [Compatibility](#compatibility)
1. [Setup](#setup)
1. [Usage](#usage)


##Overview

This module installs java (JDK + JRE) versions

##Compatibility
Puppet v3 (with and without the future parser) and Puppet v4 with Ruby versions
1.8.7, 1.9.3, 2.0.0 and 2.1.0 where supported by Puppet.

* Debian 6
* EL 6
* Solaris 10
* Solaris 11
* Ubuntu 14.04

##Setup

###Setup Requirements
* PuppetLabs [stdlib module](https://github.com/puppetlabs/puppetlabs-stdlib)
* Example42 [puppet module](https://github.com/example42/puppi)

##Usage

The main class is used only.

```puppet
class { 'java':
  jdk     => false, # default - whether to install the jdk or the jre only
  version => '6', # Java version to install
}
```

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

