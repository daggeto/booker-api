describe ServicePersonalizer do
  describe '.for' do
    let(:event) { create(:event, start_at: Event::VISIBLE_FROM_TIME.since + 1.minute) }
    let(:service) { create(:service, events: [event] )}
    let(:service_dto) { ServiceSerializer.new(service).as_json }

    subject { described_class.for(service_dto) }

    it 'serializes service' do
      expect(subject[:nearest_event][:id]).to eq(event.id)
    end
  end
end
