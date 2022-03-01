require 'spec_helper'

describe 'samba::server::config', type: :class do
  test_on = {
    supported_os: [
      {
        'operatingsystem'        => 'Debian',
        'operatingsystemrelease' => ['10'],
      },
    ],
  }

  let(:pre_condition) { 'include samba::server' }

  on_supported_os(test_on).each do |os, osfacts|
    context "on #{os}" do
      let(:facts) { osfacts }

      it { is_expected.to contain_file('/etc/samba/smb.conf').with_owner('root') }
    end
  end
end
