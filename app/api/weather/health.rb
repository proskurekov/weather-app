module Weather
  class Health < Grape::API
    desc 'Returns service health'

    get :health do
      { status: 'OK' }
    end
  end
end
