require 'rails_helper'

class WeatherJsonHelperMock; end

RSpec.describe WeatherJsonHelper do
  include WeatherJsonHelper

  let(:data) { Oj.load(file_fixture('weather_data.json').read).first }

  describe WeatherJsonHelper::HashHelper do
    before do
      data.extend(WeatherJsonHelper::HashHelper)
    end

    describe '#statistics' do
      it 'returns statistics' do
        expect(data.statistics).to be_instance_of(Hash)
      end
    end

    describe '#temperature' do
      it 'returns temperature' do
        expect(data.temperature).to include(
          'Value' => be_instance_of(Float),
          'Unit' => be_instance_of(String),
          'UnitType' => be_instance_of(Integer)
        )
      end
    end

    describe '#temperature_value' do
      it 'returns temp value' do
        expect(data.temperature_value).to be_instance_of(Float)
      end
    end

    describe '#timestamp' do
      it 'returns timestamp' do
        expect(data.timestamp).to be_instance_of(Integer)
      end
    end

    describe '#date' do
      it 'return date' do
        expect(data.date).to be_instance_of(String)
      end
    end
  end
end
