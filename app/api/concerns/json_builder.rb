# frozen_string_literal: true

class JsonBuilder
  include WeatherJsonHelper

  attr_reader :values

  def initialize(json)
    @json    = json
    @values  = []
    @history = []
  end

  def autofill
    builder do |builder|
      builder.call(@json) do |field|
        field.extend(WeatherJsonHelper::HashHelper)
        @values  << field.temperature_value
        @history << field.statistics
      end
    end
  end

  def min_max(method:)
    builder do |builder|
      value  = @values.send(method)
      result = @history.select { |item| item[value] }

      result.each do |res|
        res.each do |k, v|
          builder.data  v
          builder.value k
        end
      end
    end
  end

  def builder(&block)
    jbuilder(&block)
  end
end
