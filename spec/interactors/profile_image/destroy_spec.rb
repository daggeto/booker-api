describe ProfileImage::Destroy do
  describe '.for' do
    let(:profile_image) { create(:profile_image) }
    let(:user) { create(:user, profile_image: profile_image) }

    subject { described_class.for(user) }

    it { has.to change { user.reload.profile_image }.to(nil) }
  end
end
