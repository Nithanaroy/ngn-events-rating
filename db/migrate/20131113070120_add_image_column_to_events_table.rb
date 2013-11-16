class AddImageColumnToEventsTable < ActiveRecord::Migration
  def change
    add_column :events, :image_url, :string, :after => :to
  end
end
