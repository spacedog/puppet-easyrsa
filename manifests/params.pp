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
  $key             = { algo => 'rsa', size => 2048, valid_days => 3650 }
  $dh_key_size     = 2048
  $country         = 'UK'
  $state           = 'England'
  $city            = 'Dewsbury'
  $email           = 'you@yourcompany.com'
  $organization    = 'Your Company Limited'
  $org_unit        = 'your_dept'
}
