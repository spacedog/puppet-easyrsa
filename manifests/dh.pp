
define easyrsa::dh (
  String      $pki_name     = $title,
  Integer[0]  $dh_key_size  = $easyrsa::params::dh_key_size,
) {

  Easyrsa::Pki[$pki_name] -> Easyrsa::Dh[$title]

  $pki = "${easyrsa::pkiroot}/${title}"

  exec { "build-dh-${title}":
    command   => "${easyrsa::install_dir}/easyrsa --pki-dir=${pki} --keysize=${dh_key_size} --batch gen-dh",
    cwd       => $easyrsa::install_dir,
    creates   => "${pki}/dh.pem",
    provider  => shell,
    timeout   => '0',
    logoutput => true,
  }
}
