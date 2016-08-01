describe Reservation::Create do
  describe '.for' do
    let(:event) { create(:event) }
    let(:user) { create(:user) }

    subject { described_class.for(event, user) }

    it_behaves_like 'event status changer' do
      let(:status) { Event::Status::PENDING }
    end

    it { has.to change(Reservation, :count).by(1) }

    it 'sends notification' do
      expect(Notifications::ConfirmReservation).to receive(:for)

      subject
    end
  end
end
