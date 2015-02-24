class Movie < ActiveRecord::Base

  validates :year, uniqueness: true
  validates :bestMovie, presence: true

  serialize :producers, Array
  serialize :nominees, Array

end
