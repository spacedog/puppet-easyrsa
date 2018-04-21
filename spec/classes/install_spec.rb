require 'spec_helper'

describe 'easyrsa' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      describe 'easyrsa::install', type: :class do
        let :pre_condition do
          'class { "easyrsa": }'
        end

        it {
          is_expected.to contain_file('/opt/easyrsa')
            .with_ensure('link')
        }
      end
    end
  end
end
