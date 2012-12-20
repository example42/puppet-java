class java::config (
  # Defaults
  $default_jre         = params_lookup( 'default_jre' , 'global' ),
  $default_jdk         = params_lookup( 'default_jdk' , 'global' ),
  # JREs
  $jre_oracle_java6    = params_lookup( 'jre_oracle_java6' ),
  $jre_openjdk6        = params_lookup( 'jre_openjdk6' ),
  $jre_openjdk7        = params_lookup( 'jre_openjdk7' ),
  # JDKs
  $jdk_oracle_java6    = params_lookup( 'jdk_oracle_java6' ),
  $jdk_openjdk6        = params_lookup( 'jdk_openjdk6' ),
  $jdk_openjdk7        = params_lookup( 'jdk_openjdk7' ),
  # General
  $my_class            = params_lookup( 'my_class' ),
  $puppi               = params_lookup( 'puppi' , 'global' ),
  $puppi_helper        = params_lookup( 'puppi_helper' , 'global' ),
  $debug               = params_lookup( 'debug' , 'global' ),
  ) inherits java::params {

  $bool_debug=any2bool($debug)

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
