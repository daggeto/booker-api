describe ServicesSearch do
  let(:service_options) { {} }
  let(:non_matching_service_options) { {} }
  let(:search_options) { {} }
  let!(:service) { create(:service, service_options) }
  let!(:non_matching_service) { create(:service, non_matching_service_options) }

  subject { described_class.new(search_options).results }

  shared_examples 'service finder' do
    it 'finds service' do
      expect(subject.ids).to contain_exactly(service.id)
    end
  end

  describe '#published' do
    let(:service_options) { { published: true } }
    let(:non_matching_service_options) { { published: false } }
    let(:search_options) { { published: true} }

    it_behaves_like 'service finder'
  end

  describe '#with_future_events' do
    let(:search_options) { { with_future_events: true } }
    let!(:event) { create(:event, start_at: Time.zone.now + 1.hour, service: service) }

    it_behaves_like 'service finder'
  end

  describe '#search_events_status' do
    let(:search_options) { { events_status: [Event::Status::FREE, Event::Status::PENDING] } }
    let!(:event) { create(:event, status: Event::Status::FREE, service: service) }
    let!(:non_matching_event) do
      create(:event, status: Event::Status::BOOKED, service: non_matching_service)
    end

    it_behaves_like 'service finder'
  end

  describe '#search_without_user' do
    let(:user) { create(:user) }
    let(:non_matching_user) { create(:user) }
    let(:service_options) { { user: user } }
    let(:non_matching_service_options) { { user: non_matching_user } }
    let(:search_options) { { without_user: non_matching_user} }

    it_behaves_like 'service finder'
  end
end
