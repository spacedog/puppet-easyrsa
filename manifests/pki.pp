
define easyrsa::pki (
  Boolean     $init_ca      = false,
  Enum['cn_only', 'org']
              $dn_mode      = $easyrsa::params::dn_mode,
  String      $ca_name      = $easyrsa::params::ca_name,
  Enum['rsa', 'ec']
              $key_algo     = $easyrsa::params::key_algo,
  Integer[0]  $key_size     = $easyrsa::params::key_size,
  Integer[0]  $dh_key_size  = $easyrsa::params::dh_key_size,
  Integer[0]  $ca_expire    = $easyrsa::params::ca_expire,
  String[2]   $country      = $easyrsa::params::country,
  String      $state        = $easyrsa::params::state,
  String      $city         = $easyrsa::params::city,
  String      $email        = $easyrsa::params::email,
  String      $organization = $easyrsa::params::organization,
  String      $org_unit     = $easyrsa::params::org_unit,
) {

  $pki = "${easyrsa::pkiroot}/${title}"

  exec { "build-pki-${title}":
    command   => "${easyrsa::install_dir}/easyrsa --pki-dir=${pki} --batch init-pki",
    cwd       => $easyrsa::install_dir,
    creates   => [$pki, "${pki}/private", "${pki}/reqs"],
    provider  => shell,
    timeout   => '0',
    logoutput => true,
  }

  if $init_ca {
    exec { "build-ca-${title}":
      command   => "${easyrsa::install_dir}/easyrsa --pki-dir='${pki}' --keysize=${key_size} --batch --use-algo='${key_algo}' --days=${ca_expire} --req-cn='${ca_name}' --dn-mode=${dn_mode} --req-c='${country}' --req-st='${state}' --req-city='${city}' --req-org='${organization}' --req-ou='${org_unit}' build-ca nopass",
      cwd       => $easyrsa::install_dir,
      creates   => ["${pki}/ca.crt", "${pki}/private/ca.key"],
      provider  => shell,
      timeout   => '0',
      logoutput => true,
      require   => Exec["build-pki-${title}"],
    }
    ->
    exec { "build-dh-${title}":
      command   => "${easyrsa::install_dir}/easyrsa --pki-dir=${pki} --keysize=${dh_key_size} --batch gen-dh",
      cwd       => $easyrsa::install_dir,
      creates   => "${pki}/dh.pem",
      provider  => shell,
      timeout   => '0',
      logoutput => true,
    }
  }
}
