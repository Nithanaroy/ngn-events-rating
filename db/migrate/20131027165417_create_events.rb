class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name, :null => false
      t.text :details
      t.string :place
      t.datetime :from
      t.datetime :to

      t.timestamps
    end
  end
end
