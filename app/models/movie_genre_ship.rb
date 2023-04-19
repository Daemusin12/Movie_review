class MovieGenreShip < ApplicationRecord
  belongs_to :movie
  belongs_to :genre

  scope :filter_by_genre, ->(selected_genres) { select(:movie_id).where({genre_id: [selected_genres]}).distinct }
end
