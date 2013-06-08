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
# [*es_base*]
#   The basename - used for user and directory creation.
#   Default: elasticsearch
#
# [*es_version*]
#   Version of elasticsearch.
#   Default: 0.20.1
#
# [*es_dir*]
#   elasticsearch home.
#
# [*es_log_dir*]
#   elasticsearch logs
#
# [*es_run_dir*]
#   elasticsearch system
#
# [*es_work_dir*]
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
# [*datacenter*]
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
  $java_package   = 'UNSET',
  $es_base        = 'UNSET',
  $es_version     = 'UNSET',
  $es_dir         = 'UNSET',
  $es_conf_dir    = 'UNSET',
  $es_log_dir     = 'UNSET',
  $es_run_dir     = 'UNSET',
  $es_data_dir    = 'UNSET',
  $es_work_dir    = 'UNSET',
  $es_pid_dir     = 'UNSET',
  $es_plugins_dir = 'UNSET',
  $es_num_files   = 'UNSET',
  $es_memlock     = 'UNSET',
  $es_heap_size   = 'UNSET',
  $datacenter     = 'UNSET',
  $is_master      = 'UNSET',
  $is_data        = 'UNSET',
) {
  include elasticsearch::params

  # TODO require puppetlabs-stdlib
  $unicast_real = $unicast ? {
    'UNSET' => false,
    default => $unicast,
  }
  if($unicast_real != false) {
    validate_array($unicast_real)
  }

  $java_package_real = $java_package ? {
    'UNSET' => $::elasticsearch::params::java_package,
    default => $java_package,
  }

  $es_base_real = $es_base ? {
    'UNSET' => $::elasticsearch::params::es_base,
    default => $es_base,
  }

  $es_version_real = $es_version ? {
    'UNSET' => $::elasticsearch::params::es_version,
    default => $es_version,
  }

  $es_dir_real = $es_dir ? {
    'UNSET' => $::elasticsearch::params::es_dir,
    default => $es_dir,
  }

  $es_conf_dir_real = $es_conf_dir ? {
    'UNSET' => $::elasticsearch::params::es_conf_dir,
    default => $es_conf_dir,
  }

  $es_log_dir_real = $es_log_dir ? {
    'UNSET' => $::elasticsearch::params::es_log_dir,
    default => $es_log_dir,
  }

  $es_run_dir_real = $es_run_dir ? {
    'UNSET' => $::elasticsearch::params::es_run_dir,
    default => $es_run_dir,
  }

  $es_data_dir_real = $es_data_dir ? {
    'UNSET' => $::elasticsearch::params::es_data_dir,
    default => $es_data_dir,
  }

  $es_work_dir_real = $es_work_dir ? {
    'UNSET' => $::elasticsearch::params::es_work_dir,
    default => $es_work_dir,
  }

  $es_pid_dir_real = $es_pid_dir ? {
    'UNSET' => $::elasticsearch::params::es_pid_dir,
    default => $es_pid_dir,
  }

  $es_plugins_dir_real = $es_plugins_dir ? {
    'UNSET' => $::elasticsearch::params::es_plugins_dir,
    default => $es_plugins_dir,
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

  $datacenter_real = $datacenter ? {
    'UNSET' => $::elasticsearch::params::datacenter,
    default => $datacenter,
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
