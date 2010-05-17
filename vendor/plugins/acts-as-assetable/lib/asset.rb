class Asset < ActiveRecord::Base
  has_friendly_id :title, :use_slug => true, :cache_column => :permalink
  acts_as_taggable

  has_attached_file :data,
    :styles => {
      :medium => "300x300>",
      :thumb => "120x120#",
      :tiny => "50x50#",
      :micro => "20x20#"
    },
    :storage => :s3,
    :s3_credentials => "config/s3.yml",
    :path => ":attachment/:id/:style.:extension",
    :bucket => 'ilove4d-test'
end