class CreateModels < ActiveRecord::Migration
  def change
    create_table :models do |t|
      t.text :source
      t.timestamps null: false
    end
  end
end