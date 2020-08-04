module AdsService
  module Api
    def update_coordinates(id, coordinates)
      connection.put("/ads/#{id}", lat: coordinates[0], lon: coordinates[1])
    end
  end
end
