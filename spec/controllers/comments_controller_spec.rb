require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  describe 'POST #create' do
    let(:user) { User.create(username: 'john_doe') }
    let(:room) { Room.create(name: 'Soba 1', icon: 'icon.png', description: 'Ovo je opis sobe 1', cost_per_day: 100.0) }

    context 'with valid parameters' do
      it 'creates a new comment' do
        post :create, params: { comment: { content: 'Ovo je komentar', user_id: user.id, room_id: room.id } }
        expect(Comment.count).to eq(1)
      end

      it 'returns a successful response' do
        post :create, params: { comment: { content: 'Ovo je komentar', user_id: user.id, room_id: room.id } }
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new comment' do
        post :create, params: { comment: { content: '', user_id: user.id, room_id: room.id } }
        expect(Comment.count).to eq(0)
      end

      it 'returns an error response' do
        post :create, params: { comment: { content: '', user_id: user.id, room_id: room.id } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:user) { User.create(username: 'john_doe') }
    let(:room) { Room.create(name: 'Soba 1', icon: 'icon.png', description: 'Ovo je opis sobe 1', cost_per_day: 100.0) }
    let!(:comment) { Comment.create(content: 'Ovo je komentar', user_id: user.id, room_id: room.id) }

    it 'destroys the comment' do
      expect do
        delete :destroy, params: { id: comment.id }
      end.to change(Comment, :count).by(-1)
    end

    it 'returns a successful response' do
      delete :destroy, params: { id: comment.id }
      expect(response).to have_http_status(:no_content)
    end
  end
end
