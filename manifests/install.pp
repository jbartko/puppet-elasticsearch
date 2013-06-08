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
    $elasticsearch::es_conf_dir_real,
    $elasticsearch::es_plugins_dir_real
  ]
  $app_dirs = [
    $elasticsearch::es_log_dir_real,
    $elasticsearch::es_data_dir_real,
    $elasticsearch::es_work_dir_real,
    $elasticsearch::es_pid_dir_real
  ]
  $url = "https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-${elasticsearch::es_version_real}.tar.gz"

  exec { 'download':
    cwd     => '/tmp',
    command => "/usr/bin/curl -O ${url}",
    creates => $tar_path,
    unless  => "/usr/bin/test -x /usr/local/elasticsearch/bin/elasticsearch && /usr/local/elasticsearch/bin/elasticsearch -v | /bin/grep -q '${elasticsearch::es_version_real}'",
  }

  user { $elasticsearch::es_base_real:
    ensure => present,
    system => true,
    shell  => '/sbin/nologin',
  }

  file { $sys_dirs:
    ensure => directory,
  }

  file { $app_dirs:
    ensure  => directory,
    owner   => $elasticsearch::es_base_real,
    group   => $elasticsearch::es_base_real
  }

  file { "${elasticsearch::es_dir_real}/data":
    ensure => link,
    target => $elasticsearch::es_data_dir_real,
  }

  file { "${elasticsearch::es_dir_real}/work":
    ensure => link,
    target => $elasticsearch::es_work_dir_real,
  }

  file { "${elasticsearch::es_dir_real}/logs":
    ensure => link,
    target => $elasticsearch::es_log_dir_real,
  }

  file { "${elasticsearch::es_dir_real}/config":
    ensure => link,
    target => $elasticsearch::es_conf_dir_real,
  }

  exec { 'unpack':
    command => "/bin/tar zxf ${tar_path} --overwrite --no-same-owner --no-same-permissions --strip-components=1 -C ${elasticsearch::es_dir_real}",
    unless  => "/usr/bin/test -x /usr/local/elasticsearch/bin/elasticsearch && /usr/local/elasticsearch/bin/elasticsearch -v | /bin/grep -q '${elasticsearch::es_version_real}'",
    require => [ Exec['download'], File[$sys_dirs], File["${elasticsearch::es_dir_real}/config"] ],
  }
}

# vim: set ts=2 sw=2 et ft=puppet:
