class AddLikersCountToClip < ActiveRecord::Migration
  def change
    add_column :clips, :likers_count, :integer
  end
end
