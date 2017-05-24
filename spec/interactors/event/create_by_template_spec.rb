describe Event::CreateByTemplate do
  let(:user) { create(:user, :with_service) }
  let(:from) { '2017-01-01' }
  let(:to) { '2017-01-08' }
  let(:exclude_days) { nil }
  let(:template) do
    [
      { start_at: '11:00', end_at: '11:30' },
      { start_at: '11:30', end_at: '12:00' },
    ]
  end

  let(:params) do
    {
      user: user,
      template: template,
      from: from,
      to: to,
      exclude_days: exclude_days
    }
  end

  before { allow(Event::Validate).to receive(:for).and_return({ valid: true } ) }

  subject { described_class.new(params).run }

  it 'creates splitted events for given date range' do
    expect(Event::Create).to receive(:for).exactly(14).times

    subject
  end

  context 'when validation fails' do
    let(:from) { '2017-01-01' }
    let(:to) { '2017-01-02' }
    let(:template) do
      [
        { start_at: '11:00', end_at: '11:30' },
        { start_at: '11:30', end_at: '12:00' },
        { start_at: '12:30', end_at: '13:00' }
      ]
    end

    before do
      allow(Event::Validate).to receive(:for).and_return(
        { valid: true }, { valid: false }, { valid: true }
      )
    end

    it 'skips creation of invalid event' do
      expect(Event::Create).to receive(:for).twice

      subject
    end
  end

  context 'when weekend is excluded' do
    let(:exclude_days) { Event::CreateByTemplate::DAYS::WEEKEND }

    it 'does not create events for weekend' do
      expect(Event::Create).to receive(:for).exactly(10).times

      subject
    end
  end
end
