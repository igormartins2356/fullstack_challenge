# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'json'

request = RestClient.get "https://api.spaceflightnewsapi.net/v3/articles?_limit=25", {content_type: :json, accept: :json}
articles = JSON.parse(request)
art = []
articles.map do |article|
  a = {
    id: nil,
    imageUrl: article["imageUrl"], 
    newsSite: article["newsSite"], 
    publishedAt: article["publishedAt"], 
    summary: article["summary"], 
    title: article["title"], 
    updatedAt: article["updatedAt"],
    url: article["url"],
  }
  art.push(a)
end

aux = art.sort_by{ |a| -a[:publishedAt]}
Article.create!(aux)