require 'rails_helper'

RSpec.describe RegistrationsController, type: :controller do
  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new user' do
        post :create, params: { user: { username: 'user1', email: 'user1@test.com', password: 'password', password_confirmation: 'password' } }
        @user = User.last
        expect(User.count).to eq(1)
      end

      it 'returns a successful response' do
        post :create, params: { user: { username: 'user1', email: 'user1@test.com', password: 'password', password_confirmation: 'password' } }
        expect(response.status).to eq(200)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new user' do
        post :create, params: { user: { username: 'user1', email: '', password: 'password', password_confirmation: 'password' } }
        expect(User.count).to eq(0)
      end

      it 'returns an error response' do
        post :create, params: { user: { username: 'user1', email: '', password: 'password', password_confirmation: 'password' } }
        expect(response.status).to eq(422)
      end
    end
  end
end
