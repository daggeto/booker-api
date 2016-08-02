describe Notifications::CanceledWithoutResponse do
  let(:reservation) { create(:reservation) }

  subject { described_class.for(reservation) }

  it_behaves_like 'notification sender' do
    let(:receiver) { reservation.user }
    let(:notification_params) do
      hash_including(
        title: reservation.event.service.name,
        message: match('canceled')
      )
    end
  end
end
