require 'spec_helper'

testcases = {
  'pki1' => {},
  'pki2' => {},
}

describe 'easyrsa::pki' do

  testcases.each do |key, value|

    let(:pre_condition) { [
      'contain easyrsa',
    ] }

    context "testing #{key}" do
      let(:title) { key }
      it do
        should contain_exec("build-pki-#{title}")
          .with_command("/opt/easyrsa/easyrsa --pki-dir=/etc/easyrsa/#{title} --batch init-pki")
          .with_cwd("/opt/easyrsa")
          .with_creates(["/etc/easyrsa/#{title}", "/etc/easyrsa/#{title}/private", "/etc/easyrsa/#{title}/reqs"])
          .with_provider('shell')
          .with_timeout('0')
          .with_logoutput(true)
      end
    end
  end #testcases.each
end #describe
