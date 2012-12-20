class java::default_jdk {
  include java::config
  if (!defined(Java::Jdk[$java::config::default_jdk])) {
    java::jdk {
      $java::config::default_jdk: ;
    }
  }
}
