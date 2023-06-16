require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'DELETE #destroy' do
    let(:user) { User.create(username: 'john_doe') }
    let(:room) { Room.create(name: 'Room 1', icon: 'icon.png', cost_per_day: 100, description: 'Ovo je opis sobe 1') }
    let!(:reservation) { Reservation.create(user:, room:, start_date: Date.today, end_date: Date.today + 1, description: 'Moja rezervacija') }
    let!(:comment) { Comment.create(user:, room:, content: 'Ovo je komentar') }
    let!(:like) { Like.create(user:, comment:) }

    it 'destroys the user and associated objects' do
      expect do
        delete :destroy, params: { id: user.id }
      end.to change(User, :count).by(-1)

      expect(Reservation.count).to eq(0)
      expect(Comment.count).to eq(0)
      expect(Like.count).to eq(0)
    end

    it 'returns a successful response' do
      delete :destroy, params: { id: user.id }
      expect(response).to have_http_status(:no_content)
    end
  end
end
