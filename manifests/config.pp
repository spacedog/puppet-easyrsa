class easyrsa::config() inherits easyrsa {

  assert_private("Use of private class ${name} by ${caller_module_name}")

  file { $easyrsa::pkiroot:
    ensure => directory,
  }

  create_resources('easyrsa::pki', $easyrsa::pkis)
  create_resources('easyrsa::ca', $easyrsa::cas)
  create_resources('easyrsa::dh', $easyrsa::dhparams)
  create_resources('easyrsa::server', $easyrsa::servers)
  create_resources('easyrsa::client', $easyrsa::clients)
  create_resources('easyrsa::revoke', $easyrsa::revocations)
}
