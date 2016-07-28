describe Notifications::EventCanceledByClient do
  describe '.for' do
    let(:client) { create(:user) }
    let(:event) { create(:event) }
    let(:service) { create(:service, events: [event]) }
    let(:provider) { create(:user, service: service) }

    subject { described_class.for(client, event) }

    it_behaves_like 'notification sender' do
      let(:receiver) { provider }
      let(:notification_params) do
        hash_including(
          title: 'Event canceled',
          message: match(client.email).and(match('canceled registration'))
        )
      end
    end
  end
end
