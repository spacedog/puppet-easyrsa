node default {

  notify { 'enduser-before': }
  notify { 'enduser-after': }

  class { 'easyrsa':
    pkis    => {
      'test-pki' => {},
    },
    cas     => {
      'test-pki' => {},
    },
    dhparms => {
      'test-pki' => {},
    },
    require => Notify['enduser-before'],
    before  => Notify['enduser-after'],
  }
}
