describe Event::Delete do
  describe '.for' do
    subject { described_class.for(event) }

    shared_examples 'event destroyer' do
      it { has.to change(Event, :count).to(0) }
    end

    before do
      allow(Notifications::ReservationCanceledByService).to receive(:for)
    end

    context 'when event is free' do
      let!(:event) { create(:event) }

      it_behaves_like 'event destroyer'

      it 'dont reminds about cancellation' do
        expect(Notifications::ReservationCanceledByService).not_to receive(:for)

        subject
      end
    end

    context 'when event is booked' do
      let!(:event) { create(:event, :booked) }

      it_behaves_like 'event destroyer'

      it 'reminds about cancellation' do
        expect(Notifications::ReservationCanceledByService)
          .to receive(:for).with(event.reservation)

        subject
      end
    end
  end
end
