class AddFollowCountToUser < ActiveRecord::Migration
  def change
    add_column :users, :follow_count, :integer, default: 0
  end
end
