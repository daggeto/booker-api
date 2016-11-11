describe Ionic::Notification::Messages::FetchAll do
  describe '.for' do
    let(:uuid) { '123' }
    let(:notification_uuid) { '456' }
    let(:path) { "notifications/#{notification_uuid}/messages" }
    let(:body) { { data: [{ uuid: uuid, notification: notification_uuid }] } }
    let(:response) { instance_double(RestClient::Response, body: body.to_json) }

    subject { described_class.for(notification_uuid) }

    before { allow(Ionic::Request).to receive(:get).with(path).and_return(response) }

    its(:first) { is_expected.to include(:uuid, :notification_uuid) }
  end
end
