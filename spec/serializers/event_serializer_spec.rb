describe EventSerializer do
  subject(:serialized) { described_class.new(event) }

  describe '#past' do
    let(:event) { create(:event, start_at: 1.hour.ago) }

    subject { serialized.past }

    it { is_expected.to be_truthy }
  end

  describe '#user' do
    let(:user) { create(:user) }
    let(:reservation) { create(:reservation, user: user) }
    let(:event) { create(:event, :booked, reservation: reservation) }

    subject { serialized.user }

    it 'returns reservation user' do
      expect(subject[:id]).to eq(event.reservation.user.id)
    end

    context 'when event is free' do
      let(:event) { create(:event, :free) }

      it { is_expected.to be_nil }
    end

    context 'when event have reservation without user' do
      let(:reservation) { create(:reservation) }

      it { is_expected.to be_nil }
    end
  end
end
