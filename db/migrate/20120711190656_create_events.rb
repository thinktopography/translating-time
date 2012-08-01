class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :location, :process
      t.string :name, :code
      t.text :description
      t.decimal :scale, :precision => 8, :scale => 6
      t.boolean :in_model
      t.timestamps
    end
  end
end
