# = Define java::install
#
# Installs Java using the system or a custom package
#
# [*jdk*]
#   Boolean to define if to install a jdk (true) or a jre (false)
#   Default: false
#
# [*version*]
#   Java version to install. Default 7.
#
# [*package*]
#   Name of the package to install. If not default it's automatically
#   defined for the operatingsystem
#   Default: ''
#
# [*package_source*]
#   Source from where to retrieve the defined package. Use a url.
#   Default: undef
#
# [*package_responsefile*]
#   Responsefile to use for the defined package.
#   Default: undef
#
# [*package_provider*]
#   Provider to use to install the package.
#   Default: undef
#
# [*absent*]
#   Set to true if you want to remove a previously installed package.
#   Default: false
#
define java::install (
  $jdk                     = false,
  $version                 = '7',
  $package                 = '',
  $package_source          = undef,
  $package_responsefile    = undef,
  $package_provider        = undef,
  $absent                  = false
) {

  $bool_jdk=any2bool($jdk)
  $bool_absent=any2bool($absent)


  $real_package = $package ? {
    ''  => $bool_jdk ? { 
      false => $::operatingsystem ? {
        /(?i:RedHat|Centos|Fedora|Scientific|Amazon|Linux)/ => "java-1.${version}.0-openjdk",
        /(?i:Ubuntu|Debian|Mint)/                           => "openjdk-${version}-jre",
        /(?i:SLES)/                                         => "java-1_${version}_0-ibm",
        /(?i:OpenSuSE)/                                     => "java-1_${version}_0-openjdk",
        /(?i:Solaris)/                                      => "runtime/java/jre-${version}",
        default                   => fail("OperatingSystem ${::operatingsystem} not supported"),
      },
      true => $::operatingsystem ? {
        /(?i:RedHat|Centos|Fedora|Scientific|Amazon|Linux)/ => "java-1.${version}.0-openjdk-devel",
        /(?i:Ubuntu|Debian|Mint)/                           => "openjdk-${version}-jdk",
        /(?i:SLES)/                                         => "java-1_${version}_0-ibm",
        /(?i:OpenSuSE)/                                     => "java-1_${version}_0-openjdk-devel",
        /(?i:Solaris)/                                      => "developer/java/jdk-${version}",
        default                   => fail("OperatingSystem ${::operatingsystem} not supported"),
      },
    default => $package,
    }
  }

  $manage_package = $bool_absent ? {
    true  => 'absent',
    false => 'present',
  }

  package { $real_package:
    ensure          => $manage_package,
    source          => $package_source,
    responsefile    => $package_responsefile,
    provider        => $package_provider,
  }

}
