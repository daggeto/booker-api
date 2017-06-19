describe Overrides::SessionsController, scope: :devise do
  before do
    request.env['devise.mapping'] = Devise.mappings[:user]

    request.headers[DeviceHelper::DEVICE_TOKEN_KEY] = device.token
  end

  describe '#create' do
    let(:password) { '123123123' }
    let(:user) { create(:user, password: password) }
    let(:params) { { email: user.email, password: password } }
    let!(:device) { create(:device) }

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
  end

  describe '#destroy' do
    let!(:device) { create(:device) }

    subject { delete :destroy }

    it 'unassigns current user from current device' do
      expect(Device::UnassignUser).to receive(:for).with(device)

      subject
    end
  end
end
