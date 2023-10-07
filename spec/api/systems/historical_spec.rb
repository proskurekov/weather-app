require 'rails_helper'
require 'airborne'

RSpec.describe Weather::Historical do
  let(:data) { Oj.load file_fixture('weather_data.json').read }

  describe 'api/weather/historical' do
    before do
      mock_request!(/accuweather/, data.to_json)
      get '/api/weather/historical'
    end

    # fix
    context 'when valid response' do
      it 'should validate types' do
        expect_status('200')
        expect(json_body).to be_instance_of(Array).and be_present
      end
    end

    context 'when invalid response' do
      before do
        mock_request!(/accuweather/, nil)
        get '/api/weather/historical'
      end

      it 'return empty hash' do
        expect_status('200')
        expect(json_body).to be_instance_of(Array).and be_empty
      end
    end
  end

  describe 'api/weather/historical/min' do
    before do
      mock_request!(/accuweather/, data.to_json)
      get '/api/weather/historical/min'
    end

    context 'when valid response' do
      it 'should validate types' do
        expect_status('200')
        expect_json_types(date: :string, value: :float)
      end
    end

    context 'when invalid response' do
      before do
        mock_request!(/accuweather/, nil)
        get '/api/weather/historical/min'
      end

      it 'return empty hash' do
        expect_status('200')
        expect(json_body).to be_instance_of(Hash).and be_empty
      end
    end
  end

  describe 'api/weather/historical/max' do
    before do
      mock_request!(/accuweather/, data.to_json)
      get '/api/weather/historical/max'
    end

    context 'when valid response' do
      it 'should validate types' do
        expect_status('200')
        expect_json_types(date: :string, value: :float)
      end
    end

    context 'when invalid response' do
      before do
        mock_request!(/accuweather/, nil)
        get '/api/weather/historical/max'
      end

      it 'return empty hash' do
        expect_status('200')
        expect(json_body).to be_instance_of(Hash).and be_empty
      end
    end
  end

   describe 'api/weather/historical/avg' do
    before do
      mock_request!(/accuweather/, data.to_json)
      get '/api/weather/historical/avg'
    end

    context 'when valid response' do
      it 'should validate types' do
        expect_status('200')
        expect_json_types(value: :float)
      end
    end

    context 'when invalid response' do
      before do
        mock_request!(/accuweather/, nil)
        get '/api/weather/historical/avg'
      end

      it 'return empty hash' do
        expect_status('200')
        expect(json_body).to be_instance_of(Hash).and be_empty
      end
    end
  end
end
