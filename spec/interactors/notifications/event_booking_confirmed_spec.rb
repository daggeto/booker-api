describe Notifications::EventBookingConfirmed do
  describe '.for' do
    let(:user) { create(:user) }
    let(:service) { create(:service) }
    let(:event) { create(:event, user: user, service: service, start_at: 1.hour.since) }

    subject { described_class.for(event) }

    it_behaves_like 'notification sender' do
      let(:receiver) { user }
      let(:notification_params) do
        hash_including(
          title: match(service.name),
          message: match('Booking confirmed')
        )
      end
    end
  end
end
