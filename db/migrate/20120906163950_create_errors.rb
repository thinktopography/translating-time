class CreateErrors < ActiveRecord::Migration
  def change
    create_table :errors do |t|
      t.integer :event_id, :species_id
      t.decimal :value, :precision => 7, :scale => 5
      t.timestamps
    end
  end
end
