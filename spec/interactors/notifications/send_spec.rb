describe Notifications::Send do
  describe '.for' do
    let(:receivers) { [create(:user)] }
    let(:params) { { message: 'message'} }
    let(:uuid) { '123' }
    let(:response) { double('response', body: { data: { uuid: uuid } }.to_json) }

    subject { described_class.for(receivers, params) }

    before { allow(Ionic::Request).to receive(:post).and_return(response) }

    it 'sends notification' do
      expect(Ionic::Request).to receive(:post)

      expect(subject).to eq(uuid)
    end
  end
end
