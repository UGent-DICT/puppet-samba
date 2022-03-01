require 'spec_helper'

describe 'samba::server::user', type: :define do
  let(:pre_condition) { 'include samba::server' }

  let(:title) { 'test_user' }
  let(:params) { { password: 'secret' } }

  on_supported_os.each do |os, osfacts|
    context "on #{os}" do
      let(:facts) { osfacts }

      it { is_expected.to contain_samba__server__user('test_user') }
      it {
        is_expected.to contain_exec('add smb account for test_user').with(
        command: '/bin/echo -e \'secret\nsecret\n\' | /usr/bin/pdbedit --password-from-stdin -a \'test_user\'',
        unless: '/usr/bin/pdbedit \'test_user\'',
        notify: 'Class[Samba::Server::Service]',
      )
      }
    end
  end
end
