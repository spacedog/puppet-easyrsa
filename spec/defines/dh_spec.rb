require 'spec_helper'

testcases = {
  'dh1' => {
  },
}

describe 'easyrsa::dh' do

  testcases.each do |dh, value|

    let(:pre_condition) { [
      'contain easyrsa',
      'contain easyrsa::params',
      'easyrsa::pki { "dh1": }',
    ] }

    context "testing #{dh}" do
      let(:title) { dh }
      it do
        should contain_exec("build-dh-#{title}")
          .with_command("/opt/easyrsa/easyrsa --pki-dir=/etc/easyrsa/#{title} --keysize=2048 --batch gen-dh")
          .with_cwd("/opt/easyrsa")
          .with_creates("/etc/easyrsa/#{title}/dh.pem")
          .with_provider('shell')
          .with_timeout('0')
          .with_logoutput(true)
      end
    end
  end #testcases.each
end #describe
