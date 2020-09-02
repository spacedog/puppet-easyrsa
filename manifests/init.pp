
# Setup easyrsa scripts
class easyrsa (
  String               $git_package,
  Boolean              $git_manage,
  Boolean              $repo_manage,
  Stdlib::Httpsurl     $repo_source,
  Stdlib::Absolutepath $repo_target,
  String               $repo_revision,
  Stdlib::Absolutepath $install_dir,
  Stdlib::Absolutepath $pkiroot,
  Hash                 $pkis          = lookup('easyrsa::pkis', Hash, 'hash', {}),
  Hash                 $cas           = lookup('easyrsa::cas', Hash, 'hash', {}),
  Hash                 $dhparams      = lookup('easyrsa::dhparams', Hash, 'hash', {}),
  Hash                 $servers       = lookup('easyrsa::servers', Hash, 'hash', {}),
  Hash                 $clients       = lookup('easyrsa::clients', Hash, 'hash', {}),
  Hash                 $serverclients = lookup('easyrsa::serverclients', Hash, 'hash', {}),
  Hash                 $revocations   = lookup('easyrsa::revocations', Hash, 'hash', {}),
) {

  anchor { "${module_name}::begin": }
  -> class {"${module_name}::repo":}
  -> class {"${module_name}::install":}
  -> class {"${module_name}::config":}
  -> anchor { "${module_name}::end": }
}
