require 'rails_helper'

RSpec.describe VespasController, type: :controller do
  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_params) do
        {
          vespa: {
            name: 'Soba 1',
            icon: 'icon.png',
            description: 'Ovo je opis sobe 1',
            cost_per_day: 100.0
          }
        }
      end

      it 'creates a new vespa' do
        expect do
          post :create, params: valid_params
        end.to change(Vespa, :count).by(1)
      end

      it 'returns a successful response' do
        post :create, params: valid_params
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) do
        {
          vespa: {
            name: '',
            icon: 'icon.png',
            description: 'Ovo je opis sobe 1',
            cost_per_day: 100.0
          }
        }
      end

      it 'does not create a new vespa' do
        expect do
          post :create, params: invalid_params
        end.not_to change(Vespa, :count)
      end

      it 'returns an error response' do
        post :create, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:vespa) { Vespa.create(name: 'Soba 1', icon: 'icon.png', description: 'Ovo je opis sobe 1', cost_per_day: 100.0) }

    it 'destroys the vespa' do
      expect do
        delete :destroy, params: { id: vespa.id }
      end.to change(Vespa, :count).by(-1)
    end

    it 'returns a successful response' do
      delete :destroy, params: { id: vespa.id }
      expect(response).to have_http_status(:no_content)
    end
  end
end
