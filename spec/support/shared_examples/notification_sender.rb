shared_examples 'notification sender' do
  let(:receiver) { anything }
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

  before { allow(Notifications::Send).to receive(:for) }

  it 'sends notification' do
    expect(Notifications::Send).to receive(:for).with([receiver], expected_notification_params)

    subject
  end

  context 'when sending default params' do
    let(:android_params) { hash_including(style: 'inbox') }
    let(:expected_default_params) {
      {
          notification:
            {
              android: hash_including(data: android_params),
              ios: hash_including(data: ios_params)
            }
      }
    }

    it 'sends default params' do
      expect(Notifications::Send).to receive(:for).with([receiver], expected_default_params)

      subject
    end
  end
end
