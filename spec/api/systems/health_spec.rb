require 'rails_helper'
require 'airborne'

RSpec.describe Weather::Health do
  describe 'api/weather/health' do
    before { get '/api/weather/health' }

    it 'should validate types' do
      expect_status('200')
      expect_json_types(status: :string)
    end

    it 'should validate values' do
      expect_status('200')
      expect_json(status: 'OK')
    end
  end
end
