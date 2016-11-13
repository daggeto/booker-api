describe Notifications::MarkAllAsRead do
  describe '.for' do
    let(:user) { create(:user) }
    let!(:notification) { create(:notification, receiver: user) }
    let!(:second_notification) { create(:notification, receiver: user) }

    subject { described_class.for(user) }

    it 'marks as read all current user notifications' do
      subject

      expect(notification.unread?(user)).to be_falsey
      expect(second_notification.unread?(user)).to be_falsey
    end
  end
end
