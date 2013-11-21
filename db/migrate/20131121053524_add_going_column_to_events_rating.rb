class AddGoingColumnToEventsRating < ActiveRecord::Migration
  def change
    add_column :events_ratings, :going, :boolean
  end
end
