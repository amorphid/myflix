class CreateUsersTable < ActiveRecord::Migration
  def change
    create_table :users_tables do |t|
      t.string :email_address
      t.string :password_digest
      t.string :full_name
    end
  end
end