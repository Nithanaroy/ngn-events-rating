class MakeRatingOptionalToEventsRating < ActiveRecord::Migration
  def change
    change_column :events_ratings, :rating, :string, :null => true
  end
end
