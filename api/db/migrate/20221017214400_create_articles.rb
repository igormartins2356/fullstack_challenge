class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :imageUrl
      t.string :newsSite
      t.string :publishedAt
      t.string :summary
      t.string :updatedAt
      t.string :url
      t.timestamps
    end
  end
end
