describe Event::Disapprove do
  let!(:event) { create(:event, :booked) }

  subject(:interactor) { described_class.new(event) }

  describe '#run' do
    subject { interactor.run }

    it_behaves_like 'status changer' do
      let(:status) { Event::Status::FREE }
    end

    it { has.to change { event.user }.to(nil) }
  end
end
