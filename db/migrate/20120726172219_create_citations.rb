class CreateCitations < ActiveRecord::Migration
  def change
    create_table :citations do |t|

      t.timestamps
    end
  end
end
