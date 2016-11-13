describe Api::V1::UsersController do
  let(:user) { create(:user) }

  before { sign_in(user) }

  describe '#current' do
    subject { get :current }

    it_behaves_like 'success response'
  end
end
