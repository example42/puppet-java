class java::default_jre {
  include java::config
  if (!defined(Java::Jre[$java::config::default_jre])) {
    java::jre {
      $java::config::default_jre: ;
    }
  }
}
