module Weather
  class Time < Grape::API
    desc 'Returns date by timestamp'

    helpers WeatherService

    helpers do
      def check_params!
        error!(:not_found, 404) unless timestamp.positive? && timestamp.digits.size == 10
      end

      def timestamp
        params['timestamp'].to_i
      end
    end

    before do
      @json ||= historical_weather
      @api_builder = JsonBuilder.new(@json)
      check_params!
    end

    get :by_time do
      @api_builder.collect_timestamps.sort
      value = @api_builder.timestamps.min_by { |t| (t.keys.first - timestamp).abs }
      @api_builder.builder { |builder| builder.timestamp value }
    end
  end
end
