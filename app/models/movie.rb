class Movie < ApplicationRecord
  validates :title, presence: true
  validates :blurb, presence: true
  validates :date_released, presence: true
  validates :country_of_origin, presence: true
  validates :showing_start, presence: true
  validates :showing_end, presence: true

  belongs_to :user
  has_many :movie_genre_ships
  has_many :genres, through: :movie_genre_ships
  has_many :reviews

  def average_rating
    self.reviews.sum(:rating) / self.reviews.count.to_f
  end

  def short_url_generator
    range = [*'0'..'9',*'A'..'Z',*'a'..'z']
    url = Array.new(7){ range.sample }.join
    until Movie.find_by(short_url: url) == nil
      url = Array.new(7){ range.sample }.join
    end
    self.short_url = url
  end
end