require 'spec_helper_acceptance'

describe 'easyrsa class:', unless: UNSUPPORTED_PLATFORMS.include?(fact('osfamily')) do
  it 'easyrsa is expected run successfully' do
    pp = "class { 'easyrsa': }"

    # Apply twice to ensure no errors the second time.
    apply_manifest(pp, catch_failures: true) do |r|
      expect(r.stderr).not_to match(%r{error}i)
    end
    apply_manifest(pp, catch_failures: true) do |r|
      expect(r.stderr).not_to eq(%r{error}i)

      expect(r.exit_code).to be_zero
    end
  end

  before(:each) do
    shell 'rm -fv /etc/easyrsa/*'
  end

  context 'ca_manage => true:' do
    it 'runs successfully' do
      pp = "class { 'easyrsa':
        repo_manage => true,
        pkis => { 'CA' => {} },
        cas => { 'CA' => {} },
        dhparams => { 'CA' => {} },
        servers => { 'server' => { pki_name => 'CA' } },
        clients => { 'client' => { pki_name => 'CA' } }
      }"

      apply_manifest(pp, catch_failures: true) do |r|
        expect(r.stderr).not_to match(%r{error}i)
      end

      shell('test -e /etc/easyrsa/CA')
      shell('test -e /etc/easyrsa/CA/ca.crt')
      shell('test -e /etc/easyrsa/CA/private/ca.key')
      shell('test -e /etc/easyrsa/CA/dh.pem')
      shell('test -e /etc/easyrsa/CA/issued/server.crt')
      shell('test -e /etc/easyrsa/CA/private/server.key')
      shell('test -e /etc/easyrsa/CA/issued/client.crt')
      shell('test -e /etc/easyrsa/CA/private/client.key')
    end
  end
end
