require 'spec_helper'

testcases = {
  'ca1' => {
  },
}

describe 'easyrsa::ca' do

  testcases.each do |ca, value|

    let(:pre_condition) { [
      'contain easyrsa',
      'contain easyrsa::params',
      'easyrsa::pki { "ca1": }',
    ] }

    context "testing #{ca}" do
      let(:title) { ca }
      it do
        should contain_exec("build-ca-#{title}")
          .with_command("/opt/easyrsa/easyrsa --pki-dir='/etc/easyrsa/#{title}' --keysize=2048 --batch --use-algo='rsa' --days=3650 --req-cn='EasyRSA' --dn-mode=cn_only --req-c='UK' --req-st='England' --req-city='Dewsbury' --req-org='Your Company Limited' --req-ou='your_dept' build-ca nopass")
          .with_cwd("/opt/easyrsa")
          .with_creates(["/etc/easyrsa/#{title}/ca.crt", "/etc/easyrsa/#{title}/private/ca.key"])
          .with_provider('shell')
          .with_timeout('0')
          .with_logoutput(true)
      end
    end
  end #testcases.each
end #describe
