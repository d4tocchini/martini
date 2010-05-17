module ActsAsAssetable
  def self.included(base)
    base.extend ClassMethods
  end
  
  module ClassMethods

    def acts_as_assetable(options = {})
      has_many :asset_assignments, :as => :assetable, :dependent => :destroy
      has_many :assets, :through => :asset_assignments
      Asset.send(:has_many, self.class_name.downcase.pluralize.to_sym, :through => :asset_assignments, :source => :assetable, :source_type => self.class_name)
      self.class_eval do
        include InstanceMethods
      end
    end
  end
  
  module InstanceMethods
    def assets_for(style)
      return [] unless self.assets and !self.assets.empty?
      
      self.asset_assignments.select do |assignment|
        assignment.context == style
      end
    end
    
    def asset_for(style)
      assets_for(style).first
    end
  end
end
