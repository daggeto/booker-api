class DummyApiController < Api::BaseController
  def set_params(params)
    @dummy_params = params
  end

  def params
    @dummy_params || {}
  end
end

describe DummyApiController do
  let(:headers) { {} }
  let(:request) do
    double(
      headers: headers,
      parameters: {},
      env: {},
      original_fullpath: '',
      method: 'GET'
    )
  end

  subject(:controller) { described_class.new }

  before { allow(controller).to receive(:request).and_return(request) }

  describe '#current_user' do
    subject { controller.current_user }

    context 'when user is logged in' do
      let(:user) { create(:user) }

      before { sign_in(user) }

      it { is_expected.to eq(user) }
      its(:standard?) { is_expected.to be_truthy }
    end
  end

  describe '#track_requests' do
    let(:action) { 'show' }
    let(:params) { { action: action } }

    shared_examples 'ga event sender' do
      let(:user_id) { nil }

      it 'sends GA PageView event' do
        expect(GoogleAnalytics::PageView::Send).to receive(:for)
        .with(hash_including(user_id: user_id))

        subject
      end
    end

    subject { controller.track_requests }

    before { controller.set_params(params) }

    context 'when action is untrackable' do
      let(:action) { Api::BaseController::UNTRACKABLE_REQUESTS.sample }

      it 'not sends GA PageView event' do
        expect(GoogleAnalytics::PageView::Send).not_to receive(:for)

        subject
      end
    end

    context 'when user is not logged in' do
      it_behaves_like 'ga event sender' do
        let(:user_id) { nil }
      end

      context 'when device exists' do
        let(:token) { 'abc' }
        let(:headers) { { DeviceHelper::DEVICE_TOKEN_KEY => token } }
        let(:params) { { action: action } }

        it_behaves_like 'ga event sender' do
          let(:user_id) { token }
        end
      end
    end

    context 'when user is logged in' do
      let(:user) { create(:user) }
      let(:expected_user_id) { user.id }

      before { sign_in(user) }

      it_behaves_like 'ga event sender' do
        let(:user_id) { user.id }
      end
    end
  end

  describe '#current_device' do
    let(:token) { 'abc' }
    let(:headers) { { DeviceHelper::DEVICE_TOKEN_KEY => token } }

    subject { controller.current_device }

    context 'when user not logged in' do
      it { has.to change { Device.where(token: token).count }.to(1) }
    end

    context 'when device exists' do
      let!(:device) { create(:device, token: token) }

      it { has.not_to change(Device, :count) }
      it { is_expected.to eq(device) }
    end

    context 'when no device token passed' do
      let(:headers) { {} }
      let(:token) { 'asd' }
      let!(:device) { create(:device, token: token) }

      it { is_expected.not_to eq(device) }
    end
  end
end
