require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new user' do
        expect do
          post :create, params: { user: { username: 'john_doe' } }
        end.to change(User, :count).by(1)
      end

      it 'returns a successful response' do
        post :create, params: { user: { username: 'john_doe' } }
        expect(response).to be_successful
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new user' do
        expect do
          post :create, params: { user: { username: '' } }
        end.not_to change(User, :count)
      end

      it 'returns an error response' do
        post :create, params: { user: { username: '' } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:user) { User.create(username: 'john_doe') }

    it 'destroys the user' do
      expect do
        delete :destroy, params: { id: user.id }
      end.to change(User, :count).by(-1)
    end

    it 'returns a successful response' do
      delete :destroy, params: { id: user.id }
      expect(response).to have_http_status(:no_content)
    end
  end
end
