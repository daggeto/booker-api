describe Api::V1::UsersController do
  let(:user) { create(:user) }

  before { sign_in(user) }

  describe '#current' do
    subject { get :current }

    it_behaves_like 'success response'
  end

  describe '#edit' do
    let(:first_name) { Faker::Name::first_name }
    let(:last_name) { Faker::Name::last_name }
    let(:params) { { first_name: first_name, last_name: last_name } }

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
