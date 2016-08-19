describe ReservationPersonalizer do
  let(:reservation) { create(:full_reservation) }
  let(:reservation_dto) { ReservationSerializer.new(reservation).as_json }

  subject { described_class.for(reservation_dto) }

  it 'personalizes reservation' do
    expect(subject).to include(:service_photo_url, :event)
  end
end
