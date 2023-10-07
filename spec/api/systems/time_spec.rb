require 'rails_helper'
require 'airborne'

RSpec.describe Weather::Time do
  let(:data) { Oj.load file_fixture('weather_data.json').read }

  describe 'api/weather/by_time' do
    before do
      mock_request!(/accuweather/, data.to_json)
      get '/api/weather/by_time?timestamp=1111111111'
    end

    context 'when valid response' do
      it 'should validate types' do
        expect_status('200')
        expect_json_types(timestamp: :object)
      end
    end

    context 'when invalid response' do
      before do
        mock_request!(/accuweather/, nil)
        get '/api/weather/by_time?timestamp=111'
      end

      it 'return 404' do
        expect_status('404')
      end
    end
  end
end
