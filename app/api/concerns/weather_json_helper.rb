require 'time'

module WeatherJsonHelper
  module HashHelper
    def statistics
      Hash[temperature_value, date]
    end

    def temperature
      dig('Temperature', 'Metric')
    end

    def temperature_value
      temperature['Value']
    end

    def date
      convert_date(dig('EpochTime'))
    end

    def convert_date(date)
      Time.at(date).strftime('%d-%m-%Y %H:%M') if date
    end
  end

  def jbuilder(&block)
    Jbuilder.new(&block).attributes!
  end
end
