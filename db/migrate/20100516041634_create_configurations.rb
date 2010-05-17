class CreateConfigurations < ActiveRecord::Migration
  def self.up
    create_table :configurations do |t|
      t.string :name, :null => false
      t.string :type
      t.text :description
      t.timestamps
    end
  end
  
  def self.down
    drop_table :configurations
  end
end
