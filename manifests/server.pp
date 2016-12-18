
define easyrsa::server (
  String      $pki_name,
  Enum['cn_only', 'org']
              $dn_mode      = $easyrsa::params::dn_mode,
  Struct[{algo       => Enum[rsa, ec],
          size       => Integer[0],
          valid_days => Integer[0]}]
              $key          = $easyrsa::params::key,
  String[2]   $country      = $easyrsa::params::country,
  String      $state        = $easyrsa::params::state,
  String      $city         = $easyrsa::params::city,
  String      $email        = $easyrsa::params::email,
  String      $organization = $easyrsa::params::organization,
  String      $org_unit     = $easyrsa::params::org_unit,
  ) {

  Easyrsa::Pki[$pki_name] -> Easyrsa::Server[$title]

  $pki = "${easyrsa::pkiroot}/${pki_name}"

  exec { "build-server-${title}":
    command   => "${easyrsa::install_dir}/easyrsa --pki-dir='${pki}' --keysize=${key[size]} --batch --use-algo='${key[algo]}' --days=${key[valid_days]} --req-cn='${title}' --dn-mode=${dn_mode} --req-c='${country}' --req-st='${state}' --req-city='${city}' --req-org='${organization}' --req-ou='${org_unit}' build-server-full ${title} nopass",
    cwd       => $easyrsa::install_dir,
    creates   => ["${pki}/issued/${title}.crt", "${pki}/private/${title}.key"],
    provider  => shell,
    timeout   => '0',
    logoutput => true,
  }
}
