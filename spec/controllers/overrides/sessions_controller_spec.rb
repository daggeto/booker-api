describe Overrides::SessionsController, scope: :devise do
  let(:device_token) { device.token }
  let!(:device) { create(:device) }

  before do
    request.env['devise.mapping'] = Devise.mappings[:user]

    request.headers[DeviceHelper::DEVICE_TOKEN_KEY] = device_token
  end

  describe '#create' do
    let(:password) { '123123123' }
    let(:user) { create(:user, password: password) }
    let(:params) { { email: user.email, password: password } }

    subject { post :create, params }

    before do
      allow(GoogleAnalytics::Event::Send).to receive(:for)

      allow(Device::AssignUser).to receive(:for)
    end

    it 'Send login event to GA' do
      expect(GoogleAnalytics::Event::Send).to receive(:for).with(
        GoogleAnalytics::Events::LOGIN.merge(
          user_id: user.id,
          label: user.email
        )
      )

      subject
    end

    it 'assigns current user to current device' do
      expect(Device::AssignUser).to receive(:for).with(device, user)

      subject
    end

    context 'when device token is not passed' do
      let(:device_token) { nil }

      it 'does not assign current user to device' do
        expect(Device::AssignUser).not_to receive(:for)

        subject
      end
    end
  end

  describe '#destroy' do
    subject { delete :destroy }

    before { allow(Device::UnassignUser).to receive(:for) }

    it 'unassigns current user from current device' do
      expect(Device::UnassignUser).to receive(:for).with(device)

      subject
    end

    context 'when device token is not passed' do
      let(:device_token) { nil }
      let(:user) { create(:user) }
      let!(:device) { create(:device, user: user) }

      before { sign_in(user) }

      xit { has.to change { Device.count }.to(0) }

      xit 'does not call unassign' do
        expect(Device::UnassignUser).not_to receive(:for)

        subject
      end
    end
  end
end
