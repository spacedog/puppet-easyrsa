require 'spec_helper'
describe 'easyrsa' do
  let(:facts) {{ :is_virtual => 'false' }}

  on_supported_os.select { |_, f| f[:os]['family'] != 'Solaris' }.each do |os, f|
    context "on #{os}" do
      let(:facts) do
        f.merge(super())
      end

      describe 'easyrsa::install', :type => :class do
        let :pre_condition do
            'class { "easyrsa": }'
        end

        it { is_expected.to contain_file('/opt/easyrsa')
          .with_ensure('link')
        }

      end
    end
  end
end
