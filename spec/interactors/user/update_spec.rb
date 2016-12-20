describe User::Update do
  describe '.for' do
    let(:user) { create(:user) }
    let(:first_name) { Faker::Name::first_name }
    let(:last_name) { Faker::Name::last_name }
    let(:params) { { first_name: first_name, last_name: last_name } }

    subject { described_class.for(user, params) }

    it { has.to change { user.first_name } }
    it { has.to change { user.last_name } }
  end
end
