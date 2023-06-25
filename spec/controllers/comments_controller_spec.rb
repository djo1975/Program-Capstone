require 'devise'
require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  include Devise::Test::ControllerHelpers

  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
    @user = User.create(id: 1, username: 'user1', email: 'user1@test.com', password: 'password', password_confirmation: 'password', jti: 'user_token')
    @vespa = Vespa.create(id: 1, name: 'vespa1', icon: 'icon.png', description: 'description1', cost_per_day: 100.0)
    request.headers['Authorization'] = @user.jti
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new comment' do
        post :create, params: { comment: { user_id: @user.id, vespa_id: @vespa.id, content: 'comment1' } }
        expect(Comment.count).to eq(1)
      end

      it 'returns a successful response' do
        post :create, params: { comment: { user_id: @user.id, vespa_id: @vespa.id, content: 'comment1' } }
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new comment' do
        post :create, params: { comment: { user_id: @user.id, vespa_id: '', content: 'comment1' } }
        expect(Comment.count).to eq(0)
      end

      it 'returns an error response' do
        post :create, params: { comment: { user_id: @user.id, vespa_id: '', content: 'comment1' } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT #update' do
    before do
      post :create, params: { comment: { user_id: @user.id, vespa_id: @vespa.id, content: 'comment1' } }
      @comment = Comment.last
    end

    it 'updates the comment' do
      put :update, params: { id: @comment.id, comment: { content: 'comment2' } }
      expect(Comment.last.content).to eq('comment2')
    end

    it 'returns a successful response' do
      put :update, params: { id: @comment.id, comment: { content: 'comment2' } }
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'DELETE #destroy' do
    before do
      post :create, params: { comment: { user_id: @user.id, vespa_id: @vespa.id, content: 'comment1' } }
      @comment = Comment.last
    end

    it 'destroys the comment' do
      delete :destroy, params: { id: @comment.id }
      expect(Comment.count).to eq(0)
    end

    it 'returns a successful response' do
      delete :destroy, params: { id: @comment.id }
      expect(response).to have_http_status(:ok)
    end
  end
end
