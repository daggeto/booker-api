describe Event::Update do
  describe '.for' do
    let(:event) { create(:event) }
    let(:description) { 'Description' }
    let(:params) { { description: description } }

    subject { described_class.for(event, params) }

    it { has.to change { event.description } }

    context 'when status is changed from free to booked' do
      let(:params) { { status: Event::Status::PENDING } }

      it { has.to change { Reservation.count }.by(1) }
    end
  end
end
