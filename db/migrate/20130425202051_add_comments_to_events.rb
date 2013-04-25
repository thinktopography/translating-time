class AddCommentsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :comment, :text
  end
end
