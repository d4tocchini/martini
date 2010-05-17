class AssetSettings < Configuration
  
  preference :thumb_width, :integer
  preference :thumb_height, :integer
  preference :medium_width, :integer, :default => 600
  preference :medium_height, :integer, :default => 250
  preference :large_width, :integer, :default => 660 # or 925
  preference :large_height, :integer, :default => 295
  
end