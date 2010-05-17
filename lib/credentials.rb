module Credentials
  
  class << self
    attr_accessor :config

    def config=(value)
      value.recursively_symbolize_keys!
      @config = value
    end
    
    def set(path)
      
    end
    
    def get(path)
      result = self.config
      path.to_s.split(".").each { |node| result = result[node.to_sym] if result }
      result
    end
    
    alias_method :[], :get
    
  end
  
end