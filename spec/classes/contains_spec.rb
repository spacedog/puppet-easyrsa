# To check the correct dependencies are set up for easyrsa.

require 'spec_helper'
describe 'easyrsa' do
  let(:facts) {{ :is_virtual => 'false' }}

  on_supported_os.select { |_, f| f[:os]['family'] != 'Solaris' }.each do |os, f|
    context "on #{os}" do
      let(:facts) do
        f.merge(super())
      end

      it { is_expected.to compile.with_all_deps }
      describe "Testing the dependencies between the classes" do
        it { should contain_class('easyrsa::repo') }
        it { should contain_class('easyrsa::install') }
        it { should contain_class('easyrsa::config') }

        it { is_expected.to contain_class('easyrsa::repo').that_comes_before('Class[easyrsa::install]') }
        it { is_expected.to contain_class('easyrsa::install').that_comes_before('Class[easyrsa::config]') }
      end
    end
  end
end
