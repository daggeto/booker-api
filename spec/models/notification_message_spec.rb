describe NotificationMessage do
  describe '.parse' do
    let(:uuid) { '123' }
    let(:created) { Time.now }
    let(:notification) { '345' }
    let(:status) { 'status' }
    let(:error) { 'ERROR' }
    let(:json) {
      {
        uuid: uuid,
        created: created,
        notification: notification,
        status: status,
        error: error
      }
    }

    subject { described_class.parse(json) }

    it { is_expected.to include(:uuid, :created, :notification_uuid, :status, :error) }
  end
end
