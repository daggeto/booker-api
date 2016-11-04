describe Ionic::Notification::Save do
  describe '.for' do
    let(:uuid) { '123' }
    let(:reservation) { create(:reservation) }
    let(:notification) { build(:notification) }

    before do
      allow(Ionic::Notification::Fetch)
        .to receive(:for)
        .with(uuid)
        .and_return(notification)
    end

    subject { described_class.for(uuid, reservation) }

    it 'fetch and save notification' do
      subject

      expect(notification.id).not_to be_nil
      expect(notification.reservation).to eq(reservation)
    end
  end
end
