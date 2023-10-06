require 'rails_helper'

RSpec.describe Weather::Current do
  describe '#current' do
    let(:data) { Oj.load file_fixture('weather_data.json').read }

    before do
      mock_request!(/accuweather/, data.to_json)
      get '/api/weather/current'
    end

    it 'returns http status success' do
      expect(response).to have_http_status(:success)
    end

    context 'when service return correct response' do
      it 'returns a non-empty array' do
        expect(Oj.load(response.body)).to be_instance_of(Hash).and be_present
      end
    end

    context 'when service return incorrect response' do
      before do
        mock_request!(/accuweather/, nil)
        get '/api/weather/current'
      end

      it 'returns empty array' do
        expect(Oj.load(response.body)).to be_instance_of(Hash).and be_empty
      end
    end
  end
end
