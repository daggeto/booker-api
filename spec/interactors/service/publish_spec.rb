describe Service::Publish do
  describe '.for' do
    let(:service) { create(:service, published: false) }

    subject { described_class.for(service) }

    it { has.to change { service.published } }
  end
end
