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
        if options.has_key?(:styles)
          options[:styles].each do |k,v|
            name = "#{k.to_s}_image"
            define_method name do
              get_asset(k)
            end
            
            define_method "#{name}_id" do
              result = get_asset(k)
              result ? result.id : nil
            end
            
            define_method "#{name}=" do |asset|
              set_asset(k, asset)
            end
            
            define_method "#{name}_id=" do |id|
              set_asset(k, id)
            end
          end
        end
      end
    end
  end
  
  module InstanceMethods
    
    def get_asset_assignment(style)
      get_asset_assignments(style).first
    end
    
    def get_asset_assignments(style)
      self.asset_assignments.select do |assignment|
        assignment.context == style.to_s
      end
    end
    
    def get_asset(style)
      get_assets(style).first
    end
    
    def get_assets(style)
      return [] unless self.assets and !self.assets.empty?
      
      get_asset_assignments(style).collect do |assignment|
        assignment.asset
      end
    end
    
    def set_asset(style, value)
      assignment = get_asset_assignment(style) || AssetAssignment.new
      assignment.asset = value.is_a?(Asset) ? value : Asset.find(value)
      assignment.assetable = self
      assignment.context = style.to_s
      assignment.save
      self.reload
      self.send("#{style.to_s}_image")
    end
  end
end
