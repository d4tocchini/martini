class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.string :title
      t.text :body
      t.text :description
      t.string :format
      t.boolean :published
      t.string :permalink
      t.boolean :allow_comments
      t.boolean :allow_pings
      t.boolean :show_children
      # awesome_nested_set
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      t.string :layout # how you want it rendered
      
      t.timestamps
    end
  end

  def self.down
    drop_table :pages
  end
end
