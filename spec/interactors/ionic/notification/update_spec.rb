describe Ionic::Notification::Update do
  describe '.for' do
    let(:notification_id) { '123' }
    let(:notification_response) { { uuid: notification_id } }
    let(:messages) { [{ uuid: '456' }] }
    let(:notification) { create(:notification) }

    before do
      allow(Ionic::Notification::Fetch)
        .to receive(:for)
        .with(notification_id)
        .and_return(notification_response)

      allow(Ionic::Notification::Messages::FetchAll)
        .to receive(:for)
        .with(notification_id)
        .and_return(messages)
    end

    subject { described_class.for(notification, notification_id) }

    it 'updates notification' do
      subject

      expect(notification.reload.uuid).to eq(notification_id)
      expect(notification.reload.messages.size).to eq(1)
    end
  end
end
