describe Api::V1::UsersController do
  describe '#show' do
    let(:user) { create(:user) }
    let(:params) { { id: user.id} }

    subject do
      get :show, params

      json
    end

    its(['id']) { is_expected.to eq(user.id) }
    its(['email']) { is_expected.to eq(user.email) }
    its(['first_name']) { is_expected.to eq(user.first_name) }
    its(['last_name']) { is_expected.to eq(user.last_name) }
  end

  describe '#current' do
    subject { get :current }

    it_behaves_like 'success response'

    it 'returns guest user' do
      subject

      expect(json['roles']).to include('guest')
    end

    context 'when user is logged in' do
      let(:user) { create(:user) }

      before { sign_in(user) }

      it 'returns current user' do
        subject

        expect(json['id']).to eq(user.id)
      end
    end
  end

  describe '#edit' do
    let(:user) { create(:user) }
    let(:first_name) { Faker::Name::first_name }
    let(:last_name) { Faker::Name::last_name }
    let(:params) { { first_name: first_name, last_name: last_name } }

    before { sign_in(user) }

    subject { put :update, params }

    it_behaves_like 'success response'

    it 'updates user' do
      expect(User::Update).to receive(:for).with(user, params)

      subject
    end

    it 'responds with user' do
      subject

      expect(json['user']['id']).to eq(user.id)
    end
  end
end
