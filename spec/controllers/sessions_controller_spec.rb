require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
    before do
        @request.env['devise.mapping'] = Devise.mappings[:user]
        @user = User.create(id: 1, username: 'user1', email: 'user1@test.com', password: 'password', password_confirmation: 'password', jti: 'user_token')
    end

    describe 'POST #create' do
        context 'with valid parameters' do
            it 'signs a user in successfully' do
                post :create, params: { user: { email: 'user1@test.com', password: 'password' } }
                expect(response.status).to eq(200)
            end
        end

        context 'with invalid parameters' do
            it 'does not sign a user in' do
                post :create, params: { user: { email: 'user1@test.com', password: 'wrong_password' } }
                expect(response.status).to eq(422)
            end
        end
    end

    describe 'DELETE #destroy' do
        it 'signs a user out successfully' do
            sign_in @user
            delete :destroy
            expect(response.status).to eq(200)
        end
    end
end
