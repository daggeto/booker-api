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
  let(:uuid) { '123' }

  before do
    allow(Notifications::Send).to receive(:for).and_return(uuid)
    allow(Ionic::Notification::Update).to receive(:for)
  end

  it 'sends notification' do
    expect(Notifications::Send).to receive(:for).with([receiver], expected_notification_params)
    expect(Ionic::Notification::Update).to receive(:for).with(anything, uuid)

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
      expect(Notifications::Send).to receive(:for).with([receiver], expected_default_params)

      subject
    end
  end
end
