# == Class: elasticsearch::install
#
#
#
# === Parameters
#
# === Variables
#
# [*tar*]
# [*tar_path*]
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
class elasticsearch::install {
  $tar = "elasticsearch-${elasticsearch::es_version_real}.tar.gz"
  $tar_path = "/tmp/${tar}"
  $sys_dirs = [
    $elasticsearch::es_dir_real,
    $elasticsearch::es_dir_conf_real,
    $elasticsearch::es_dir_plugins_real
  ]
  $app_dirs = [
    $elasticsearch::es_dir_log_real,
    $elasticsearch::es_dir_data_real,
    $elasticsearch::es_dir_work_real,
    $elasticsearch::es_dir_pid_real
  ]
  $url = "https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-${elasticsearch::es_version_real}.tar.gz"

  exec { 'download':
    cwd     => '/tmp',
    command => "/usr/bin/curl -O ${url}",
    creates => $tar_path,
    unless  => "/usr/bin/test -x /usr/local/elasticsearch/bin/elasticsearch && /usr/local/elasticsearch/bin/elasticsearch -v | /bin/grep -q '${elasticsearch::es_version_real}'",
  }

  user { 'elasticsearch':
    ensure => present,
    system => true,
    shell  => '/sbin/nologin',
  }

  file { $sys_dirs:
    ensure => directory,
  }

  file { $app_dirs:
    ensure  => directory,
    owner   => 'elasticsearch',
    group   => 'elasticsearch',
  }

  file { "${elasticsearch::es_dir_real}/data":
    ensure => link,
    target => $elasticsearch::es_dir_data_real,
  }

  file { "${elasticsearch::es_dir_real}/work":
    ensure => link,
    target => $elasticsearch::es_dir_work_real,
  }

  file { "${elasticsearch::es_dir_real}/logs":
    ensure => link,
    target => $elasticsearch::es_dir_log_real,
  }

  file { "${elasticsearch::es_dir_real}/config":
    ensure => link,
    target => $elasticsearch::es_dir_conf_real,
  }

  exec { 'unpack':
    command => "/bin/tar zxf ${tar_path} --overwrite --no-same-owner --no-same-permissions --strip-components=1 -C ${elasticsearch::es_dir_real}",
    unless  => "/usr/bin/test -x /usr/local/elasticsearch/bin/elasticsearch && /usr/local/elasticsearch/bin/elasticsearch -v | /bin/grep -q '${elasticsearch::es_version_real}'",
    require => [ Exec['download'], File[$sys_dirs], File["${elasticsearch::es_dir_real}/config"] ],
  }

  file { '/etc/sysconfig/elasticsearch':
    ensure  => file,
    content => template('elasticsearch/sysconfig.erb'),
  }

  file { '/etc/init.d/elasticsearch':
    ensure  => file,
    mode    => '0755',
    content => template('elasticsearch/init.erb'),
  }

  file { '/etc/security/limits.d/elasticsearch.conf':
    ensure  => file,
    content => template('elasticsearch/limits.conf.erb'),
  }
}

# vim: set ts=2 sw=2 et ft=puppet:
