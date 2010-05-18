class Page < ActiveRecord::Base
  acts_as_taggable
  acts_as_categorizable
  acts_as_nested_set
  has_friendly_id :title, :use_slug => true, :cache_column => :permalink#, :scope => :parent_id
  
  acts_as_assetable :styles => {
    :featured => "925x295",
    :preview => "660x295",
    :thumb => "50x50"
  }
  
  validates_length_of :title, :maximum => 255
  validates_length_of :permalink, :maximum => 100
  
  def to_param
    result = ""
    if parent
      result << parent.to_param
      result << "/"
    end
    result << friendly_id
  end
  
  def template
    if !self.layout.empty? and File.exists?("app/views/layouts/#{self.layout}.html.haml")
      self.layout
    else
      "right"
    end
  end
  
  class << self
    def template(page)
      page ? page.template : "news"
    end
  end
end
