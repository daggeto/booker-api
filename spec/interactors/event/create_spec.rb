describe Event::Create do
  describe '.for' do
    let(:status) { Event::Status::FREE }
    let(:params) { { status: status } }

    subject { described_class.for(params) }

    it { has.to change { Event.count }.by(1) }
    it { has.to change { Reservation.count }.by(0) }

    context 'when status is not free' do
      let(:status) { Event::Status::PENDING }

      it { has.to change { Reservation.count}.by(1) }
    end
  end
end
