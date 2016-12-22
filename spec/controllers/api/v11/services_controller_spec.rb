describe Api::V11::ServicesController do
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
