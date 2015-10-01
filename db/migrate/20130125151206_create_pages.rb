class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title
      t.string :permalink
      t.boolean :is_published
      t.text :body
      t.string :meta_keywords
      t.string :meta_description
      t.timestamps
    end
    add_index :pages, :permalink, :unique => true
  end
end
