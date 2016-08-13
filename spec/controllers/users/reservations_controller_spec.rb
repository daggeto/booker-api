RSpec.describe Api::V1::Users::ReservationsController do
  let(:user) { create(:user) }

  before { sign_in(user) }

  describe '#index' do
    let(:params) { { user_id: user.id } }

    let(:start_at) { Time.now + 1.minute }

    let(:old_event) { create(:event, start_at: start_at - 1.hour) }
    let(:today_event) { create(:event, :with_service, start_at: start_at) }
    let(:tomorrow_event) { create(:event, :with_service, start_at: start_at + 1.day) }

    let!(:old_reservation) { create(:reservation, user: user, event: old_event) }
    let!(:today_reservation) { create(:reservation, user: user , event: today_event) }
    let!(:tomorrow_reservation) { create(:reservation, user: user , event: tomorrow_event) }

    subject { get :index, params }

    it_behaves_like 'success response'

    it 'returns all user reservations' do
      subject

      expect(json['reservations'].size).to be(2)
    end

    context 'when grouped param passed' do
      let(:params) { { user_id: user.id, group: true } }
      let(:formatted_date) do
        start_at.strftime(Api::V1::Users::ReservationsController::DATE_FORMAT)
      end

      it 'return reservations grouped by start at' do
        subject

        expect(json['reservations'][formatted_date])
          .to include(hash_including('id' => today_reservation.id))
      end
    end
  end
end
