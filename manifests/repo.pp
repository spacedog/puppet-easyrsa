class easyrsa::repo () inherits easyrsa {

  assert_private("Use of private class ${name} by ${caller_module_name}")

  if $easyrsa::repo_manage {

    if $easyrsa::git_manage {
      ensure_packages([$easyrsa::git_package], { 'ensure' => 'present' })
    }

    vcsrepo { $easyrsa::repo_target:
      ensure   => present,
      provider => git,
      source   => $easyrsa::repo_source,
      revision => $easyrsa::repo_revision,
    }
  }
}
