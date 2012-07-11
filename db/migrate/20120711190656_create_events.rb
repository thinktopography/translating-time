class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name, :code
      t.text :description
      t.decimal :scale, :precision => 8, :scale => 6
      t.boolean :in_model
      t.references :location, :pro
      t.timestamps
    end
  end
end
