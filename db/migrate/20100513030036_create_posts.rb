class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.text :description
      t.string :format
      t.boolean :published
      t.string :permalink
      t.boolean :allow_comments
      t.boolean :allow_pings

      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
