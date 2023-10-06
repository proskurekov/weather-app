require 'rails_helper'

RSpec.describe Weather::Historical do
  let(:data) { Oj.load file_fixture('weather_data.json').read }

  before do
    mock_request!(/accuweather/, data.to_json)
  end

  describe '/' do
    before { get '/api/weather/historical' }

    it 'returns http status success' do
      expect(response).to have_http_status(:success)
    end

    context 'when service return correct response' do
      it 'returns a non-empty array' do
        expect(Oj.load(response.body)).to be_instance_of(Array).and be_present
      end
    end

    context 'when service return incorrect response' do
      before do
        mock_request!(/accuweather/, nil)
        get '/api/weather/historical'
      end

      it 'returns empty array' do
        expect(Oj.load(response.body)).to be_instance_of(Array).and be_empty
      end
    end
  end

  describe '#min' do
    before { get '/api/weather/historical/min' }

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
        get '/api/weather/historical/min'
      end

      it 'returns empty array' do
        expect(Oj.load(response.body)).to be_instance_of(Hash).and be_empty
      end
    end
  end

  describe '#max' do
    before { get '/api/weather/historical/max' }

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
        get '/api/weather/historical/max'
      end

      it 'returns empty array' do
        expect(Oj.load(response.body)).to be_instance_of(Hash).and be_empty
      end
    end
  end

  describe '#avg' do
    before { get '/api/weather/historical/avg' }

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
        get '/api/weather/historical/avg'
      end

      it 'returns empty array' do
        expect(Oj.load(response.body)).to be_instance_of(Hash).and be_empty
      end
    end
  end
end
