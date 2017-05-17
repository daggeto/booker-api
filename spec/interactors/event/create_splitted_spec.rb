describe Event::CreateSplitted do
  describe '.for' do
    let(:user) { create(:user) }
    let(:status) { Event::Status::FREE }
    let(:start_at) { Time.parse('2017-01-01 13:00') }
    let(:end_at) { Time.parse('2017-01-01 16:00') }
    let(:split_by) { 1.hour }
    let(:params) do
      { start_at: start_at, end_at: end_at, split_by: split_by, event_params: { status: status } }
    end

    let(:expected_events_ranges) do
      [
        { start_at: Time.parse('2017-01-01 13:00'), end_at: Time.parse('2017-01-01 14:00') },
        { start_at: Time.parse('2017-01-01 14:00'), end_at: Time.parse('2017-01-01 15:00') },
        { start_at: Time.parse('2017-01-01 15:00'), end_at: Time.parse('2017-01-01 16:00') }
      ]
    end

    subject { described_class.for(user, params) }

    it 'creates splitted events' do
      expect_to_create_events

      subject
    end
  end

  private

  def expect_to_create_events
    expected_events_ranges.each do |range|
      hash_including_range = hash_including(
        start_at: range[:start_at],
        end_at: range[:end_at],
        status: status
      )

      expect(Event::Create).to receive(:for).with(user, hash_including_range).ordered
    end
  end
end
