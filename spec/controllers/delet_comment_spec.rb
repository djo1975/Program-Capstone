require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user) { User.create(username: 'john_doe') }
  let(:room) { Room.create(name: 'Soba 1', icon: 'icon.png', description: 'Ovo je opis sobe 1', cost_per_day: 100.0) }
  let!(:comment) { Comment.create(content: 'Ovo je komentar', user_id: user.id, room_id: room.id) }
  let!(:like) { Like.create(user_id: user.id, comment_id: comment.id) }

  before do
    @controller = CommentsController.new
  end

  describe 'DELETE #destroy' do
    it 'destroys the comment with associated likes' do
      expect do
        delete :destroy, params: { id: comment.id }
      end.to change(Comment, :count).by(-1)

      expect(Like.where(comment_id: comment.id)).to be_empty
    end

    it 'returns a successful response' do
      delete :destroy, params: { id: comment.id }
      expect(response).to have_http_status(:no_content)
    end
  end
end
