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
    :s3_credentials => {
      :access_key_id => Credentials.get("s3.key"),
      :secret_access_key => Credentials.get("s3.secret")
    },
    :path => ":attachment/:id/:style.:extension",
    :bucket => 'ilove4d-test'
    
  def url(style = nil)
    data.url(style || data.default_style)
  end
  
end
