describe ProfileImageSerializer do
  let(:profile_image) { create(:profile_image) }

  subject(:serialized) { described_class.new(profile_image) }

  describe '#preview_url' do
    subject { serialized.preview_url }

    it { is_expected.to be_present }
  end


end
