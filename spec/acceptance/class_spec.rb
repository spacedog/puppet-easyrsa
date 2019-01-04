require 'spec_helper_acceptance'

describe 'easyrsa class:', unless: UNSUPPORTED_PLATFORMS.include?(fact('osfamily')) do
  context 'run with default settings' do
    before(:each) do
      shell 'rm -fv /etc/easyrsa/*'
    end

    let(:manifest) do
      <<-EOS
        class { 'easyrsa': }
      EOS
    end

    let(:result) { apply_manifest(manifest, catch_failures: true) }

    it 'runs without errors' do
      expect(result.exit_code).to eq 2
    end
  end

  context 'run with ca_manage => true and server client settings:' do
    let(:manifest) do
      <<-EOS
         class { 'easyrsa':
                 repo_manage => true,
                 pkis => { 'CA' => {} },
                 cas => { 'CA' => {} },
                 dhparams => { 'CA' => {} },
                 servers => { 'server' => { pki_name => 'CA' } },
                 clients => { 'client' => { pki_name => 'CA' } }
               }
      EOS
    end

    let(:result) { apply_manifest(manifest, catch_failures: true) }

    it 'runs without errors' do
      expect(result.exit_code).to eq 2
    end

    it 'generates CA directory' do
      result = shell('test -e /etc/easyrsa/CA')
      expect(result.exit_code).to eq 0
    end

    it 'generates CA certificate' do
      result = shell('test -e /etc/easyrsa/CA/ca.crt')
      expect(result.exit_code).to eq 0
    end

    it 'generates CA key' do
      result = shell('test -e /etc/easyrsa/CA/private/ca.key')
      expect(result.exit_code).to eq 0
    end

    it 'generates dh params' do
      result = shell('test -e /etc/easyrsa/CA/dh.pem')
      expect(result.exit_code).to eq 0
    end

    it 'generates server certificate' do
      result = shell('test -e /etc/easyrsa/CA/issued/server.crt')
      expect(result.exit_code).to eq 0
    end

    it 'generates server key' do
      result = shell('test -e /etc/easyrsa/CA/private/server.key')
      expect(result.exit_code).to eq 0
    end

    it 'generates client certificate' do
      result = shell('test -e /etc/easyrsa/CA/issued/client.crt')
      expect(result.exit_code).to eq 0
    end

    it 'generates client key' do
      result = shell('test -e /etc/easyrsa/CA/private/client.key')
      expect(result.exit_code).to eq 0
    end
  end
end
