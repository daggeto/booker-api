describe Report::Create do
  describe '.for' do
    let(:service) { create(:service) }
    let(:reporter) { create(:user) }
    let(:message) { 'message' }

    subject { described_class.for(service, reporter, message) }

    it { has.to change(Report, :count).to(1) }
  end
end
