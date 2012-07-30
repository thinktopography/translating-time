class CreateCitations < ActiveRecord::Migration
  def change
    create_table :citations do |t|
      t.text :body
      t.integer :pubmed_id
      t.string :authors, :title, :journal, :pagination, :volume, :authors
      t.date :date
      t.timestamps
    end
  end
end
