describe Notifications::EventReminder do
  describe '.for' do
    let(:client) { create(:user) }
    let(:service) { create(:service) }
    let(:event) { create(:event, user: client, service: service) }

    subject { described_class.for(event) }

    it_behaves_like 'notification sender' do
      let(:receiver) { client }
      let(:notification_params) do
        hash_including(
          title: service.name,
          message: include('You have reservation')
        )
      end
    end
  end
end
