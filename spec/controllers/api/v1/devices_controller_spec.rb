describe Api::V1::DevicesController do
  describe '#create' do
    let(:params) { { token: 'token', platform: 'ios' } }

    subject { post :create, params }

    it { has.to change { Device.where(params).count }.to(1) }
  end
end
