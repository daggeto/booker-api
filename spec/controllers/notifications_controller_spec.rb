describe Api::V1::NotificationsController do
  let(:user) { create(:user) }

  before { sign_in(user) }

  describe '#index' do
    let(:other_user) { create(:user) }
    let!(:other_user_notification) { create(:notification, receiver: other_user) }
    let!(:notification) { create(:notification, receiver: user) }

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

    it 'marks as read only one notification' do
      subject

      expect(notification.unread?(user)).to be_falsey
    end
  end

  describe '#mark_all_as_read' do
    let!(:notification) { create(:notification, receiver: user) }
    let!(:second_notification) { create(:notification, receiver: user) }

    subject { post :mark_all_as_read }

    it 'marks as all current user notifications' do
      subject

      expect(notification.unread?(user)).to be_falsey
      expect(second_notification.unread?(user)).to be_falsey
    end
  end
end
