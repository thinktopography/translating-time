class CreateInquiries < ActiveRecord::Migration
  def change
    create_table :inquiries do |t|
      t.string :name, :affiliation, :email
      t.text :comments
      t.timestamps
    end
  end
end
