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
# [*es_min_mem*]
#   Minimum amount of memory allocated to elasticsearch.
#   Default: 1g
#
# [*es_max_mem*]
#   Maximum amount of memory allocated to elasticsearch.
#   Default: 1g
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

class elasticsearch (
  $unicast        = 'UNSET',
  $java_package   = $elasticsearch::params::java_package,
  $es_base        = $elasticsearch::params::es_base,
  $es_version     = $elasticsearch::params::es_version,
  $es_dir         = $elasticsearch::params::es_dir,
  $es_conf_dir    = $elasticsearch::params::es_conf_dir,
  $es_log_dir     = $elasticsearch::params::es_log_dir,
  $es_run_dir     = $elasticsearch::params::es_run_dir,
  $es_data_dir    = $elasticsearch::params::es_data_dir,
  $es_work_dir    = $elasticsearch::params::es_work_dir,
  $es_pid_dir     = $elasticsearch::params::es_pid_dir,
  $es_plugins_dir = $elasticsearch::params::es_plugins_dir,
  $es_num_files   = $elasticsearch::params::es_num_files,
  $es_memlock     = $elasticsearch::params::es_memlock,
  $es_min_mem     = $elasticsearch::params::es_min_mem,
  $es_max_mem     = $elasticsearch::params::es_max_mem,
  $datacenter     = $elasticsearch::params::datacenter,
  $is_master      = $elasticsearch::params::is_master,
  $is_data        = $elasticsearch::params::is_data
) inherits elasticsearch::params {
  class{'elasticsearch::install': } ->
  class{'elasticsearch::config': } ~>
  class{'elasticsearch::service': } ->
  Class['elasticsearch']
}

# vim: set ts=2 sw=2 et ft=puppet:
