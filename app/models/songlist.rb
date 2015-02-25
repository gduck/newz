class Songlist < ActiveRecord::Base

  validates :year, uniqueness: true
  validates :songs, presence: true

  serialize :songs, Array
end
