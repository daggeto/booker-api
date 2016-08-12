describe Service::CheckPublication do
  describe '.for' do
    let(:events) { [create(:event, status: Event::Status::VISIBLE.sample)] }
    let(:service) { create(:service, published: false, events: events) }

    subject { described_class.for(service) }

    it { is_expected.to eq(valid: true) }

    context 'when service has no visible events' do
      let(:events) { [create(:event, status: Event::Status::BOOKED)] }

      it 'returns errors' do
        expect(subject)
          .to eq(valid: false, errors: [Service::CheckPublication::NO_VISIBLE_EVENTS])
      end
    end
  end
end
