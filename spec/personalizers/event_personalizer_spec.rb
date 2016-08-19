describe EventPersonalizer do
  let(:event) { create(:event, :with_service) }
  let(:event_dto) { EventSerializer.new(event).as_json }

  subject { described_class.for(event_dto) }

  it 'personalizes event' do
    expect(subject).to include(:service_name)
  end
end
