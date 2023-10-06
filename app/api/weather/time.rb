module Weather
  class Time < Grape::API
    desc 'Returns current weather'
    get :by_time do
      { time: 'time' }
    end
  end
end
