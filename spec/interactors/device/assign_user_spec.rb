describe Device::AssignUser do
  subject { described_class.for(device, user) }

  describe '.for' do
    let(:user) { create(:user) }
    let(:device) { create(:device) }

    it { has.to change { device.user } }
  end
end
