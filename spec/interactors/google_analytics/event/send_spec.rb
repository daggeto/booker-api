describe GoogleAnalytics::Event::Send do
  describe '.for' do
    let(:tracker) { double }
    let(:user_id) { 1 }
    let(:category) { 'Category' }
    let(:action) { 'Action' }
    let(:label) { 'Label' }
    let(:value) { '123' }
    let(:params) do
      {
        user_id: user_id,
        category: category,
        action: action,
        label: label,
        value: value
      }
    end
    let(:expected_params) do
      {
        t: GoogleAnalytics::Request::Type::EVENT,
        cid: user_id,
        ec: category,
        ea: action,
        el: label,
        ev: value
      }
    end

    subject { described_class.for(params) }

    it 'Send event request to GoogleAnalytics' do
      expect(GoogleAnalytics::Request)
        .to receive(:post)
        .with(expected_params)

      subject
    end
  end
end
