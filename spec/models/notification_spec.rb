describe Notification do
  describe '.parse' do
    let(:uuid) { '123' }
    let(:profile) { 'profile' }
    let(:tokens) { %w( 1 2) }
    let(:json) { { uuid: uuid, config: { profile: profile, tokens: tokens } } }

    subject { described_class.parse(json) }

    its(:uuid) { is_expected.to eq(uuid) }
    its(:profile) { is_expected.to eq(profile) }
    its(:tokens) { is_expected.to eq(tokens.to_s) }
  end
end
