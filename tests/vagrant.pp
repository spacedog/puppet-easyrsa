class { 'easyrsa':
  pkis => {
    'test-pki' => {
      init_ca => true
    },
    servers   => {
      'test' => {
        pki_name => 'test-pki'
      }
    },
    clients   => {
      'test' => {
        pki_name => 'test-pki'
      }
    },
  }
}
