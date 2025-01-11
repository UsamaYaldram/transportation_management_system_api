require 'rails_helper'

RSpec.describe TrucksController, type: :controller do
  let(:driver) { create(:driver) }
  let(:token) { JwtService.encode(driver_id: driver.id) }
  let(:headers) { { 'Authorization' => "Bearer #{token}" } }

  before { request.headers.merge!(headers) }

  describe 'GET #index' do
    let!(:trucks) { create_list(:truck, 3) }

    it 'returns a list of trucks' do
      get :index
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['data'].size).to eq(trucks.size)
    end
  end

  describe 'POST #assign' do
    let(:truck) { create(:truck) }

    context 'when the truck exists' do
      it 'assigns the truck to the driver' do
        expect {
          post :assign, params: { truck_id: truck.id }
        }.to change(driver.trucks, :count).by(1)

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['meta']['message']).to eq('Truck assigned successfully')
      end
    end

    context 'when the truck does not exist' do
      it 'returns a not found error' do
        post :assign, params: { truck_id: -1 }
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['meta']['error']).to eq('Truck not found')
      end
    end
  end

  describe 'GET #assigned' do
    let!(:truck) { create(:truck) }

    before { driver.trucks << truck }

    it 'returns trucks assigned to the current driver' do
      get :assigned
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['data'].size).to eq(1)
    end
  end
end