# http://boldr.net/upgrade-plugins-gems-rails-3
class Configuration < ActiveRecord::Base
  
  after_save :reset_cache
  
  def reset_cache
    ActsAsConfigurable.reset(self.short_name)
  end
  
  def short_name
    self.class.short_name
  end
  
  class << self
    def short_name
      self.name.to_s.downcase.split("::").last.gsub(/settings$/, "")
    end
    
    def setup(options = {})
      ActsAsConfigurable.setup(options)
    end
  end
end
