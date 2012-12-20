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

  $default_jre = 'openjdk6'
  $default_jdk = $default_jre

  # JRE Package names
  $jre_oracle_java6 = $::operatingsystem ? {
    /(?i:Ubuntu|Debian|Mint)/ => 'sun-java6-jre',
    default                   => 'java-1.6.0-sun',
  }
  $jre_openjdk6 = $::operatingsystem ? {
    /(?i:Ubuntu|Debian|Mint)/ => 'openjdk-6-jre-headless',
    default                   => 'java-1.6.0-openjdk',
  }
  $jre_openjdk7 = $::operatingsystem ? {
    /(?i:Ubuntu|Debian|Mint)/ => 'openjdk-7-jre-headless',
    default                   => 'java-1.7.0-openjdk',
  }

  # JDK Package names
  $jdk_oracle_java6 = $::operatingsystem ? {
    /(?i:Ubuntu|Debian|Mint)/ => 'sun-java6-jdk',
    default                   => 'java-1.6.0-sun-devel',
  }
  $jdk_openjdk6 = $::operatingsystem ? {
    /(?i:Ubuntu|Debian|Mint)/ => 'openjdk-6-jdk',
    default                   => 'java-1.6.0-openjdk-devel',
  }
  $jdk_openjdk7 = $::operatingsystem ? {
    /(?i:Ubuntu|Debian|Mint)/ => 'openjdk-7-jdk',
    default                   => 'java-1.7.0-openjdk-devel',
  }

  # General Settings
  $my_class = ''
  $puppi = false
  $puppi_helper = 'standard'
  $debug = false

}
