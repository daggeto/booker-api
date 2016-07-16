describe Event::Book do
  let(:user) { create(:user) }
  let(:event) { create(:event) }

  subject(:interactor) { described_class.new(event, user) }

  describe '#run' do
    subject { interactor.run }

    it_behaves_like 'status changer' do
      let(:status) { Event::Status::PENDING }
    end

    it { has.to change { event.user }.to(user) }
  end
end
