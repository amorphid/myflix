class CreateUserFollower < ActiveRecord::Migration
  def change
    create_table :user_followers do |t|
      t.string :follower_id
      t.string :user_id
    end
  end
end
