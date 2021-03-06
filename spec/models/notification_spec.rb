describe Notification do
  describe '.parse' do
    let(:uuid) { '123' }
    let(:profile) { 'profile' }
    let(:tokens) { %w( 1 2) }
    let(:json) { { uuid: uuid, config: { profile: profile, tokens: tokens } } }

    subject { described_class.parse(json) }

    it { is_expected .to include(:uuid, :profile, :tokens) }
  end
end
