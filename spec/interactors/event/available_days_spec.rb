describe Event::AvailableDays do
  describe '.for' do
    let(:date) { Time.now.beginning_of_day }
    let(:beginning_of_week) { date.beginning_of_week }
    let(:day_number) { beginning_of_week.yday }
    let(:available_days) do
      {
        day_number => 0,
        day_number + 1 => 0,
        day_number + 2 => 0,
        day_number + 3 => 0,
        day_number + 4 => 1,
        day_number + 5 => 0,
        day_number + 6 => 0
      }
    end
    let(:service) { create(:service) }
    let!(:other_service_event) { create(:event, start_at: beginning_of_week) }
    let!(:day_one_event) { create(:event, :booked, service: service, start_at: beginning_of_week) }
    let!(:day_three_event) do
      create(:event, :pending, service: service, start_at: beginning_of_week + 2.days)
    end
    let!(:day_five_event) do
      create(:event, service: service, start_at: beginning_of_week + 4.days)
    end

    subject { described_class.for(service, date) }

    it { is_expected.to eq(available_days) }
  end
end
