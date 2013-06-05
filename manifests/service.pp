# == Class: elasticsearch::service
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
class elasticsearch::service {
  service { $elasticsearch::es_base:
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
  }
}

# vim: set ts=2 sw=2 et ft=puppet:
