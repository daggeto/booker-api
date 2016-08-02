describe ReservationReminder do
  let(:user) { create(:user) }
  let(:current_date) { Time.now }
  let!(:event) do
    create(
      :event,
      user: user,
      start_at: current_date + ReservationReminder::REMINDER_THRESHOLD,
      status: Event::Status::BOOKED
    )
  end

  subject { described_class.new.perform }

  before do
    # create(:event, start_at: current_date + 3.hours, user: user, status: Event::Status::PENDING)
    # create(:event, start_at: current_date - 1.minute, status: Event::Status::BOOKED)
    # create(:event, start_at: current_date + 1.hours, status: Event::Status::FREE)
    # create(
    #   :event,
    #   start_at: current_date + ReservationReminder::REMINDER_THRESHOLD,
    #   status: Event::Status::FREE
    # )


    allow(Event::Remind).to receive(:for)
  end

  it 'sends event reminders' do
    expect(Event::Remind).to receive(:for).once

    subject
  end
end
