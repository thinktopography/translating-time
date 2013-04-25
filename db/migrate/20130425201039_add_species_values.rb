class AddSpeciesValues < ActiveRecord::Migration
  def up
    add_column :species, :scientific_name, :string
    add_column :species, :precocial_score, :string
    add_column :species, :brain, :string
    add_column :species, :weight, :string
    add_column :species, :gestation, :string
  end

  def down
    remove_column :species, :scientific_name
    remove_column :species, :precocial_score
    remove_column :species, :brain
    remove_column :species, :weight
    remove_column :species, :gestation
  end
end