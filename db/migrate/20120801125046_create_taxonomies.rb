class CreateTaxonomies < ActiveRecord::Migration
  def change
    create_table :taxonomies do |t|
      t.integer :parent_id
      t.string :name
      t.timestamps
    end
    create_table :classifications, :id => false do |t|
      t.references :taxonomy, :species
    end
  end
end
