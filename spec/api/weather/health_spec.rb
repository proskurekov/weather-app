require 'rails_helper'

RSpec.describe Weather::Health do
  before { get '/api/weather/health' }

  it 'returns http status success' do
    expect(response).to have_http_status(:success)
  end

  it 'returns status OK' do
    expect(Oj.load(response.body)).to eq({ 'status' => 'OK' })
  end
end
