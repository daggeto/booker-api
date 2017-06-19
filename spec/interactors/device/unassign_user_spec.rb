describe Device::UnassignUser do
  subject { described_class.for(device) }

  describe '.for' do
    let(:user) { create(:user) }
    let(:device) { create(:device, user: user) }

    it { has.to change { device.user } }
  end
end
