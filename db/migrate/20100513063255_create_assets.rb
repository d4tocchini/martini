class CreateAssets < ActiveRecord::Migration
  def self.up
    create_table :assets do |t|
      t.string :title
      t.text :metadata
      t.string :data_file_name
      t.string :data_content_type
      t.string :data_file_size
      t.string :data_updated_at
      t.string :type # sti
      t.string :permalink

      t.timestamps
    end
    
    create_table :asset_assignments, :force => true do |t|
      t.integer  :asset_id
      t.integer  :position
      t.string   :label
      t.datetime :created_at
      t.boolean  :active
      t.string   :context # as_thumbnail, etc.
      # polymorphism
      t.string :assetable_type
      t.integer :assetable_id
    end
  end

  def self.down
    drop_table :asset_assignments
    drop_table :assets
  end
end
