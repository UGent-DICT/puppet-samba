require 'spec_helper'

describe 'samba::server::ads', type: :class do
  on_supported_os.each do |os, osfacts|
    describe "on #{os}" do
      let(:facts) { osfacts }

      context 'Default config' do
        it { is_expected.to contain_exec('net ads join') }
      end

      context 'No join' do
        let(:params) { { 'perform_join' => false } }

        it { is_expected.not_to contain_exec('net ads join') }
      end

      context "Join 'forced'" do
        let(:params) { { 'perform_join' => true } }

        it { is_expected.to contain_exec('net ads join') }
      end
    end
  end
end
