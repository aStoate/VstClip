class AddClipIdToComment < ActiveRecord::Migration
  def change
    add_column :comments, :clip_id, :Integer
  end
end
