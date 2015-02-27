class NewsArticle < ActiveRecord::Base

  validates :year, uniqueness: true
  # validates :news, presence: true

  serialize :news, Array
  serialize :sports, Array

end
