class AddColumnReviewIdToQueuedVideo < ActiveRecord::Migration
  def change
    add_column :queued_videos, :review_id, :integer
  end
end
