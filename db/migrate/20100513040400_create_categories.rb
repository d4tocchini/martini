class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.string :name
      t.text   :description
      t.string :categorizable_type
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt

      t.timestamps
    end
    create_table :categorizations do |t|
      t.belongs_to :categorizable, :polymorphic => true
      t.belongs_to :category
      t.timestamps
    end
    add_index :categorizations, [ :categorizable_type, :categorizable_id ]
    add_index :categorizations, :category_id
    add_index :categories, :categorizable_type
  end

  def self.down
    drop_table :categories
    drop_table :categorizations    
  end
end
