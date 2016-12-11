# Class: easyrsa::params
#
class easyrsa::params {
  $repo_manage     = true
  $repo_source     = 'https://github.com/OpenVPN/easy-rsa.git'
  $repo_target     = '/opt/easyrsa-git'
  $repo_revision   = '3.0.1'

  $install_dir     = '/opt/easyrsa'
  $pkiroot         = '/etc/easyrsa'

  $dn_mode         = 'cn_only'

  $ca_name         = 'EasyRSA'
  $key_algo        = 'rsa'
  $key_size        = 2048
  $dh_key_size     = 4096
  $ca_expire       = 3650
  $key_expire      = 3650
  $country         = 'UK'
  $state           = 'England'
  $city            = 'Dewsbury'
  $email           = 'you@yourcompany.com'
  $organization    = 'Your Company Limited'
  $org_unit        = 'your_dept'
}
