# frozen_string_literal: true

require 'faraday'
require 'oj'

module WeatherService
  SERVICE_URI = 'http://dataservice.accuweather.com'

  module ResponseHelper
    def parse
      valid_json?(body) ? Oj.load(body) : []
    end

    def valid_json?(data)
      !!Oj.load(data) rescue false
    end
  end

  def current
    read_data(
      endpoint: '/currentconditions/v1/293708',
      params: { apikey: ENV['API_KEY'] }
    )
  end

  def historical
    read_data(
      endpoint: '/currentconditions/v1/293708/historical/24',
      params: { apikey: ENV['API_KEY'] }
    )
  end

  private

  def connection
    @conn ||= Faraday.new(SERVICE_URI) do |builder|
      builder.request :url_encoded
      builder.adapter Faraday.default_adapter
    end
  end

  def read_data(endpoint:, params: {})
    resp = connection.public_send(:get, endpoint, params)
    resp.extend(ResponseHelper)
    resp.parse
  end
end
