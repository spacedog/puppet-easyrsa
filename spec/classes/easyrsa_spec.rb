require 'spec_helper'

describe 'easyrsa' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      it { is_expected.to compile.with_all_deps }

      describe 'ensure easyrsa repo is managed' do
        let(:params) do
          {
            repo_manage: true,
          }
        end

        it {
          is_expected.to contain_vcsrepo('/opt/easyrsa-git').with(
            ensure: 'present',
            provider: 'git',
            source: 'https://github.com/OpenVPN/easy-rsa.git',
            revision: 'v3.0.3',
          )
        }

        it {
          is_expected.to contain_file('/opt/easyrsa').with(
            ensure: 'link',
          )
        }
      end

      describe 'ensure easyrsa is not managed' do
        let(:params) do
          {
            repo_manage: false,
          }
        end

        it {
          is_expected.not_to contain_vcsrepo('/opt/easyrsa-git')
        }
      end
    end
  end
end
