require 'spec_helper'

describe 'samba::server::service' do

  let(:pre_condition) { 'include samba::server' }

  context 'on a Debian os family' do
    context 'Debian' do
      context 'wheezy' do
        let(:facts) do
          {
            os: {
              'family' => 'Debian',
              'name' => 'Debian',
              'release' => {
                'minor' => '1',
                'major' => '7',
              }
            }
          }
        end

        it { should contain_service('samba') }
      end

      context 'jessie' do
        let(:facts) do
          {
            os: {
              'family' => 'Debian',
              'name' => 'Debian',
              'release' => {
                'minor' => '1',
                'major' => '8',
              }
            }
          }
        end

        it { should contain_service('smbd') }
      end
    end

    context 'Ubuntu' do
      let(:facts) do
        {
          os: {
            'family' => 'Debian',
            'name' => 'Ubuntu',
          }
        }
      end

      it { should contain_service('smbd') }
    end
  end

  context 'on a Redhat os family' do
    let(:facts) {{ os: { 'family' => 'RedHat' }}}
    it { should contain_service('smb') }
  end

  context 'on a Archlinux os family' do
    let(:facts) {{ os: { 'family' => 'Archlinux' }}}
    it { should contain_service('smbd') }
  end

  context 'Gentoo' do
    let(:facts) {{ os: { 'family' => 'Gentoo' }}}
    it { should contain_service('samba') }
  end

  context 'on an unsupported OS' do
    let(:facts) {{ os: { 'family' => 'Solaris' }}}
    it { should raise_error(/Solaris is not supported by this module./) }
  end
end
