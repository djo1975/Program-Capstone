require 'devise'
require 'rails_helper'

RSpec.describe ReservationsController, type: :controller do
  include Devise::Test::ControllerHelpers

  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
    @user = User.create(id: 1, username: 'user1', email: 'user1@test.com', password: 'password', password_confirmation: 'password', jti: 'user_token')
    @vespa = Vespa.create(id: 1, name: 'vespa1', icon: 'icon.png', description: 'description1', cost_per_day: 100.0)
    request.headers['Authorization'] = @user.jti
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new reservation' do
        post :create, params: { reservation: { user_id: @user.id, vespa_id: @vespa.id, start_date: '2023-01-01', end_date: '2023-01-02', description: 'description2' } }
        expect(Reservation.count).to eq(1)
      end

      it 'returns a successful response' do
        post :create, params: { reservation: { user_id: @user.id, vespa_id: @vespa.id, start_date: '2023-01-01', end_date: '2023-01-02', description: 'description2' } }
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new reservation' do
        post :create, params: { reservation: { user_id: @user.id, vespa_id: '', start_date: '2023-01-01', end_date: '2023-01-02', description: 'description2' } }
        expect(Reservation.count).to eq(0)
      end

      it 'returns an error response' do
        post :create, params: { reservation: { user_id: @user.id, vespa_id: '', start_date: '2023-01-01', end_date: '2023-01-02', description: 'description2' } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'GET #index' do
    before do
      post :create, params: { reservation: { user_id: @user.id, vespa_id: @vespa.id, start_date: '2023-01-01', end_date: '2023-01-02', description: 'description2' } }
      @reservation = Reservation.last
    end

    it 'returns all reservations' do
      get :index
      expect(response.body).to eq([@reservation].to_json)
    end
  end

  describe 'PUT #update' do
    before do
      post :create, params: { reservation: { user_id: @user.id, vespa_id: @vespa.id, start_date: '2023-01-01', end_date: '2023-01-02', description: 'description2' } }
      @reservation = Reservation.last
    end

    it 'updates the reservation' do
      put :update, params: { id: @reservation.id, reservation: { user_id: @user.id, vespa_id: @vespa.id, start_date: '2023-01-01', end_date: '2023-01-02', description: 'description3' } }
      expect(Reservation.last.description).to eq('description3')
    end

    it 'returns a successful response' do
      put :update, params: { id: @reservation.id, reservation: { user_id: @user.id, vespa_id: @vespa.id, start_date: '2023-01-01', end_date: '2023-01-02', description: 'description3' } }
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'DELETE #destroy' do
    before do
      post :create, params: { reservation: { user_id: @user.id, vespa_id: @vespa.id, start_date: '2023-01-01', end_date: '2023-01-02', description: 'description2' } }
      @reservation = Reservation.last
    end

    it 'destroys the reservation' do
      delete :destroy, params: { id: @reservation.id }
      expect(Reservation.count).to eq(0)
    end

    it 'returns a successful response' do
      delete :destroy, params: { id: @reservation.id }
      expect(response).to have_http_status(:ok)
    end
  end
end
