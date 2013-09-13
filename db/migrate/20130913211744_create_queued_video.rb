class CreateQueuedVideo < ActiveRecord::Migration
  def change
    create_table :queued_videos do |t|
      t.integer :user_id
      t.integer :video_id
    end
  end
end
