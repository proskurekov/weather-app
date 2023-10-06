module Weather
  class Current < Grape::API
    helpers WeatherService, WeatherJsonHelper

    desc 'Returns current weather'
    get :current do
      fields = current

      jbuilder do |json|
        json.call(fields) do |field|
          json.temperature field.dig('Temperature', 'Metric')
        end
      end
    end
  end
end
