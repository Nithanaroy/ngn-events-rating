class UpdateConstaintsToEvents < ActiveRecord::Migration
  def change
    change_column :events, :place, :string, :null => false
    change_column :events, :from, :datetime, :null => false
    change_column :events, :to, :datetime, :null => false
  end
end
