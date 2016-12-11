require 'spec_helper'
describe 'easyrsa' do

  let(:facts) { {
    :os => { 'name' => 'Ubuntu' }
  } }

  it { should compile }

  context 'with default values for all parameters' do
    it { should contain_class('easyrsa::repo') }
    it { should contain_class('easyrsa::install') }
    it { should contain_class('easyrsa::config') }
  end
end
