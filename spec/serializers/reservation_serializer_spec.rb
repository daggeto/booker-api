RSpec.describe ReservationSerializer do
  let(:reservation) { create(:reservation) }

  subject(:serialized) { described_class.new(reservation) }

  describe '#as_json' do
    subject { serialized.as_json }

    it 'include serialized fields' do
      expect(subject).to include(:event, :user)
    end
  end
end
