require 'spec_helper'

describe 'samba::server::install', type: :class do
  context 'on a Debian OS' do
    let(:facts) { { osfamily: 'Debian' } }

    it { is_expected.to contain_package('samba') }
  end
end
