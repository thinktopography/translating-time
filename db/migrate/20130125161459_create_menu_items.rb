class CreateMenuItems < ActiveRecord::Migration
  def change
    create_table :menu_items do |t|
      t.string :title, :url, :target
      t.integer :delta
      t.timestamps
    end
  end
end
