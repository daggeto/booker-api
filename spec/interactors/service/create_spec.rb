describe Service::Create do
  describe '.for' do
    let(:user) { create(:user) }

    subject { described_class.for(user) }

    it { has.to change { user.service } }
    its(:price) { Service::Create::DEFAULT_PRICE }
    its(:duration) { Event::Duration::MINUTES_15 }
  end
end
