describe Event::WeekAvailability do
  describe '.for' do
    let(:date) { Time.now.beginning_of_day }
    let(:beginning_of_week) { date.beginning_of_week }
    let(:day_number) { beginning_of_week.yday }
    let(:expected_availability) {
      {
        day_number => 0,
        day_number + 1 => 0,
        day_number + 2 => 0,
        day_number + 3 => 0,
        day_number + 4 => 1,
        day_number + 5 => 0,
        day_number + 6 => 0
      }
    }
    let!(:day_one_event) { create(:event, :booked, start_at: beginning_of_week) }
    let!(:day_three_event) { create(:event, :pending, start_at: beginning_of_week + 2.days) }
    let!(:day_five_event) { create(:event, start_at: beginning_of_week + 4.days) }

    subject { described_class.for(date) }

    it { is_expected.to eq(expected_availability) }
  end
end
