describe Notifications::Send do
  describe '.for' do
    let(:receivers) { [create(:user)] }
    let(:notification) { create(:notification) }
    let(:notification_params) { { message: 'message'} }
    let(:uuid) { '123' }
    let(:response) { double('response', body: { data: { uuid: uuid } }.to_json) }

    subject { described_class.for(receivers, notification, notification_params) }

    before { allow(Ionic::Request).to receive(:post).and_return(response) }

    it 'sends notification' do
      expect(Ionic::Request).to receive(:post)
      expect(Ionic::Notification::Update).to receive(:for).with(notification, uuid)

      subject
    end
  end
end
