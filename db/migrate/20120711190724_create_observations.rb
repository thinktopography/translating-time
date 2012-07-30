class CreateObservations < ActiveRecord::Migration
  def change
    create_table :observations do |t|
      t.references :citation, :event, :species, :method
      t.decimal :value, :precision => 4, :scale => 1
      t.timestamps
    end
  end
end
