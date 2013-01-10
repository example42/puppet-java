class java (
  $jdk                 = params_lookup( 'jdk' ),
  $version             = params_lookup( 'version' ),
  $my_class            = params_lookup( 'my_class' ),
  $absent              = params_lookup( 'absent' ),
  $puppi               = params_lookup( 'puppi' , 'global' ),
  $puppi_helper        = params_lookup( 'puppi_helper' , 'global' ),
  $debug               = params_lookup( 'debug' , 'global' ),
  $package             = params_lookup( 'package' ),
  $package_jdk         = params_lookup( 'package_jdk' )
  ) inherits java::params {

  $bool_absent=any2bool($absent)
  $bool_jdk=any2bool($jdk)
  $bool_debug=any2bool($debug)

  ### Definition of some variables used in the module
  $manage_package = $java::bool_absent ? {
    true  => 'absent',
    false => 'present',
  }
  $manage_file = $java::bool_absent ? {
    true    => 'absent',
    default => 'present',
  }

  $real_package = $package ? {
    ''  => $::operatingsystem ? {
      /(?i:Ubuntu|Debian|Mint)/ => "openjdk-${version}-jre",
      /(?i:SLES)/               => "java-1_${version}_0-ibm",
      /(?i:OpenSuSE)/           => "java-1_${version}_0-openjdk",
      default                   => "java-1.${version}.0-openjdk",
    },
    default => $package,
  }

  $real_package_jdk = $package_jdk ? {
    ''  => $::operatingsystem ? {
      /(?i:Ubuntu|Debian|Mint)/ => "openjdk-${version}-jdk",
      /(?i:SLES)/               => "java-1_${version}_0-ibm",
      /(?i:OpenSuSE)/           => "java-1_${version}_0-openjdk-devel",
      default                   => "java-1.${version}.0-openjdk-devel",
    },
    default => $package_jdk,
  }

  ### Managed resources
  package { 'java':
    ensure => $java::manage_package,
    name   => $java::real_package,
  }

  if $java::bool_jdk == true {
    package { 'java-jdk':
      ensure => $java::manage_package,
      name   => $java::real_package_jdk,
    }
  }

  ### Debugging, if enabled ( debug => true )
  if $java::bool_debug == true {
    file { 'debug_java':
      ensure  => $java::manage_file,
      path    => "${settings::vardir}/debug-java",
      mode    => '0640',
      owner   => 'root',
      group   => 'root',
      content => inline_template('<%= scope.to_hash.reject { |k,v| k.to_s =~ /(uptime.*|path|timestamp|free|.*password.*|.*psk.*|.*key)/ }.to_yaml %>'),
    }
  }

  ### Include custom class if $my_class is set
  if $java::my_class {
    include $java::my_class
  }

}
