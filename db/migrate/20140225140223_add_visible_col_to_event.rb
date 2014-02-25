class AddVisibleColToEvent < ActiveRecord::Migration
  def change
  	add_column :events, :show, :boolean, :default => true, :null => false
  end
end
