describe Notifications::ConfirmEventBooking do
  describe '.for' do
    let(:client) { create(:user) }
    let(:provider) { create(:user, :with_service) }
    let(:event) { create(:event, service: provider.service, start_at: 1.hour.since) }

    subject { described_class.for(client, event) }

    it_behaves_like 'notification sender' do
      let(:receiver) { provider }
      let(:notification_params) do
        hash_including(
          title: match('You have booking'),
          message: match(client.email)
        )
      end
    end
  end
end
