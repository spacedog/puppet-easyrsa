node default {

  notify { 'enduser-before': }
  notify { 'enduser-after': }

  class { 'easyrsa':
    pkis        => {
      'test-pki' => {},
    },
    cas         => {
      'test-pki' => {
        key => {
          algo       => ec,
          size       => 64,
          valid_days => 30,
        },
      },
    },
    dhparams    => {
      'test-pki' => {
        key_size => 512,
      },
    },
    servers     => {
      'test-serverA' => {
        pki_name => 'test-pki',
        key      => {
          algo       => ec,
          size       => 64,
          valid_days => 30,
        },
      },
      'test-serverB' => {
        pki_name => 'test-pki',
        key      => {
          algo       => ec,
          size       => 64,
          valid_days => 30,
        }
      }
    },
    clients     => {
      'test-clientA' => {
        pki_name => 'test-pki',
        key      => {
          algo       => ec,
          size       => 64,
          valid_days => 30,
        }
      },
      'test-clientB' => {
        pki_name => 'test-pki',
        key      => {
          algo       => ec,
          size       => 64,
          valid_days => 30,
        }
      },
    },
    revocations => {
      'test-clientA' => {
        pki_name => 'test-pki',
        type     => client,
      },
      'test-serverA' => {
        pki_name => 'test-pki',
        type     => server,
      },
    },
    require     => Notify['enduser-before'],
    before      => Notify['enduser-after'],
  }
}
