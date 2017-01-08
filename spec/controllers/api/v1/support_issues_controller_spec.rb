describe Api::V1::SupportIssuesController do
  let(:user) { create(:user) }

  before { sign_in(user) }

  describe '#create' do
    let(:message) { 'message' }
    let(:app_version) { '0.0.1' }
    let(:platform) { 'iOs' }
    let(:version) { '10.5' }
    let(:device_details) { { manufacturer: 'Apple', platform: platform, version: version } }
    let(:params) { { message: message, app_version: app_version, device_details: device_details } }
    let(:expected_params) do
      {
        message: message,
        app_version: app_version,
        platform: platform,
        version: version,
        device_details: device_details.to_json
      }
    end

    subject { post :create, params }

    it_behaves_like 'success response'

    it 'creates new isssue' do
      expect(SupportIssue::Create).to receive(:for).with(user, expected_params)

      subject
    end
  end
end
