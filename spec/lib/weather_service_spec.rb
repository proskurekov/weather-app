require 'rails_helper'

class WeatherServiceMock; end

RSpec.describe WeatherService do
  include WeatherService

  let(:data) { Oj.load file_fixture('weather_data.json').read }

  let(:weather_service) { mock_class.extend(WeatherService) }
  let(:mock_class) { WeatherServiceMock.new }

  before do
    mock_request!(/accuweather/, data.to_json)
  end

  describe WeatherService::ResponseHelper do
    let(:helper) { mock_class.extend(WeatherService::ResponseHelper) }

    context 'when returns valid response' do
      it { expect(helper.valid_json?(data.to_json)).to be_truthy }
    end

    context 'when returns invalid response' do
      it { expect(helper.valid_json?(nil)).to be_falsey }
      it { expect(helper.valid_json?({})).to be_falsey }
    end
  end

  describe '#current_weather' do
    context 'when valid response' do
      it 'returns parsed response' do
        expect(weather_service.current_weather).to be_instance_of(Array).and be_present
      end
    end

    context 'when response invalid' do
      let(:data) { [] }

      it 'returns parsed response' do
        expect(weather_service.current_weather).to be_instance_of(Array).and be_empty
      end
    end
  end

  describe '#historical_weather' do
    context 'when valid response' do
      it 'returns parsed response' do
        expect(weather_service.historical_weather).to be_instance_of(Array).and be_present
      end
    end

    context 'when response invalid' do
      let(:data) { [] }

      it 'returns parsed response' do
        expect(weather_service.historical_weather).to be_instance_of(Array).and be_empty
      end
    end
  end
end
