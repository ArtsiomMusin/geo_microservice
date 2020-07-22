class Application < Roda
  plugin :json

  route do |r|
    # GET / request
    r.root do
      coordinates = Geocoder.geocode(request.params['city'])
      if coordinates.nil?
        response.status = 422
        { error: 'City geo not found' }
      else 
        response.status = 200
        coordinates
      end
    end
  end
end
