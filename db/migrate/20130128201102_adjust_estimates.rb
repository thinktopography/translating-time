class AdjustEstimates < ActiveRecord::Migration
  def up
    Estimate.delete_all
    remove_column :estimates, :value
    add_column :estimates, :low, :decimal, :precision => 6, :scale => 1
    add_column :estimates, :value, :decimal, :precision => 6, :scale => 1
    add_column :estimates, :high, :decimal, :precision => 6, :scale => 1
    add_column :estimates, :warning, :integer, :default => 0
  end

  def down
  end
end
