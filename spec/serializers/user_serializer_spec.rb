RSpec.describe UserSerializer do
  subject(:serialized) { described_class.new(user) }

  describe '#unread_count' do
    let!(:user) { build(:user, :guest) }

    subject { serialized.unread_count }

    it { is_expected.to eq(0) }

    context 'when user is logged in' do
      let(:user) { create(:user) }
      let!(:notification) { create(:notification, receiver: user) }

      it { is_expected.to eq(1) }
    end
  end

  describe '#roles' do
    let!(:user) { build(:user, :guest) }

    subject { serialized.roles }

    it { is_expected.to include('guest') }
  end

  describe '#is_guest' do
    let!(:user) { build(:user, :guest) }

    subject { serialized.is_guest }

    it { is_expected.to be_truthy }
  end
end
