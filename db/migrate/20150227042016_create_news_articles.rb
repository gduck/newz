class CreateNewsArticles < ActiveRecord::Migration
  def change
    create_table :news_articles do |t|

      t.string :year
      t.text :news
      t.text :sports

      t.timestamps
    end
    add_index :news_articles, :year
  end
end
