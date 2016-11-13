describe Notifications::Create do
  describe '.for' do
    let(:receiver) { create(:user) }
    let(:sender) { create(:service) }
    let(:reservation) { create(:reservation) }
    let(:title) { 'title' }
    let(:message) { 'messager' }
    let(:payload) { { state: 'state' } }
    let(:params) { { title: 'title', message: message, payload: payload  } }

    subject { described_class.for(receiver, sender, reservation, params) }

    it 'creates notification' do
      expect(subject)
        .to have_attributes(
          receiver: receiver,
          sender: sender,
          reservation: reservation,
          title: title,
          message: message,
          payload: payload
        )
    end
  end
end
