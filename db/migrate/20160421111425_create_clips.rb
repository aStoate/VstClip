class CreateClips < ActiveRecord::Migration
  def change
    create_table :clips do |t|
      t.string :title
      t.string :url
      t.string :type
      t.text :description

      t.timestamps null: false
    end
  end
end
