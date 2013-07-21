class elasticsearch::config {
  file { "${elasticsearch::es_dir_real}/config/elasticsearch.yml":
    ensure  => file,
    content => template('elasticsearch/elasticsearch.yml.erb'),
  }

  exec { 'Install bigdesk plugin':
    command  =>
      "${elasticsearch::es_dir_real}/bin/plugin -install lukas-vlcek/bigdesk",
    creates  => "${elasticsearch::es_dir_real}/plugins/bigdesk",
  }
}

# vim: set ts=2 sw=2 et ft=puppet:
