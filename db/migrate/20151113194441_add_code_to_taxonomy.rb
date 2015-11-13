class AddCodeToTaxonomy < ActiveRecord::Migration
  def change
    add_column :taxonomies, :code, :string
  end
end
