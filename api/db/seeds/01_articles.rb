require 'json'

request = RestClient.get "https://api.spaceflightnewsapi.net/v3/articles?_limit=100", {content_type: :json, accept: :json}
articles = JSON.parse(request)

articles.map do |article|
  article.id = nil
end