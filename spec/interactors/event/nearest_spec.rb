describe Event::Nearest do
  describe '.for' do
    let(:event) { create(:event, start_at: Event::VISIBLE_FROM_TIME.since + 1.minute) }
    let(:later_event) { create(:event, start_at: Event::VISIBLE_FROM_TIME.since + 10.minute) }
    let(:service) { create(:service, events: [later_event, event] )}
    let(:ids) { service.id }

    subject { described_class.for(ids) }

    it 'finds nearest event' do
      expect(subject).to eq(event)
    end

    context 'when array of service ids passed' do
      let(:other_event) { create(:event, start_at: Event::VISIBLE_FROM_TIME.since + 10.minutes) }
      let(:other_service) { create(:service, events: [other_event] )}
      let(:ids) { [service.id.to_s, other_service.id] }

      it 'finds nearest events for all services' do
        expect(subject[service.id]).to eq(event)
        expect(subject[other_service.id]).to eq(other_event)
      end
    end
  end
end
