require 'spec_helper_acceptance'

describe 'easyrsa class:', :unless => UNSUPPORTED_PLATFORMS.include?(fact('osfamily')) do
  it 'should run successfully' do
    pp = "class { 'easyrsa': }"

    # Apply twice to ensure no errors the second time.
    apply_manifest(pp, :catch_failures => true) do |r|
      expect(r.stderr).not_to match(/error/i)
    end
    apply_manifest(pp, :catch_failures => true) do |r|
      expect(r.stderr).not_to eq(/error/i)

      expect(r.exit_code).to be_zero
    end
  end

  before do
    shell "rm -fv /etc/easyrsa/*"
  end

  context 'ca_manage => true:' do
    it 'runs successfully' do
      pp = "class { 'easyrsa':
        repo_manage => true,
        pkis => { 'EasyRSA' => {} }
      }"

      apply_manifest(pp, :catch_failures => true) do |r|
        expect(r.stderr).not_to match(/error/i)
      end

      shell('test -e /etc/easyrsa/EasyRSA')

    end
  end

end
