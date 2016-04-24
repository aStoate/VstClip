class RemoveLikersCountFromClip < ActiveRecord::Migration
  def change
    remove_column :clips, :likers_count, :integer
  end
end
