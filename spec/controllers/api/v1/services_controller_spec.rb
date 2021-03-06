describe Api::V1::ServicesController do
  let(:user) { create(:user) }

  shared_examples 'owner authorizer' do
    context 'when user is not owner' do
      let(:other_user) { create(:user) }
      let(:service) { create(:service, user: other_user) }

      it_behaves_like 'forbidden response'
    end
  end

  describe '#index' do
    let(:service) { create(:service, published: true) }
    let(:params) { { page: 1, per_page: 1 } }
    let!(:event) { create(:event, service: service) }

    subject { get :index, params }

    it 'returns services' do
      subject

      expect(json['services']).to contain_exactly(hash_including('id' => service.id))
    end

    context 'when more exists' do
      let(:next_page_service) { create(:service, published: true) }
      let!(:other_event) { create(:event, service: next_page_service) }

      it 'returns services' do
        subject

        expect(json['more']).to be_truthy
      end
    end
  end

  describe '#search' do
    let(:term) { 'service' }
    let(:name) { 'Your Service' }
    let!(:service) { create(:service, name: name, published: true) }

    before { allow(GoogleAnalytics::Event::Send).to receive(:for) }

    subject { get :search, term: term }

    it_behaves_like 'success response'

    it 'returns services' do
      expect(GoogleAnalytics::Event::Send).to receive(:for)

      subject

      expect(json['services']).to contain_exactly(hash_including('id' => service.id))
    end
  end

  describe '#show_selected' do
    let(:service) { create(:service) }
    let(:service_id) { service.id.to_s }
    let(:ids) { [service_id] }
    let(:nearest) { { service_id => build(:event) } }

    subject { get :show_selected, ids: ids }

    it_behaves_like 'success response'

    before { expect(Event::Nearest).to receive(:for).with(ids).and_return(nearest) }

    it 'return events by services ids' do
      subject

      expect(json['services'][service_id]['nearest_event']).to be_present
    end
  end

  describe '#show' do
    let(:service) { create(:service) }

    subject do
      get :show, id: service.id

      json
    end

    its(['id']) { is_expected.to eq(service.id) }
  end

  describe '#publish' do
    let(:check_result) { { valid: true } }
    let(:service) { create(:service, user: user) }

    subject { post :publish, service_id: service.id }

    before do
      sign_in(user)

      allow(Service::CheckPublication).to receive(:for).with(service).and_return(check_result)

      allow(Service::Publish).to receive(:for)
    end

    it_behaves_like 'success response'
    it_behaves_like 'owner authorizer'

    it 'publishes service' do
      expect(Service::Publish).to receive(:for)

      subject
    end

    context 'when conflict occurs' do
      let(:check_result) { { valid: false } }

      it_behaves_like 'conflict response'
    end
  end

  describe '#unpublish' do
    let(:service) { create(:service, user: user) }

    subject { post :unpublish, service_id: service.id }

    before do
      sign_in(user)

      allow(Service::Unpublish).to receive(:for)
    end

    it_behaves_like 'success response'
    it_behaves_like 'owner authorizer'

    it 'unpublishes service' do
      expect(Service::Unpublish).to receive(:for)

      subject
    end
  end
end
