describe GoogleAnalytics::PageView::Send do
  describe '.for' do
    let(:user_id) { 1 }
    let(:host) { 'www.timespex.com' }
    let(:page) { 'Page' }
    let(:title) { 'Title' }
    let(:params) do
      {
        user_id: user_id,
        host: host,
        page: page,
        title: title
      }
    end
    let(:expected_params) do
      {
        t: GoogleAnalytics::Request::Type::PAGE_VIEW,
        cid: user_id,
        dh: host,
        dp: page,
        dt: title
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
