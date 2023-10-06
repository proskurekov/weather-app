module Weather
  class Time < Grape::API
    desc 'Returns date by timestamp'

    helpers WeatherService

    params do
      requires :timestamp
    end

    before do
      @json ||= historical_weather
      @api_builder = JsonBuilder.new(@json)
    end

    get :by_time do
      @api_builder.collect_timestamps
      { tt: @api_builder.timestamps }
    end
  end
end
