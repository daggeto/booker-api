class DummyApiController < Api::BaseController
end

describe DummyApiController do
  let(:request) { double(headers: {}, parameters: {}, env: {}) }

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
end
