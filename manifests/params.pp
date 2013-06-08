# == Class: elasticsearch::params
#
#
#
# === Parameters
#
# TODO: redhatify parameters
#
# [*java_package*]
# [*es_base*]
# [*es_version*]
# [*es_dir*]
# [*es_log_dir*]
# [*es_run_dir*]
# [*es_work_dir*]
# [*es_num_files*]
# [*es_memlock*]
# [*alloc_aware*]
# [*datacenter*]
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
  $java_package   = 'java-1.7.0-openjdk'
  $es_base        = 'elasticsearch'
  $es_version     = '0.90.0'
  $es_dir         = "/usr/local/${es_base}"
  $es_conf_dir    = "/etc/${es_base}"
  $es_log_dir     = "/var/log/${es_base}"
  $es_data_dir    = "/var/lib/${es_base}"
  $es_work_dir    = "/var/tmp/${es_base}"
  $es_pid_dir     = "/var/run/${es_base}"
  $es_plugins_dir = "${es_dir}/plugins"
  $es_num_files   = '32000'
  $es_memlock     = 'unlimited'
  $es_heap_size   = '512m'
  $alloc_aware    = 'datacenter'
  $datacenter     = 'jck'
  $is_master      = true
  $is_data        = true
}

# vim: set ts=2 sw=2 et ft=puppet:
