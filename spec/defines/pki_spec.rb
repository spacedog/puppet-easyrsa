require 'spec_helper'

testcases = {
  'default' => {
    params: { },
    expect: {
      install_dir: '/opt/easyrsa',
      pkiroot: '/etc/easyrsa',
    }
  },
  'customized' => {
    params: { },
    expect: {
      install_dir: '/opt/easyrsa',
      pkiroot: '/etc/easyrsa',
    }
  },
}

describe 'easyrsa::pki' do
  let(:facts) {{ :is_virtual => 'false' }}

  on_supported_os.select { |_, f| f[:os]['family'] != 'Solaris' }.each do |os, f|
    context "on #{os}" do
      let(:facts) do
        f.merge(super())
      end

      testcases.each do |profile, values|

        let(:pre_condition) { [
          'contain easyrsa',
        ] }

        context "testing #{profile}" do
          let(:title) { profile }
          let(:params) { values[:params] }

          it do
            should contain_exec("build-pki-#{title}")
              .with_command("#{values[:expect][:install_dir]}/easyrsa --pki-dir='#{values[:expect][:pkiroot]}/#{title}' --batch init-pki")
              .with_cwd("#{values[:expect][:install_dir]}")
              .with_creates(["#{values[:expect][:pkiroot]}/#{title}", "#{values[:expect][:pkiroot]}/#{title}/private", "#{values[:expect][:pkiroot]}/#{title}/reqs"])
              .with_provider('shell')
              .with_timeout('0')
              .with_logoutput(true)
          end
        end
      end #testcases.each

    end
  end
end #describe
