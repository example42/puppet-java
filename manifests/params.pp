# Class: java::params
#
# This class defines default parameters used by the main module class java
# Operating Systems differences in names and paths are addressed here
#
# == Variables
#
# Refer to java class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
class java::params {
  $package = $::operatingsystem ? {
    /(?i:Ubuntu|Debian|Mint)/ => 'openjdk-6-jre',
    default                   => 'java-1.6.0-openjdk',
  }

  $package_jdk = $::operatingsystem ? {
    /(?i:Ubuntu|Debian|Mint)/ => 'openjdk-6-jdk',
    default                   => 'java-1.6.0-openjdk-devel',
  }

  # General Settings
  $my_class = ''
  $absent = false
  $puppi = false
  $puppi_helper = 'standard'
  $debug = false

}
