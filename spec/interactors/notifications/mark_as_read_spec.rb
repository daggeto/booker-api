describe Notifications::MarkAsRead do
  describe '.for' do
    let(:user) { create(:user) }
    let(:notification) { create(:notification, receiver: user) }

    subject { described_class.for(notification) }

    it 'marks notification as read' do
      subject

      expect(notification.unread?(user)).to be_falsey
    end
  end
end
