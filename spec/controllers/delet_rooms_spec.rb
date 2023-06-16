require 'rails_helper'

RSpec.describe RoomsController, type: :controller do
  describe 'DELETE #destroy' do
    let!(:room) { Room.create(name: 'Soba 1', icon: 'icon.png', description: 'Ovo je opis sobe 1', cost_per_day: 100.0) }
    let!(:reservation) { Reservation.create(room_id: room.id, start_date: Date.today, end_date: Date.today + 1.week) }

    it 'destroys the room and associated reservations' do
      expect do
        delete :destroy, params: { id: room.id }
      end.to change(Room, :count).by(-1)

      expect(Reservation.where(room_id: room.id)).to be_empty
    end

    it 'returns a successful response' do
      delete :destroy, params: { id: room.id }
      expect(response).to have_http_status(:no_content)
    end
  end
end
