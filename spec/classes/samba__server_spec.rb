require 'spec_helper'

describe 'samba::server' do
  test_on = {
    supported_os: [
      {
        'operatingsystem' => 'Debian',
        'operatingsystemrelease' => ['10'],
      },
    ],
  }

  on_supported_os(test_on).each do |os, osfacts|
    context "on #{os}" do
      let(:facts) { osfacts }

      it { is_expected.to contain_class('samba::server::install') }
      it { is_expected.to contain_class('samba::server::config') }
      it { is_expected.to contain_class('samba::server::service') }

      it { is_expected.to contain_samba__server__option('interfaces') }
      it { is_expected.to contain_samba__server__option('bind interfaces only') }
      it { is_expected.to contain_samba__server__option('security') }
      it { is_expected.to contain_samba__server__option('server string') }
      it { is_expected.to contain_samba__server__option('unix password sync') }
      it { is_expected.to contain_samba__server__option('workgroup') }
      it { is_expected.to contain_samba__server__option('socket options') }
      it { is_expected.to contain_samba__server__option('deadtime') }
      it { is_expected.to contain_samba__server__option('keepalive') }
      it { is_expected.to contain_samba__server__option('load printers') }
      it { is_expected.to contain_samba__server__option('printing') }
      it { is_expected.to contain_samba__server__option('printcap name') }
      it { is_expected.to contain_samba__server__option('disable spoolss') }
      it { is_expected.to contain_samba__server__option('dns proxy') }
      it { is_expected.to contain_samba__server__option('log file') }
      it { is_expected.to contain_samba__server__option('max log size') }
      it { is_expected.to contain_samba__server__option('obey pam restrictions') }
      it { is_expected.to contain_samba__server__option('panic action') }
      it { is_expected.to contain_samba__server__option('passdb backend') }
      it { is_expected.to contain_samba__server__option('passwd chat') }
      it { is_expected.to contain_samba__server__option('passwd program') }
      it { is_expected.to contain_samba__server__option('server role') }
      it { is_expected.to contain_samba__server__option('syslog') }
      it { is_expected.to contain_samba__server__option('usershare allow guests') }

      context 'with hiera shares hash' do
        let(:params) do
          {
            'shares' => {
              'testShare' => {
                'path' => '/path/to/some/share',
                'browsable' => true,
                'writable' => true,
                'guest_ok' => true,
                'guest_only' => true,
                'msdfs_root' => true,
              },
              'testShare2' => {
                'path' => '/some/other/path'
              }
            }
          }
        end

        it {
          is_expected.to contain_samba__server__share('testShare').with({
                                                                          'path' => '/path/to/some/share',
            'browsable' => true,
            'writable' => true,
            'guest_ok' => true,
            'guest_only' => true,
            'msdfs_root' => true,
                                                                        })
        }
        it { is_expected.to contain_samba__server__share('testShare2').with_path('/some/other/path') }
      end

      context 'with hiera users hash' do
        let(:params) do
          {
            'users' => {
              'testUser' => {
                'password' => 'testpass01'
              },
              'testUser2' => {
                'password' => 'testpass02'
              }
            }
          }
        end

        it { is_expected.to contain_samba__server__user('testUser').with_password('testpass01') }
        it { is_expected.to contain_samba__server__user('testUser2').with_password('testpass02') }
      end
    end
  end
end
