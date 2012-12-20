define java::jdk(
  $absent = false
) {
  include java::config

  $bool_absent=any2bool($absent)

  case $name {
    'oracle-java6': { $jdk_package = $java::config::jdk_oracle_java6}
    'openjdk6':     { $jdk_package = $java::config::jdk_openjdk6}
    'openjdk7':     { $jdk_package = $java::config::jdk_openjdk7}
    default:        { fail("Unhandled JDK: ${name}") }
  }

  $manage_package = $java::bool_absent ? {
    true  => 'absent',
    false => 'present',
  }

  ### Managed resources
  package { $name:
    ensure => $manage_package,
    name   => $jdk_package,
  }
}
