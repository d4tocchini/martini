class AssetAssignment < ActiveRecord::Base
  belongs_to :assetable, :polymorphic => :true
  belongs_to :asset
  validates_presence_of :assetable_id, :asset_id
end
