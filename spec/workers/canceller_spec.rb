describe Canceller do
  let(:user) { create(:user) }
  let(:current_date) { Time.now }
  let(:reservation) { create(:reservation, created_at: current_date - Canceller::CANCEL_PERIOD) }
  let(:new_reservation) do
    create(:reservation, created_at: current_date - 30.minutes)
  end
  let!(:event) { create(:event, :pending, reservation: reservation) }
  let!(:new_event) { create(:event, :pending, reservation: new_reservation) }

  subject { described_class.new.perform }

  before do
    allow(Reservation::CancelPending).to receive(:for)
    allow(Time).to receive(:now).and_return(current_date)
  end

  it 'cancels reservation' do
    expect(Reservation::CancelPending).to receive(:for).with(reservation).once

    subject
  end
end
