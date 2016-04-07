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

  $jdk = false
  if $::operatingsystem == 'Debian' and versioncmp($::operatingsystemrelease, '8.0') >= 0 {
    $version = '7'
  } else {
    $version = '6'
  }
  $headless = true
  $java_home_base = $::operatingsystem ? {
    /(?i:SLES|OpenSuSE)/      => '/usr/lib/java',
    /(?i:Ubuntu|Debian|Mint)/ => '/usr/lib/jvm',
    /(?i:Solaris)/            => $::operatingsystemmajrelease ? {
      '10'                    => '/opt/csw/java',
      '11'                    => '/usr/java',
      '5'                     => '/usr/java',
    },
    default                   => '/usr/lib/jvm',
  }


  # Real package names are computed in java class
  $package = ''
  $package_jdk = ''

  # General Settings
  $my_class = ''
  $absent = false
  $puppi = false
  $puppi_helper = 'standard'
  $debug = false

}
