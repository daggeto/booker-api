describe NotificationSender do
  subject(:worker) { described_class.new }

  describe '#perform' do
    let(:receiver) { create(:user) }
    let(:notification) { create(:notification) }
    let(:notification_params) { { message: 'message'} }

    subject { worker.perform([receiver.id], notification.id, notification_params) }

    it 'sends notification' do
      expect(Notifications::Send)
        .to receive(:for)
        .with([receiver], notification, notification_params)

        subject
    end
  end
end
