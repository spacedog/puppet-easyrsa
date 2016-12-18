
define easyrsa::pki() {

  $pki = "${easyrsa::pkiroot}/${title}"

  exec { "build-pki-${title}":
    command   => "${easyrsa::install_dir}/easyrsa --pki-dir=${pki} --batch init-pki",
    cwd       => $easyrsa::install_dir,
    creates   => [$pki, "${pki}/private", "${pki}/reqs"],
    provider  => shell,
    timeout   => '0',
    logoutput => true,
  }
}
