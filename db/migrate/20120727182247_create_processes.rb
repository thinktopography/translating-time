class CreateProcesses < ActiveRecord::Migration
  def change
    create_table :processes do |t|
      t.string :name
      t.string :code
      t.string :value
      t.text :description
      t.timestamps
    end
  end
end
