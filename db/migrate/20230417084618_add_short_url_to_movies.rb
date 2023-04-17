class AddShortUrlToMovies < ActiveRecord::Migration[7.0]
  def change
    add_column :movies, :short_url, :string, unique: true
  end
end
