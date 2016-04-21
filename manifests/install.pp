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
# [*headless*]
#   Headless version (without X11 libraries). Default true.
#
# [*install*]
#   Installation method ('package' or 'source'). Default 'package'.
#
# [*install_source*]
#   Source URL (when install='source'). Not default.
#
# [*package*]
#   Name of the package to install (when install='package'). If not default it's
#   automatically defined for the operatingsystem
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
  $headless                = true,
  $install                 = 'package',
  $install_source          = '',
  $package                 = '',
  $package_source          = undef,
  $package_responsefile    = undef,
  $package_provider        = undef,
  $absent                  = false
) {

  $bool_headless=any2bool($headless)
  $bool_jdk=any2bool($jdk)
  $bool_absent=any2bool($absent)

  case $install {

    package: {

      $headless_suffix = $bool_headless ? {
        true    => '-headless',
        default => '',
      }
      $real_package = $package ? {
        ''                                                      => $bool_jdk ? {
          false                                                 => $::operatingsystem ? {
            /(?i:RedHat|Centos|Fedora|Scientific|Amazon|Linux)/ => "java-1.${version}.0-openjdk",
            /(?i:Ubuntu|Debian|Mint)/                           => "openjdk-${version}-jre${headless_suffix}",
            /(?i:SLES)/                                         => "java-1_${version}_0-ibm",
            /(?i:OpenSuSE)/                                     => "java-1_${version}_0-openjdk",
            /(?i:Solaris)/                                      => $::operatingsystemmajrelease ? {
              '10'                                              => "CSWjre${version}",
              '11'                                              => "jre-${version}",
              '5'                                               => undef,
            },
            default                   => fail("OperatingSystem ${::operatingsystem} not supported"),
          },
          true                                                  => $::operatingsystem ? {
            /(?i:RedHat|Centos|Fedora|Scientific|Amazon|Linux)/ => "java-1.${version}.0-openjdk-devel",
            /(?i:Ubuntu|Debian|Mint)/                           => "openjdk-${version}-jdk",
            /(?i:SLES)/                                         => "java-1_${version}_0-ibm",
            /(?i:OpenSuSE)/                                     => "java-1_${version}_0-openjdk-devel",
            /(?i:Solaris)/                                      => $::operatingsystemmajrelease ? {
              '10'                                              => "CSWjdk${version}",
              '11'                                              => "jdk-${version}",
              '5'                                               => "jdk",
            },
            default                   => fail("OperatingSystem ${::operatingsystem} not supported"),
          }
        },
        default => $package,
      }

      $manage_package = $bool_absent ? {
        true  => 'absent',
        false => 'present',
      }

      package { $real_package:
        ensure       => $manage_package,
        source       => $package_source,
        responsefile => $package_responsefile,
        provider     => $package_provider,
      }

    }

    source: {
      if (!$install_source) {
        fail('Required arguement: install_source')
      }
      $created_file = url_parse($install_source,'filename')
      $created_dir = regsubst($created_file, '^(.*)\.bin$', '\1')

      puppi::netinstall { "netinstall_java_${name}":
        url                => $install_source,
        destination_dir    => $java::java_home_base,
        work_dir           => $java::java_home_base,
        preextract_command => "chmod +x ${java::java_home_base}/${created_file}",
        extract_command    => "${java::java_home_base}/${created_file}",
        extracted_dir      => $created_dir,
      }

      file { "java_${name}_link":
        ensure  => link ,
        path    => "${java::java_home_base}/${name}" ,
        target  => $created_dir,
        require => Puppi::Netinstall["netinstall_java_${name}"],
      }

    }

    default: { }

  }
}
