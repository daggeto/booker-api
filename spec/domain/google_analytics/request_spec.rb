describe GoogleAnalytics::Request do
  describe '.post' do
    let(:api_url) { 'https://www.google-analytics.com/collect' }
    let(:version) { 1 }
    let(:ga_id) { 'UA-123' }
    let(:params) { { user_id: 123 } }
    let(:default_params) { { v: version, tid: ga_id } }

    subject { described_class.post(params) }

    it 'Send request to GoogleAnalytics' do
      stub_const('GA_ID', ga_id)
      
      expect(RestClient).to receive(:post).with(api_url, default_params.merge(params))

      subject
    end
  end
end
