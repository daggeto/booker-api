describe Service::CheckPublication do
  describe '.for' do
    let(:events) { [create(:event, status: Event::Status::VISIBLE.sample)] }
    let(:params) { { published: false, events: events } }
    let(:service) {  create(:service, :with_photos, params) }

    subject { described_class.for(service) }

    it { is_expected.to eq(valid: true) }

    context 'when service has no visible events' do
      let(:events) { [create(:event, status: Event::Status::BOOKED)] }

      it 'returns errors' do
        expect(subject)
          .to eq(valid: false, errors: [Service::CheckPublication::NO_VISIBLE_EVENTS])
      end
    end

    context 'when service has no photos' do
      let(:service) { create(:service, params) }

      it 'returns errors' do
        expect(subject)
          .to eq(valid: false, errors: [Service::CheckPublication::NO_PHOTOS_UPLOADED])
      end
    end
  end
end
