class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      t.string :first_name, :last_name
      t.string :email,              :null => false, :default => ""
      t.references :role
      t.boolean :change_password, :null => false, :default => 0
      t.string :encrypted_password, :null => false, :default => ""
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at
      t.integer  :sign_in_count, :default => 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip
      t.timestamps
    end
    add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true
  end
end
