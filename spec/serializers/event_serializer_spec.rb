describe EventSerializer do
  subject(:serialized) { described_class.new(event) }

  describe '#label' do
    let(:params) { {} }
    let(:event) { create(:event, params) }

    subject { serialized.label }

    it { is_expected.to be(event.description) }

    context 'when user is booked event' do
      let(:user) { create(:user) }
      let(:params) { { user: user } }

      it { is_expected.to be(user.email) }
    end
  end

  describe '#past' do
    let(:event) { create(:event, start_at: 1.hour.ago) }

    subject { serialized.past }

    it { is_expected.to be_truthy }
  end
end
