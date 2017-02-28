shared_examples 'notification sender' do
  let(:receiver_id) { anything }
  let(:notification_id) { anything }
  let(:notification_params) { anything }
  let(:android_params) { anything }
  let(:ios_params) { anything }
  let(:expected_notification_params) {
    {
        notification:{
            android: notification_params,
            ios: notification_params
        }
    }
  }
  let(:uuid) { '123' }
  let(:current_time) { Time.now }

  before do
    allow(NotificationSender).to receive(:perform_in)
    allow(Time).to receive(:now).and_return(current_time)
  end

  it 'sends notification' do
    expect(NotificationSender)
      .to receive(:perform_in)
      .with(current_time, [receiver_id], notification_id, expected_notification_params)

    subject
  end

  context 'when sending default params' do
    let(:android_params) { hash_including(style: 'inbox') }
    let(:expected_default_params) {
      {
          notification:
            {
              android: hash_including(data: android_params),
              ios: ios_params
            }
      }
    }

    it 'sends default params' do
      expect(NotificationSender)
        .to receive(:perform_in)
        .with(current_time, [receiver_id], notification_id, expected_default_params)

      subject
    end
  end
end
