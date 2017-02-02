RSpec.describe ServiceSerializer do
  let(:service) { create(:service) }

  subject(:serialized) { described_class.new(service) }

  describe '#main_photo' do
    subject { serialized.main_photo }

    context 'when service has photos' do
      let!(:service_photo_second) { create(:service_photo, service: service, slot: 1) }
      let!(:service_photo_third) { create(:service_photo, service: service, slot: 2) }
      let!(:service_photo_first) { create(:service_photo, service: service, slot: 0) }

      its([:id]) { is_expected.to eq(service_photo_first.id) }
    end

    context 'when service has no photos' do
      its([:preview_url]) { is_expected.to include('http://lorempixel.com')}
    end
  end
end
