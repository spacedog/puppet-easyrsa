
# Setup easyrsa scripts
class easyrsa (
  Boolean              $repo_manage   = $easyrsa::params::repo_manage,
  Stdlib::Httpsurl     $repo_source   = $easyrsa::params::repo_source,
  Stdlib::Absolutepath $repo_target   = $easyrsa::params::repo_target,
  String               $repo_revision = $easyrsa::params::repo_revision,
  Stdlib::Absolutepath $install_dir   = $easyrsa::params::install_dir,
  Stdlib::Absolutepath $pkiroot       = $easyrsa::params::pkiroot,
  Hash                 $pkis          = lookup('easyrsa::pkis', Hash, 'hash', {}),
  Hash                 $cas           = lookup('easyrsa::cas', Hash, 'hash', {}),
  Hash                 $dhparms       = lookup('easyrsa::dhparms', Hash, 'hash', {}),
  Hash                 $servers       = lookup('easyrsa::servers', Hash, 'hash', {}),
  Hash                 $clients       = lookup('easyrsa::clients', Hash, 'hash', {}),
) inherits easyrsa::params {

  anchor { "${module_name}::begin": }
  -> class {"${module_name}::repo":}
  -> class {"${module_name}::install":}
  -> class {"${module_name}::config":}
  -> anchor { "${module_name}::end": }
}
