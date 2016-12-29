describe Api::V1::ServicesController do
  let(:user) { create(:user) }

  before { sign_in(user) }

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

  describe '#show_selected' do
    let(:service_one) { create(:service) }
    let(:service_two) { create(:service) }
    let(:ids) { [service_one.id, service_two.id] }

    subject { get :show_selected, ids: ids }

    it_behaves_like 'success response'

    it 'return services by ids' do
      subject

      expect(json['services'][service_one.id.to_s]).to be_present
      expect(json['services'][service_two.id.to_s]).to be_present
      expect(json['services'].size).to eq(2)
    end
  end

  describe '#publish' do
    let(:check_result) { { valid: true } }
    let(:service) { create(:service, user: user) }

    subject { post :publish, service_id: service.id }

    before do
      allow(Service::CheckPublication).to receive(:for).with(service).and_return(check_result)
      allow(Service::Publish).to receive(:for)
    end

    it_behaves_like 'success response'

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

    before { allow(Service::Unpublish).to receive(:for) }

    it_behaves_like 'success response'

    it 'unpublishes service' do
      expect(Service::Unpublish).to receive(:for)

      subject
    end
  end

  describe '#search' do
    let(:term) { 'service' }
    let(:name) { 'Your Service' }
    let!(:service) { create(:service, name: name, published: true) }

    subject { get :search, term: term }

    it_behaves_like 'success response'

    it 'returns services' do
      subject

      expect(json['services']).to contain_exactly(hash_including('id' => service.id))
    end
  end
end
