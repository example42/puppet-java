define java::jre(
  $absent = false
) {
  include java::config

  $bool_absent=any2bool($absent)

  case $name {
    'oracle-java6': { $jre_package = $java::config::jre_oracle_java6}
    'openjdk6':     { $jre_package = $java::config::jre_openjdk6}
    'openjdk7':     { $jre_package = $java::config::jre_openjdk7}
    default:        { fail("Unhandled JRE: ${name}") }
  }

  $manage_package = $bool_absent ? {
    true  => 'absent',
    false => 'present',
  }

  ### Managed resources
  package { $name:
    ensure => $manage_package,
    name   => $jre_package,
  }
}
