describe NotificationSerializer do
  subject(:serialized) { described_class.new(notification) }

  describe '#unread' do
    let(:user) { create(:user) }
    let(:notification) { create(:notification, receiver: user) }

    subject { serialized.unread }

    before { allow_any_instance_of(Notification).to receive(:unread?).with(user).and_return(true) }

    it { is_expected.to be_truthy }
  end
end
