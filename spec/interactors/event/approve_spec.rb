describe Event::Approve do
  let(:event) { create(:event) }

  subject(:interactor) { described_class.new(event) }

  describe '#run' do
    subject { interactor.run }

    it_behaves_like 'status changer' do
      let(:status) { Event::Status::BOOKED }
    end
  end
end
