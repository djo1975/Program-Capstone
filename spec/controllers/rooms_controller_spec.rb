require 'rails_helper'

RSpec.describe RoomsController, type: :controller do
  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_params) do
        {
          room: {
            name: 'Soba 1',
            icon: 'icon.png',
            description: 'Ovo je opis sobe 1',
            cost_per_day: 100.0
          }
        }
      end

      it 'creates a new room' do
        expect do
          post :create, params: valid_params
        end.to change(Room, :count).by(1)
      end

      it 'returns a successful response' do
        post :create, params: valid_params
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) do
        {
          room: {
            name: '',
            icon: 'icon.png',
            description: 'Ovo je opis sobe 1',
            cost_per_day: 100.0
          }
        }
      end

      it 'does not create a new room' do
        expect do
          post :create, params: invalid_params
        end.not_to change(Room, :count)
      end

      it 'returns an error response' do
        post :create, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:room) { Room.create(name: 'Soba 1', icon: 'icon.png', description: 'Ovo je opis sobe 1', cost_per_day: 100.0) }

    it 'destroys the room' do
      expect do
        delete :destroy, params: { id: room.id }
      end.to change(Room, :count).by(-1)
    end

    it 'returns a successful response' do
      delete :destroy, params: { id: room.id }
      expect(response).to have_http_status(:no_content)
    end
  end
end
