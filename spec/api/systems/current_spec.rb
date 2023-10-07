require 'rails_helper'
require 'airborne'

RSpec.describe Weather::Current do
  let(:data) { Oj.load file_fixture('weather_data.json').read }

  describe 'api/weather/current' do
    before do
      mock_request!(/accuweather/, data.to_json)
      get '/api/weather/current'
    end

    context 'when valid response' do
      it 'should validate types' do
        expect_status('200')
        expect_json_types(temperature: :object)
        expect_json_types('temperature', Value: :float, Unit: :string, UnitType: :integer)
        expect_json_keys('temperature', %i[Value Unit UnitType])
      end
    end

    context 'when invalid response' do
      before do
        mock_request!(/accuweather/, nil)
        get '/api/weather/current'
      end

      it 'return empty hash' do
        expect_status('200')
        expect(json_body).to be_instance_of(Hash).and be_empty
      end
    end
  end
end
