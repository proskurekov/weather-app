module Weather
  class Historical < Grape::API
    desc 'Returns current weather'

    helpers WeatherService, WeatherJsonHelper

    namespace :historical do
      before do
        @json ||= historical_weather
        @api_builder = JsonBuilder.new(@json)
        @api_builder.autofill
      end

      get do
        @api_builder.builder do |builder|
          builder.call(@json) do |field|
            field.extend(WeatherJsonHelper::HashHelper)
            builder.date field.date
            builder.temperature field.temperature
          end
        end
      end

      get :min do
        @api_builder.min_max(method: :min)
      end

      get :max do
        @api_builder.min_max(method: :max)
      end

      get :avg do
        @api_builder.builder do |builder|
          values = @api_builder.values
          next unless values.present?

          avg_value = values.reduce(:+) / values.size
          builder.value avg_value.round(1)
        end
      end
    end
  end
end
