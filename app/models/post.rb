class Post < ActiveRecord::Base
  has_friendly_id :title, :use_slug => true, :cache_column => :permalink
  acts_as_taggable
  acts_as_categorizable
  acts_as_assetable
  validates_presence_of :title, :body, :permalink
  validates_uniqueness_of :title
end