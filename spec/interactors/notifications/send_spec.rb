describe Notifications::Send do
  describe '.for' do
    let(:receivers) { [create(:user)] }
    let(:params) { { message: 'message'} }
    let(:response) { double('response', body: {}) }

    subject { described_class.for(receivers, params) }

    before { allow_any_instance_of(Net::HTTP).to receive(:request).and_return(response) }

    it 'sends notification' do
      expect_any_instance_of(Net::HTTP).to receive(:request)

      subject
    end
  end
end
