describe Ionic::Notification::Fetch do
  describe '.for' do
    let(:uuid) { '123' }
    let(:path) { "notifications/#{uuid}" }
    let(:body) { { data: { uuid: uuid } }.to_json }
    let(:message) { { status: 'status' } }
    let(:notification) { { uuid: uuid } }
    let(:response) { instance_double(RestClient::Response, body: body) }

    before do
      allow(Ionic::Request).to receive(:get).with(path).and_return(response)
      allow(Notification).to receive(:parse).and_return(notification)
      allow(Ionic::Notification::Messages::FetchAll).to receive(:for).and_return([message])
    end

    subject { described_class.for(uuid) }

    it { is_expected.to include(:uuid, :messages) }
  end
end
