module Weather
  class Current < Grape::API
    desc 'Returns current weather'

    helpers WeatherService, WeatherJsonHelper

    get :current do
      data = current_weather.first
      return {} unless data

      temp = ->(builder) { builder.temperature data.dig('Temperature', 'Metric') }
      jbuilder(&temp)
    end
  end
end
