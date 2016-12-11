class easyrsa::install() inherits easyrsa {

  assert_private("Use of private class ${name} by ${caller_module_name}")

  file { $easyrsa::install_dir:
    ensure => link,
    target => "${easyrsa::repo_target}/easyrsa3"
  }
}
