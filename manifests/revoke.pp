define easyrsa::revoke (
  String               $pki_name,
  Enum[server, client] $type,
) {

  if $type == server {
    Easyrsa::Pki[$pki_name] -> Easyrsa::Server[$title]
    Easyrsa::Server[$title] -> Easyrsa::Revoke[$title]
  } else {
    Easyrsa::Pki[$pki_name] -> Easyrsa::Client[$title]
    Easyrsa::Client[$title] -> Easyrsa::Revoke[$title]
  }

  $pki = "${easyrsa::pkiroot}/${pki_name}"

  exec { "build-revoke-${title}":
    command   => "mkdir -p ${pki}/revocations; ${easyrsa::install_dir}/easyrsa --pki-dir='${pki}' --batch revoke ${title} nopass; ln -sf ${pki}/issued/${title}.crt ${pki}/revocations/${title}.crt",
    cwd       => $easyrsa::install_dir,
    creates   => ["${pki}/revocations/${title}.crt"],
    provider  => shell,
    timeout   => '0',
    logoutput => true,
  }
  ~> exec { "build-crl-${title}":
    command     => "${easyrsa::install_dir}/easyrsa --pki-dir='${pki}' --batch gen-crl",
    cwd         => $easyrsa::install_dir,
    refreshonly => true,
    provider    => shell,
    timeout     => '0',
    logoutput   => true,
  }
}
