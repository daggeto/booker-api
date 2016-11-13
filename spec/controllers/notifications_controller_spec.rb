describe Api::V1::NotificationsController do
  let(:user) { create(:user) }

  before { sign_in(user) }

  describe '#index' do
    let(:other_user) { create(:user) }
    let!(:other_user_notification) { create(:notification, receiver: other_user) }
    let!(:notification) { create(:notification, receiver: user, sender: other_user) }

    subject { get :index }

    it 'returns notifications' do
      subject

      expect(json['notifications'].size).to eq(1)
    end
  end

  describe '#mark_as_read' do
    let(:params) { { notification_id: notification.id } }
    let!(:notification) { create(:notification, receiver: user) }

    subject { post :mark_as_read, params }

    it_behaves_like 'success response'

    it 'marks as read only one notification' do
      expect(Notifications::MarkAsRead).to receive(:for).with(notification)

      subject
    end
  end

  describe '#mark_all_as_read' do
    subject { post :mark_all_as_read }

    it_behaves_like 'success response'

    it 'marks all user notifications as read' do
      expect(Notifications::MarkAllAsRead).to receive(:for).with(user)

      subject
    end
  end
end
