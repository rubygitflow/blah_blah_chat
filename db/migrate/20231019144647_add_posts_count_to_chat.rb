class AddPostsCountToChat < ActiveRecord::Migration[7.1]
  def change
    add_column :chats, :posts_count, :integer, default: 0
  end
end
