RSpec.describe UserSerializer do
  subject(:serialized) { described_class.new(user) }

  describe '#unread_count' do
    let(:user) { create(:user) }
    let!(:notification) { create(:notification, receiver: user) }

    subject { serialized.unread_count }

    it { is_expected.to eq(1) }
  end
end
