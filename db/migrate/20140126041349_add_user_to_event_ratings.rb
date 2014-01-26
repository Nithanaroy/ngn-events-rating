class AddUserToEventRatings < ActiveRecord::Migration
  def change
    add_column :events_ratings, :user_id, :integer, :null => false
  end
end
