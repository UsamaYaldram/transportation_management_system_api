require 'rails_helper'

RSpec.describe DriversController, type: :controller do
  describe 'POST #create' do
    let(:valid_params) { { email: 'test@example.com', password: 'password' } }
    let(:invalid_params) { { email: '', password: '' } }

    context 'with valid params' do
      it 'creates a new driver' do
        expect {
          post :create, params: { driver: valid_params }
        }.to change(Driver, :count).by(1)

        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['data']['attributes']['email']).to eq('test@example.com')
      end
    end

    context 'with invalid params' do
      it 'returns validation errors' do
        post :create, params: { driver: invalid_params }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['errors']).not_to be_empty
      end
    end
  end

  describe 'POST #login' do
    let(:driver) { create(:driver, password: 'password') }

    context 'with valid credentials' do
      it 'returns a JWT token' do
        post :login, params: { email: driver.email, password: 'password' }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['meta']['token']).not_to be_nil
      end
    end

    context 'with invalid credentials' do
      it 'returns an unauthorized error' do
        post :login, params: { email: driver.email, password: 'wrong_password' }
        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)['errors'].first['detail']).to eq('Invalid email or password')
      end
    end
  end
end
