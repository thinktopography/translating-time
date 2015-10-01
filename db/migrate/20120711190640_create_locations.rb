class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name, :code
      t.decimal :value, :precision => 8, :scale => 6
      t.text :description
      t.timestamps
    end
  end
end
