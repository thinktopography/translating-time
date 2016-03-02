class AddInputData < ActiveRecord::Migration
  def change
    add_column :estimates, :input, :decimal, :precision => 4, :scale => 1
  end
end
