class CreateDatasets < ActiveRecord::Migration
  def change
    create_table :datasets do |t|
      t.timestamps null: false
    end
    add_column :estimates, :dataset_id, :integer
    add_column :datasets, :model_id, :integer
  end
end