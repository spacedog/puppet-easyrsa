require 'spec_helper'

testcases = {
  'default' => {
    params: {},
    expect: {
      install_dir: '/opt/easyrsa',
      pkiroot: '/etc/easyrsa',
      ca_name: 'EasyRSA',
      dn_mode: 'cn_only',
      key_algo: 'rsa',
      key_size: 2048,
      valid_days: 3650,
      country: 'UK',
      state: 'England',
      city: 'Dewsbury',
      email: 'you@yourcompany.com',
      organization: 'Your Company Limited',
      org_unit: 'your_dept',
    },
  },
  'customized' => {
    params: {
      ca_name: 'Prime CA',
      dn_mode: 'org',
      country: 'US',
      state: 'New Jersey',
      city: 'Jersey City',
      email: 'you@yourcompany.com',
      organization: 'Your Company Limited',
      org_unit: 'your_dept',
    },
    expect: {
      install_dir: '/opt/easyrsa',
      pkiroot: '/etc/easyrsa',
      ca_name: 'Prime CA',
      dn_mode: 'org',
      key_algo: 'rsa',
      key_size: 2048,
      valid_days: 3650,
      country: 'US',
      state: 'New Jersey',
      city: 'Jersey City',
      email: 'you@yourcompany.com',
      organization: 'Your Company Limited',
      org_unit: 'your_dept',
    },
  },
}

describe 'easyrsa::ca' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      testcases.each do |profile, values|
        let(:pre_condition) do
          [
            'contain easyrsa',
            'easyrsa::pki { "default": }',
            'easyrsa::pki { "customized": }',
          ]
        end

        context 'testing #{profile}' do
          let(:title) { profile }
          let(:params) { values[:params] }

          # rubocop:disable Metrics/LineLength
          it {
            is_expected.to contain_exec("build-ca-#{title}")
              .with_command("#{values[:expect][:install_dir]}/easyrsa --pki-dir='#{values[:expect][:pkiroot]}/#{title}' --keysize=#{values[:expect][:key_size]} --batch --use-algo='#{values[:expect][:key_algo]}' --days=#{values[:expect][:valid_days]} --req-cn='#{values[:expect][:ca_name]}' --dn-mode=#{values[:expect][:dn_mode]} --req-c='#{values[:expect][:country]}' --req-st='#{values[:expect][:state]}' --req-city='#{values[:expect][:city]}' --req-org='#{values[:expect][:organization]}' --req-ou='#{values[:expect][:org_unit]}' --req-email='#{values[:expect][:email]}' build-ca nopass")
              .with_cwd(values[:expect][:install_dir])
              .with_creates(
                [
                  "#{values[:expect][:pkiroot]}/#{title}/ca.crt",
                  "#{values[:expect][:pkiroot]}/#{title}/private/ca.key",
                ],
              )
              .with_provider('shell')
              .with_timeout('0')
              .with_logoutput(true)
          }
          # rubocop:enable Metrics/LineLength
        end
      end
    end
  end
end
