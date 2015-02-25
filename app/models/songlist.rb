class Songlist < ActiveRecord::Base

  validates :year, uniqueness: true
  validates :songlist, presence: true

  serialize :songlist, Array
end
