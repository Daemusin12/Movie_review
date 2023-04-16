class AddUserIdToReviews < ActiveRecord::Migration[7.0]
  def change
    add_reference :reviews, :user
  end
end
