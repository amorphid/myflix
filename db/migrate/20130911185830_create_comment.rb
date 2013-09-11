class CreateComment < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :video_id
      t.string :description
      t.integer :rating
      t.timestamps
    end
  end
end
