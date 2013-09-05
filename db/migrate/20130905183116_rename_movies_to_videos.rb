class RenameMoviesToVideos < ActiveRecord::Migration
  def change
    rename_table :movies, :videos
  end
end
