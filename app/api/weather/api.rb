module Weather
  class API < Grape::API
    prefix 'api'
    format :json

    namespace 'weather' do
      mount Weather::Current
      mount Weather::Historical
      mount Weather::Time
      mount Weather::Health
    end

    add_swagger_documentation hide_documentation_path: true,
                              api_version: 'v1',
                              info: {
                                title: 'Weather API',
                                description: 'Rails weather app project'
                              }
  end
end
