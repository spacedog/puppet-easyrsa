
define easyrsa::ca (
  String      $pki_name     = $title,
  Enum['cn_only', 'org']
              $dn_mode      = lookup('easyrsa::dn_mode'),
  String      $ca_name      = lookup('easyrsa::ca_name'),
  Struct[{algo       => Enum[rsa, ec],
          size       => Integer[0],
          valid_days => Integer[0]}]
              $key          = lookup('easyrsa::key'),
  String[2]   $country      = lookup('easyrsa::country'),
  String      $state        = lookup('easyrsa::state'),
  String      $city         = lookup('easyrsa::city'),
  String      $email        = lookup('easyrsa::email'),
  String      $organization = lookup('easyrsa::organization'),
  String      $org_unit     = lookup('easyrsa::org_unit'),
) {

  Easyrsa::Pki[$pki_name] -> Easyrsa::Ca[$title]

  $pki = "${easyrsa::pkiroot}/${pki_name}"

  exec { "build-ca-${pki_name}":
    command   => "${easyrsa::install_dir}/easyrsa --pki-dir='${pki}' --keysize=${key[size]} --batch --use-algo='${key[algo]}' --days=${key[valid_days]} --req-cn='${ca_name}' --dn-mode=${dn_mode} --req-c='${country}' --req-st='${state}' --req-city='${city}' --req-org='${organization}' --req-ou='${org_unit}' --req-email='${email}' build-ca nopass",
    cwd       => $easyrsa::install_dir,
    creates   => ["${pki}/ca.crt", "${pki}/private/ca.key"],
    provider  => shell,
    timeout   => '0',
    logoutput => true,
  }
}
