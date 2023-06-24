require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  let(:user) { User.create(username: 'john_doe') }
  let(:vespa) { Vespa.create(name: 'Vespa Name', icon: 'icon.png', cost_per_day: 100) }
  let(:comment) { Comment.create(user:, vespa:, content: 'Ovo je komentar', vespa_id: vespa.id) }
  let!(:like) { Like.create(user:, comment:) }

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new like' do
        expect do
          post :create, params: { like: { user_id: user.id, comment_id: comment.id } }
        end.to change(Like, :count).by(1)
      end

      it 'returns a successful response' do
        post :create, params: { like: { user_id: user.id, comment_id: comment.id } }
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new like' do
        expect do
          post :create, params: { like: { user_id: user.id, comment_id: nil } }
        end.not_to change(Like, :count)
      end

      it 'returns an error response' do
        post :create, params: { like: { user_id: user.id, comment_id: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the like' do
      expect do
        delete :destroy, params: { id: like.id }
      end.to change(Like, :count).by(-1)
    end

    it 'returns a successful response' do
      delete :destroy, params: { id: like.id }
      expect(response).to have_http_status(:no_content)
    end
  end
end
