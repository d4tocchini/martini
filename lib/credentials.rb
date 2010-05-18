module Credentials
  
  class << self
    attr_accessor :config
    
    # for some reason it's being erased after the first request
    def config
      @config ||= YAML.load_file("config/config.yml")
    end
    
    def get(path)
      path  = "#{Rails.env}.#{path}"
      result = self.config.dup
      path.to_s.split(".").each { |node| result = result[node.to_s] if result }
      result
    end
    alias_method :[], :get
    
  end
  
end