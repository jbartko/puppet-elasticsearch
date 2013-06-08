# == Class: elasticsearch::config
#
#
#
# === Parameters
#
# === Variables
#
# === Examples
#
# === Authors
#
# John Bartko <jbartko@txstate.edu>
#
# === Copyright
#
# Copyright 2013 John Bartko, for use by Texas State University-San Marcos
#
class elasticsearch::config {
  file { "${elasticsearch::es_dir_real}/config/elasticsearch.yml":
    ensure  => file,
    content => template('elasticsearch/elasticsearch.yml.erb'),
  }

  file { "/etc/sysconfig/${elasticsearch::es_base_real}":
    ensure  => file,
    content => template('elasticsearch/sysconfig.erb'),
  }

  file { "/etc/init.d/${elasticsearch::es_base_real}":
    ensure  => file,
    mode    => '0755',
    content => template('elasticsearch/init.erb'),
  }

  file { "/etc/security/limits.d/${elasticsearch::es_base_real}.conf":
    ensure  => file,
    content => template('elasticsearch/limits.conf.erb'),
  }

  exec { 'Install bigdesk plugin':
    command  => "${elasticsearch::es_dir_real}/bin/plugin -install lukas-vlcek/bigdesk",
    creates  => "${elasticsearch::es_dir_real}/plugins/bigdesk",
  }
}

# vim: set ts=2 sw=2 et ft=puppet:
