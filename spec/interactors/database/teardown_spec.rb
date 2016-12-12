describe Database::Teardown do
  describe '#for' do
    subject { described_class.for }

    before do
      create(:user)
      create(:service)
      create(:event)
      create(:reservation)
    end

    it { has.to change { User.count }.to(0) }
  end
end
