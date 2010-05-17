class Page < ActiveRecord::Base
  acts_as_taggable
  acts_as_categorizable
  acts_as_assetable
  acts_as_nested_set
  has_friendly_id :title, :use_slug => true, :cache_column => :permalink
end
