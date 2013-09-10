class RenameEmailAddressToEmailInUsers < ActiveRecord::Migration
  def change
    rename_table :users_tables, :users
    rename_column :users, :email_address, :email
  end
end
