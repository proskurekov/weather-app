require 'rails_helper'

RSpec.describe Weather::Time do
  describe '#by_time' do
    let(:data) { Oj.load file_fixture('weather_data.json').read }
    let(:params) { { 'timestamp' => '111111111' } }

    before do
      mock_request!(/accuweather/, data.to_json)
    end

    context 'when timestamp is valid' do
      before { get '/api/weather/by_time?timestamp=1111111111' }

      it 'returns http status success' do
        expect(response).to have_http_status(:success)
      end

      it 'returns correct response' do
        expect(Oj.load(response.body)).to be_instance_of(Hash).and be_present
      end
    end

    context 'when timestamp is invalid' do
      before { get '/api/weather/by_time?timestamp=11111' }

      it 'returns http status success' do
        expect(response).to have_http_status(404)
      end

      it 'returns incorrect response' do
        expect(Oj.load(response.body)).to include({ 'error' => 'not_found' })
      end
    end
  end
end

