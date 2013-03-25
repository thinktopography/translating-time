class CreateAbbreviations < ActiveRecord::Migration
  def change
    create_table :abbreviations do |t|
      t.string :text, :description
    end
  end
end
