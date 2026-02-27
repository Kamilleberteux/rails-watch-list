# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
#
require "open-uri"
require "json"

Movie.destroy_all

url = "https://tmdb.lewagon.com/movie/top_rated"
movie_serialized = URI.parse(url).read
api_r = JSON.parse(movie_serialized)

api_results = api_r["results"]

api_results.each do |m|
  Movie.create!(title: m["original_title"], overview: m["overview"], poster_url: "https://image.tmdb.org/t/p/w500#{m["poster_path"]}", rating: m["vote_average"])
end
