require 'devise'
require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  include Devise::Test::ControllerHelpers

  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
    @user = User.create(id: 1, username: 'user1', email: 'user1@test.com', password: 'password', password_confirmation: 'password', jti: 'user_token')
    @vespa = Vespa.create(id: 1, name: 'vespa1', icon: 'icon.png', description: 'description1', cost_per_day: 100.0)
    @comment = Comment.create(id: 1, user_id: @user.id, vespa_id: @vespa.id, content: 'comment1')
    request.headers['Authorization'] = @user.jti
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new like' do
        post :create, params: { like: { user_id: @user.id, comment_id: @comment.id } }
        expect(Like.count).to eq(1)
      end

      it 'returns a successful response' do
        post :create, params: { like: { user_id: @user.id, comment_id: @comment.id } }
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new like' do
        post :create, params: { like: { user_id: @user.id, comment_id: nil } }
        expect(Like.count).to eq(0)
      end

      it 'returns an error response' do
        post :create, params: { like: { user_id: @user.id, comment_id: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'GET #index' do
    before do
      post :create, params: { like: { user_id: @user.id, comment_id: @comment.id } }
      @like = Like.last
    end

    it 'returns all the likes' do
      get :index
      expect(assigns(:likes)).to eq([@like])
    end
  end

  describe 'DELETE #destroy' do
    before do
      post :create, params: { like: { user_id: @user.id, comment_id: @comment.id } }
      @like = Like.last
    end

    it 'destroys the like' do
      delete :destroy, params: { id: @like.id }
      expect(Like.count).to eq(0)
    end

    it 'returns a successful response' do
      delete :destroy, params: { id: @like.id }
      expect(response).to have_http_status(:ok)
    end
  end
end
