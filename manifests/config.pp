class easyrsa::config() inherits easyrsa {

  assert_private("Use of private class ${name} by ${caller_module_name}")

  file { $easyrsa::pkiroot:
    ensure => directory,
  }

  create_resources('easyrsa::pki', $easyrsa::pkis)
  create_resources('easyrsa::servers', $easyrsa::servers)
  create_resources('easyrsa::clients', $easyrsa::clients)
}
