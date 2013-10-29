class CreateEventsRatings < ActiveRecord::Migration
  def change
    create_table :events_ratings, :id => false do |t|
      t.column :event_id, :int, :null => false
      t.column :rating, :int, :null => false

      t.timestamps
    end
  end
end
