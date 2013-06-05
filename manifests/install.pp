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
# [*tmp_dir*]
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
  $tar = "elasticsearch-${elasticsearch::es_version}.tar.gz"
  $tar_path = "/tmp/${tar}"
  $tmp_dir = "/tmp/elasticsearch-${elasticsearch::es_version}"
  $all_dirs = [ $elasticsearch::es_dir, $elasticsearch::es_conf_dir ]
  $own_dirs = [ $elasticsearch::es_log_dir, $elasticsearch::es_data_dir, $elasticsearch::es_work_dir, $elasticsearch::es_pid_dir, $elasticsearch::es_plugins_dir ]
  $url = "https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-${elasticsearch::es_version}.tar.gz"

  exec { 'download':
    cwd     => '/tmp',
    command => "/usr/bin/curl -O ${url}",
    creates => $tar_path,
    unless  => "/usr/bin/test -x /usr/local/elasticsearch/bin/elasticsearch && /usr/local/elasticsearch/bin/elasticsearch -v | /bin/grep -q '${elasticsearch::es_version}'",
  }

  user { $elasticsearch::es_base:
    ensure => present,
    system => true,
    shell  => '/sbin/nologin',
  }

  file { $all_dirs:
    ensure => directory,
  }

  file { $own_dirs:
    ensure  => directory,
    owner   => $elasticsearch::es_base,
    group   => $elasticsearch::es_base,
  }

  file { "${elasticsearch::es_dir}/data":
    ensure => link,
    target => $elasticsearch::es_data_dir,
  }

  file { "${elasticsearch::es_dir}/work":
    ensure => link,
    target => $elasticsearch::es_work_dir,
  }

  file { "${elasticsearch::es_dir}/logs":
    ensure => link,
    target => $elasticsearch::es_log_dir,
  }

  file { "${elasticsearch::es_dir}/config":
    ensure => link,
    target => $elasticsearch::es_conf_dir,
  }

  exec { 'unpack':
    command => "/bin/tar zxf ${tar_path} --overwrite --no-same-owner --no-same-permissions --strip-components=1 -C ${elasticsearch::es_dir}",
    unless  => "/usr/bin/test -x /usr/local/elasticsearch/bin/elasticsearch && /usr/local/elasticsearch/bin/elasticsearch -v | /bin/grep -q '${elasticsearch::es_version}'",
    require => [ Exec['download'], File[$all_dirs], File["${elasticsearch::es_dir}/config"] ],
  }
}

# vim: set ts=2 sw=2 et ft=puppet:
