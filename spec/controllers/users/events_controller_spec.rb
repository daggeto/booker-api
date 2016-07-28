describe Api::V1::Users::EventsController do
  let(:user) { create(:user) }

  before { sign_in(user) }

  describe '#index' do
    let(:params) { { user_id: user.id } }

    let(:start_at) { Time.now + 1.minute }
    let!(:old_event) { create(:event, user: user, start_at: start_at - 1.hour) }
    let!(:today_event) { create(:event, user: user, start_at: start_at) }
    let!(:tomorrow_event) { create(:event, user: user, start_at: start_at + 1.day) }


    subject { get :index, params }

    it_behaves_like 'success response'

    it 'returns all user events' do
      subject

      expect(json['events'].size).to be(2)
    end

    context 'when grouped param passed' do
      let(:params) { { user_id: user.id, group: true } }
      let(:formatted_date) { start_at.strftime(Api::V1::Users::EventsController::DATE_FORMAT) }

      it 'return events grouped by start at' do
        subject

        expect(json['events'][formatted_date]).to include(hash_including('id' => today_event.id))
      end
    end
  end
end
