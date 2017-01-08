describe SupportIssue::Create do
  describe '.for' do
    let(:user) { create(:user) }
    let(:params) do
      {
        message: 'message',
        platform: 'iOs',
        version: '10.5',
        app_version: '0.0.1',
        device_details: { manufacturer: 'Apple' }.to_json
      }
    end

    subject { described_class.for(user, params) }

    it { has.to change { user.reload.support_issues.count }.to(1) }

    it { has.to change(SupportIssue, :count).to(1) }
  end
end
