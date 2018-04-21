require 'spec_helper'

testcases = {
  'default' => {
    params: {},
    expect: {
      install_dir: '/opt/easyrsa',
      pkiroot: '/etc/easyrsa',
    },
  },
  'customized' => {
    params: {},
    expect: {
      install_dir: '/opt/easyrsa',
      pkiroot: '/etc/easyrsa',
    },
  },
}

describe 'easyrsa::pki' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      testcases.each do |profile, values|
        let(:pre_condition) do
          [
            'contain easyrsa',
          ]
        end

        context 'testing #{profile}' do
          let(:title) { profile }
          let(:params) { values[:params] }

          it do
            is_expected.to contain_exec("build-pki-#{title}")
              .with_command("#{values[:expect][:install_dir]}/easyrsa --pki-dir='#{values[:expect][:pkiroot]}/#{title}' --batch init-pki")
              .with_cwd(values[:expect][:install_dir])
              .with_creates(["#{values[:expect][:pkiroot]}/#{title}", "#{values[:expect][:pkiroot]}/#{title}/private", "#{values[:expect][:pkiroot]}/#{title}/reqs"])
              .with_provider('shell')
              .with_timeout('0')
              .with_logoutput(true)
          end
        end
      end
    end
  end
end
