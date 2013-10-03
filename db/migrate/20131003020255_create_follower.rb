class CreateFollower < ActiveRecord::Migration
  def change
    create_table :followers do |t|
      t.string :user_id
    end
  end
end
