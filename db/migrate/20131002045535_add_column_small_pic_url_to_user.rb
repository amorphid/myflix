class AddColumnSmallPicUrlToUser < ActiveRecord::Migration
  def change
    add_column :users, :small_pic_url, :string
  end
end
