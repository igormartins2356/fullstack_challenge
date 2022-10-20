namespace :articles do
  desc "TODO"
  task update_articles: :environment do
    require 'json'
  
    last_article = Article.last
    request = RestClient.get "https://api.spaceflightnewsapi.net/v3/articles?_limit=25", {content_type: :json, accept: :json}
    articles = JSON.parse(request)
    art = []
    articles.map do |article|
      if article["publishedAt"] > last_article.publishedAt
        a = {
          id: nil,
          imageUrl: article["imageUrl"], 
          newsSite: article["newsSite"], 
          publishedAt: article["publishedAt"], 
          summary: article["summary"], 
          title: article["title"], 
          updatedAt: article["updatedAt"],
        }
        art.push(a)
      end
    end

    Article.create!(art)
  end

end