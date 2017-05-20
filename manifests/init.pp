
# Setup easyrsa scripts
class easyrsa (
  Boolean              $repo_manage   = $easyrsa::params::repo_manage,
  Stdlib::Httpsurl     $repo_source   = $easyrsa::params::repo_source,
  Stdlib::Absolutepath $repo_target   = $easyrsa::params::repo_target,
  String               $repo_revision = $easyrsa::params::repo_revision,
  Stdlib::Absolutepath $install_dir   = $easyrsa::params::install_dir,
  Stdlib::Absolutepath $pkiroot       = $easyrsa::params::pkiroot,
  Hash                 $pkis          = hiera_hash('easyrsa::pkis', {}),
  Hash                 $cas           = hiera_hash('easyrsa::cas', {}),
  Hash                 $dhparms       = hiera_hash('easyrsa::dhparms', {}),
  Hash                 $servers       = hiera_hash('easyrsa::servers', {}),
  Hash                 $clients       = hiera_hash('easyrsa::clients', {}),
) inherits easyrsa::params {

  anchor { "${module_name}::begin": }
  -> class {"${module_name}::repo":}
  -> class {"${module_name}::install":}
  -> class {"${module_name}::config":}
  -> anchor { "${module_name}::end": }
}
