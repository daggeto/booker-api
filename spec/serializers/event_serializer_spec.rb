describe EventSerializer do
  subject(:serialized) { described_class.new(event) }

  describe '#past' do
    let(:event) { create(:event, start_at: 1.hour.ago) }

    subject { serialized.past }

    it { is_expected.to be_truthy }
  end
end
