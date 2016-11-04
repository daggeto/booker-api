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

    its(:uuid) { is_expected.to eq(uuid) }
    its(:created) { is_expected.to eq(created) }
    its(:notification_uuid) { is_expected.to eq(notification) }
    its(:status) { is_expected.to eq(status) }
    its(:error) { is_expected.to eq(error) }
  end
end
