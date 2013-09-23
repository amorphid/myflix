class AddColumnPriorityToQueuedVideo < ActiveRecord::Migration
  def change
    add_column :queued_videos, :priority, :integer
  end
end
