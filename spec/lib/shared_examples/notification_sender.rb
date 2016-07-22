shared_examples 'notification sender' do
  let(:receivers) { anything }
  let(:notification_params) { anything }

  before { allow(Notifications::Send).to receive(:for) }

  it 'sends notification' do
    expect(Notifications::Send).to receive(:for).with(receivers, notification_params)

    subject
  end
end
