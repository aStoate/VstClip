class AddLikeCountToClip < ActiveRecord::Migration
  def change
    add_column :clips, :like_count, :integer, default: 0
  end
end
