require 'spec_helper'

describe 'samba::server::ads', :type => :class do

  on_supported_os.each do |os, osfacts|
    describe "on #{os}" do
      let(:facts) { osfacts }

      context "Default config" do
        it { should contain_exec('join-active-directory') }
      end

      context "No join" do
        let ( :params ) { { 'perform_join' => false }}
        it { should_not contain_exec('join-active-directory') }
      end

      context "Join 'forced'" do
        let ( :params ) { { 'perform_join' => true }}
        it { should contain_exec('join-active-directory') }
      end
    end
  end
end

