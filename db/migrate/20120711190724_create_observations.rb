class CreateObservations < ActiveRecord::Migration
  def change
    create_table :observations do |t|
      t.references :citation, :event, :species, :method, :user
      t.decimal :value, :precision => 4, :scale => 1
      t.boolean :is_active, :null => false, :default => 0
      t.timestamps
    end
  end
end
