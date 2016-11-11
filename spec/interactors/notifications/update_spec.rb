describe Notifications::Update do
  describe '.for' do
    let(:notification) { create(:notification) }
    let(:params) { { title: 'new title' } }

    subject { described_class.for(notification, params) }

    it { has.to change { notification.title } }
  end
end
