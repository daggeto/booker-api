describe Event::Delete do
  let!(:event) { create(:event) }

  subject(:interactor) { described_class.new(event) }

  describe '#run' do
    subject { interactor.run }

    it { has.to change(Event, :count).to(0) }
  end
end
