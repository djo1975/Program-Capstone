require 'devise'
require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  include Devise::Test::ControllerHelpers

  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
    @user = User.create(id: 1, username: 'user1', email: 'user1@test.com', password: 'password', password_confirmation: 'password', jti: 'user_token')
    @vespa = Vespa.create(id: 1, name: 'vespa1', icon: 'icon.png', description: 'description1', cost_per_day: 100.0)
    @comment = Comment.create(id: 1, user_id: @user.id, vespa_id: @vespa.id, content: 'comment1')
    @like = Like.create(id: 1, user_id: @user.id, comment_id: @comment.id)
    request.headers['Authorization'] = @user.jti
  end

  describe 'GET #index' do
    it 'returns all users' do
      get :index
      expect(response.body).to eq([@user].to_json)
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the user' do
      delete :destroy, params: { id: @user.id }
      expect(User.count).to eq(0)
    end

    it 'returns a successful response' do
      delete :destroy, params: { id: @user.id }
      expect(response).to have_http_status(:no_content)
    end

    it 'destroys all comments by the user' do
      delete :destroy, params: { id: @user.id }
      expect(Comment.count).to eq(0)
    end

    it 'destroys all likes by the user' do
      delete :destroy, params: { id: @user.id }
      expect(Like.count).to eq(0)
    end
  end
end
