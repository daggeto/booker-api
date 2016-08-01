describe Notifications::EventBookingUnconfirmed do
  describe '.for' do
    let(:client) { create(:user) }
    let(:service) { create(:service) }
    let(:event) { create(:event, user: client, service: service) }

    subject { described_class.for(event) }

    it_behaves_like 'notification sender' do
      let(:receiver) { client }
      let(:notification_params) do
        hash_including(
          title: event.service.name,
          message: match('are not confirmed')
        )
      end
    end
  end
end
