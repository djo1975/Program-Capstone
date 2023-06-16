RSpec.describe ReservationsController, type: :controller do
  let(:user) { User.create(username: 'John Doe') }
  let(:room) { Room.create(name: 'Room 1', icon: 'icon.png', cost_per_day: 100, description: 'Ovo je opis sobe 1') }
  let!(:reservation) { Reservation.create(user_id: user.id, room_id: room.id, start_date: Date.today, end_date: Date.today + 1, description: 'Moja rezervacija') }

  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_params) { { reservation: { user_id: user.id, room_id: room.id, start_date: Date.today, end_date: Date.today + 1, description: 'Moja rezervacija' } } }

      it 'creates a new reservation' do
        expect do
          post :create, params: valid_params
        end.to change(Reservation, :count).by(1)
      end

      it 'returns a successful response' do
        post :create, params: valid_params
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) { { reservation: { user_id: user.id, room_id: room.id } } }

      it 'does not create a new reservation' do
        expect do
          post :create, params: invalid_params
        end.not_to change(Reservation, :count)
      end

      it 'returns an error response' do
        post :create, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
  describe 'DELETE #destroy' do
    it 'destroys the reservation' do
      expect do
        delete :destroy, params: { id: reservation.id }
      end.to change(Reservation, :count).by(-1)
    end

    it 'returns a successful response' do
      delete :destroy, params: { id: reservation.id }
      expect(response).to have_http_status(:no_content)
    end
  end
end
