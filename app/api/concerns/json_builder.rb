# frozen_string_literal: true

class JsonBuilder
  include WeatherJsonHelper

  attr_reader :values, :timestamps

  def initialize(json)
    @json    = json
    @values  = []
    @history = []
    @timestamps = []
  end

  def autofill
    builder do |builder|
      builder.call(@json, &autofill_proc)
    end
  end

  def autofill_proc
    proc do |field|
      field.extend(WeatherJsonHelper::HashHelper)
      @values  << field.temperature_value
      @history << field.statistics
    end
  end

  def collect_timestamps
    builder do |builder|
      builder.call(@json, &timestamp_proc)
    end
  end

  def timestamp_proc
    proc do |field|
      field.extend(WeatherJsonHelper::HashHelper)
      @timestamps << field.timestamp
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
