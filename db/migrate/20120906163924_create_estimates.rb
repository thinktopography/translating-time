class CreateEstimates < ActiveRecord::Migration
  def change
    create_table :estimates do |t|
      t.integer :event_id, :species_id
      t.decimal :value, :precision => 4, :scale => 3
      t.timestamps
    end
  end
end
