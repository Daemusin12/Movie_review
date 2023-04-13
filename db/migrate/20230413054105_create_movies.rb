class CreateMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :movies do |t|
      t.string :title
      t.text :blurb
      t.date :date_released
      t.string :country_of_origin
      t.date :showing_start
      t.date :showing_end
      t.timestamps
    end
  end
end
