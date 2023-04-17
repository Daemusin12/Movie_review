class Review < ApplicationRecord
  belongs_to :movie
  belongs_to :user

  validates :content, presence: true
  validates :rating, presence: true, numericality: { in: 1..5 }

  scope :top_ratings, -> { order(rating: :desc) }

end
