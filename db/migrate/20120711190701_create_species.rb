class CreateSpecies < ActiveRecord::Migration
  def change
    create_table :species do |t|
      t.string :name, :code
      t.decimal :constant, :slope, :precision => 8, :scale => 6
      t.boolean :in_model
      t.timestamps
    end
  end
end
