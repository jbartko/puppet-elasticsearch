# == Class: elasticsearch::params
#
#
#
# === Parameters
#
# [*java_package*]
# [*es_version*]
# [*es_dir*]
# [*es_dir_log*]
# [*es_dir_run*]
# [*es_dir_work*]
# [*es_num_files*]
# [*es_memlock*]
# [*is_master*]
# [*is_data*]
# [*master_list*]
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
class elasticsearch::params {
  $es_dir         = '/usr/local/elasticsearch'
  $es_dir_conf    = '/etc/elasticsearch'
  $es_dir_data    = '/var/lib/elasticsearch'
  $es_dir_log     = '/var/log/elasticsearch'
  $es_dir_pid     = '/var/run/elasticsearch'
  $es_dir_plugins = "${es_dir}/plugins"
  $es_dir_work    = '/var/tmp/elasticsearch'
  $es_heap_size   = '512m'
  $es_memlock     = 'unlimited'
  $es_num_files   = '32768'
  $es_version     = '0.90.1'
  $is_data        = true
  $is_master      = true
  $java_package   = 'java-1.7.0-openjdk'
}

# vim: set ts=2 sw=2 et ft=puppet:
