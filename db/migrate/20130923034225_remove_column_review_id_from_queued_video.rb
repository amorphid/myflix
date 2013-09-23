class RemoveColumnReviewIdFromQueuedVideo < ActiveRecord::Migration
  def change
    remove_column :queued_videos, :review_id, :integer
  end
end
