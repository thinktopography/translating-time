class CreateMethods < ActiveRecord::Migration
  def change
    create_table :methods do |t|
      t.string :name
      t.timestamps
    end
  end
end
