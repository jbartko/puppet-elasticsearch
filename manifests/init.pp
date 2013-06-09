# == Class: elasticsearch
#
# The [elasticsearch](http://www.elasticsearch.org/) class installs and
# configures elasticsearch.
#
# === Parameters
#
# [*java_package*]
#   Java flavor.
#   Default: java-1.6.0-openjdk
#
# [*es_version*]
#   Version of elasticsearch.
#   Default: 0.20.1
#
# [*es_dir*]
#   elasticsearch home.
#
# [*es_dir_log*]
#   elasticsearch logs
#
# [*es_dir_run*]
#   elasticsearch system
#
# [*es_dir_work*]
#   elasticsearch work
#
# [*es_num_files*]
#   number of open files
#   Default: 32000
#
# [*es_memlock*]
#   Amount of memory available to allocate to java.
#   Default: unlimited
#
# [*alloc_aware*]
#   Cluster routing allocation awarenes configuration.
#
# [*attribute*]
#   C.r.a attributes.
#
# [*is_master*]
#   Master flag.
#
# [*is_data*]
#   Data flag.
#
# [*master_list*]
#   List of elasticsearch master nodes.
#
# === Variables
#
# None.
#
# === Examples
#
# TODO: get examples from puppet.cs1cloud.internal
#
# === Authors
#
# John Bartko <jbartko@txstate.edu>
#
# === Copyright
#
# Copyright 2013 John Bartko, for use by Texas State University-San Marcos
#

class elasticsearch(
  $unicast        = 'UNSET',
  $alloc_aware    = 'UNSET',
  $attribute      = 'UNSET',
  $es_dir         = 'UNSET',
  $es_dir_conf    = 'UNSET',
  $es_dir_data    = 'UNSET',
  $es_dir_log     = 'UNSET',
  $es_dir_pid     = 'UNSET',
  $es_dir_plugins = 'UNSET',
  $es_dir_run     = 'UNSET',
  $es_dir_work    = 'UNSET',
  $es_heap_size   = 'UNSET',
  $es_memlock     = 'UNSET',
  $es_num_files   = 'UNSET',
  $es_version     = 'UNSET',
  $is_data        = 'UNSET',
  $is_master      = 'UNSET',
  $java_package   = 'UNSET',
) {
  include elasticsearch::params

  $unicast_real = $unicast ? {
    'UNSET' => false,
    default => $unicast,
  }
  if($unicast_real != false) {
    validate_array($unicast_real)
  }

  $alloc_aware_real = $alloc_aware ? {
    'UNSET' => false,
    default => $alloc_aware,
  }

  $attribute_real = $attribute ? {
    'UNSET' => false,
    default => $attribute,
  }

  $java_package_real = $java_package ? {
    'UNSET' => $::elasticsearch::params::java_package,
    default => $java_package,
  }

  $es_version_real = $es_version ? {
    'UNSET' => $::elasticsearch::params::es_version,
    default => $es_version,
  }

  $es_dir_real = $es_dir ? {
    'UNSET' => $::elasticsearch::params::es_dir,
    default => $es_dir,
  }

  $es_dir_conf_real = $es_dir_conf ? {
    'UNSET' => $::elasticsearch::params::es_dir_conf,
    default => $es_dir_conf,
  }

  $es_dir_log_real = $es_dir_log ? {
    'UNSET' => $::elasticsearch::params::es_dir_log,
    default => $es_dir_log,
  }

  $es_dir_run_real = $es_dir_run ? {
    'UNSET' => $::elasticsearch::params::es_dir_run,
    default => $es_dir_run,
  }

  $es_dir_data_real = $es_dir_data ? {
    'UNSET' => $::elasticsearch::params::es_dir_data,
    default => $es_dir_data,
  }

  $es_dir_work_real = $es_dir_work ? {
    'UNSET' => $::elasticsearch::params::es_dir_work,
    default => $es_dir_work,
  }

  $es_dir_pid_real = $es_dir_pid ? {
    'UNSET' => $::elasticsearch::params::es_dir_pid,
    default => $es_dir_pid,
  }

  $es_dir_plugins_real = $es_dir_plugins ? {
    'UNSET' => $::elasticsearch::params::es_dir_plugins,
    default => $es_dir_plugins,
  }

  $es_num_files_real = $es_num_files ? {
    'UNSET' => $::elasticsearch::params::es_num_files,
    default => $es_num_files,
  }

  $es_memlock_real = $es_memlock ? {
    'UNSET' => $::elasticsearch::params::es_memlock,
    default => $es_memlock,
  }

  $es_heap_size_real = $es_heap_size ? {
    'UNSET'  => $::elasticsearch::params::es_heap_size,
    default => $es_heap_size,
  }

  $is_master_real = $is_master ? {
    'UNSET' => $::elasticsearch::params::is_master,
    default => $is_master,
  }

  $is_data_real = $is_data ? {
    'UNSET' => $::elasticsearch::params::is_data,
    default => $is_data,
  }

  class{'elasticsearch::install': } ->
  class{'elasticsearch::config': } ~>
  class{'elasticsearch::service': } ->
  Class['elasticsearch']
}

# vim: set ts=2 sw=2 et ft=puppet:
