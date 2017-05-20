require 'spec_helper'

describe 'easyrsa' do
  let(:facts) {{ :is_virtual => 'false' }}

  on_supported_os.select { |_, f| f[:os]['family'] != 'Solaris' }.each do |os, f|
    context "on #{os}" do
      let(:facts) do
        f.merge(super())
      end

      it { is_expected.to compile.with_all_deps }

      describe 'ensure easyrsa repo is managed' do
        let(:params) {{ :repo_manage => true, }}

        it { should contain_file('/opt/easyrsa').with(
          :ensure => 'link'
        )}

        describe 'ensure wget is not managed' do
          let(:params) {{ :repo_manage => false, }}
          #it { should_not contain_file('/opt/easyrsa') }
        end
      end

    end
  end
end
