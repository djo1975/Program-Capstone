require 'rails_helper'

RSpec.describe PasswordsController, type: :controller do
  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
    @user = User.create(id: 1, username: 'user1', email: 'user1@test.com', password: 'password', password_confirmation: 'password', jti: 'user_token')
    request.headers['Authorization'] = @user.jti
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'sends a password reset email' do
        post :create, params: { user: { email: 'user1@test.com' } }
        expect(response).to have_http_status(:success)
      end
    end

    context 'with invalid parameters' do
      it 'returns an error message' do
        post :create, params: { user: { email: 'wrongemail@test.com' } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid parameters' do
      it 'updates the password' do
        @user.send_reset_password_instructions
        put :update, params: { user: { reset_password_token: @user.reset_password_token, password: 'newpassword', password_confirmation: 'newpassword' } }
        expect(response).to have_http_status(:success)
      end
    end

    context 'with invalid parameters' do
      it 'returns an error message' do
        @user.send_reset_password_instructions
        put :update, params: { user: { reset_password_token: @user.reset_password_token, password: 'newpassword', password_confirmation: 'wrongpassword' } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
