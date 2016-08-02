describe ReservationReminder do
  let(:user) { create(:user) }
  let(:current_date) { Time.now }

  let(:canceled_reservation) { create(:reservation, canceled_at: 1.hour.ago)}

  let!(:future_pending_event) { create(:event, :pending, start_at: current_date + 3.hours) }
  let!(:past_booked_event) { create(:event, :booked, start_at: current_date - 1.minute) }
  let!(:future_free_event) { create(:event, :free, start_at: current_date + 1.hours) }
  let!(:remindable_free_event) do
    create(:event, :free, start_at: current_date + ReservationReminder::REMINDER_THRESHOLD)
  end
  let!(:canceled_event) do
    create(
      :event,
      :free,
      reservation: canceled_reservation,
      start_at: current_date + ReservationReminder::REMINDER_THRESHOLD)
  end
  let!(:correct_event) do
    create(:event, :booked, start_at: current_date + ReservationReminder::REMINDER_THRESHOLD)
  end

  subject { described_class.new.perform }

  before do
    allow(Reservation::Remind).to receive(:for)
    allow(Time).to receive(:now).and_return(current_date)
  end

  it 'sends event reminders' do
    expect(Reservation::Remind).to receive(:for).once

    subject
  end
end
