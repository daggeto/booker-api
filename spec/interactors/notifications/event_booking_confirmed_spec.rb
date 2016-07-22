describe Notifications::EventBookingConfirmed do
  describe '.for' do
    let(:user) { create(:user) }
    let(:service) { create(:service) }
    let(:event) { create(:event, user: user, service: service) }

    subject { described_class.for(event) }

    it_behaves_like 'notification sender' do
      let(:receivers) { [user] }
      let(:notification_params) do
        hash_including(
          title: match("#{service.name} confirmed your booking"),
          message: match('You are welcome at')
        )
      end
    end
  end
end
