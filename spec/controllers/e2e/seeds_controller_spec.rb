describe Api::SeedsController do
  describe '#create' do
    subject { post :create, params }

    shared_examples 'user creator' do
      it { has.to change(User, :count).by(1) }
    end

    context 'when only factory name passed' do
      let(:params) { { 'factories' => ['user']} }

      it_behaves_like 'user creator'
    end

    context 'when factory with params passed' do
      let(:user_id) { 123 }
      let(:params) {
        {
          'factories' => [{
            'user' => {
              'trait' => 'with_service',
              'attributes' => { 'id' => user_id }
            }
          }]
        }
      }

      it_behaves_like 'user creator'

      it { has.to change(Service, :count).by(1) }

      it 'create service' do
        subject

        expect(User.find(user_id)).to be_present
      end

      context 'when trait is not passed' do
        let(:params) {
          {
            'factories' => [{
              'user' => {
                'attributes' => { 'id' => user_id }
              }
            }]
          }
        }

        it_behaves_like 'user creator'
      end
    end
  end
end
