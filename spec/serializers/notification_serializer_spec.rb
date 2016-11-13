describe NotificationSerializer do
  subject(:serialized) { described_class.new(notification) }

  describe '#unread' do
    let(:user) { create(:user) }
    let(:notification) { create(:notification, receiver: user) }

    subject { serialized.unread }

    before { allow_any_instance_of(Notification).to receive(:unread?).with(user).and_return(true) }

    it { is_expected.to be_truthy }
  end

  describe '#avatar_photo' do
    let(:notification) { create(:notification, sender: sender) }

    subject { serialized.avatar_photo }

    shared_examples 'avatar photo resolver' do
      it 'returns sender photo' do
        expect(subject[:id]).to eq(photo.id)
      end
    end

    context 'when sender is service' do
      let(:photo) { create(:service_photo) }
      let(:sender) { create(:service, service_photos: [photo]) }

      it_behaves_like 'avatar photo resolver'
    end

    context 'when sender is user' do
      let(:photo) { create(:profile_image) }
      let(:sender) { create(:user, profile_image: photo) }

      it_behaves_like 'avatar photo resolver'
    end
  end
end
