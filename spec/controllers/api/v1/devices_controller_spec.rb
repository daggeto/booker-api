describe Api::V1::DevicesController do
  describe '#create' do
    let(:token) { 'token' }
    let(:platform) { 'ios' }
    let(:params) { { token: 'token', platform: 'ios' } }

    subject { post :create, params }

    it { has.to change { Device.where(params).count }.to(1) }

    context 'when user is logged in' do
      let(:user) { create(:user) }
      let(:device_params) { params.merge(user_id: user.id) }

      before { sign_in(user) }

      it { has.to change { Device.where(device_params).to(1) } }
    end
  end
end
