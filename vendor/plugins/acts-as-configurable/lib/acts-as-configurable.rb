require 'preferences'
module ActsAsConfigurable
  class << self
    attr_accessor :configurations
    
    def all
      configurations
    end
    
    def configurations
      unless @configurations
        setup
        @configurations = Configuration.all # do some sort of caching here!
      end
      
      @configurations
    end
    
    def names
      all.collect {|i| i.short_name }
    end
    
    def config(name)
      all.detect {|i| i.short_name == name.to_s}
    end
    
    def get(configuration, setting = nil, group = nil)
      if setting
        config(configuration).preferred(setting, group)
      else
        config(configuration)
      end
    end
    
    def set(configuration, settings = {})
      instance = config(configuration)
      settings.each do |key, value|
        instance.write_preference(key, value)
      end
      instance.save
      instance
    end
    
    def reset(configuration)
      @configurations = configurations.collect do |config|
        if config.short_name == configuration
          Configuration.find_by_name(config.name)
        else
          config
        end
      end
    end
    
    # this should be a railtie when I get the time to figure it out
    def setup(options = {})
      settings_path = options[:settings_path] || "#{Rails.root}/app/settings"
      files = Dir.entries(settings_path)[2..-1].collect {|i| File.basename(i).gsub("_settings.rb", "")}
      configurations = files.collect do |i|
        "#{i.to_s.camelize}Settings".constantize.find_or_create_by_name("#{i.to_s.camelize} Settings")
      end
    end
  end
  
  # want to change the methods so they are easier to understand from the Configuration context
  module Aliases
    
    def self.included(base)
      #class << base
      #  alias_method :setting, :preference
      #end
      base.class_eval do
        if self.respond_to?(:preferences)
          alias_method :settings, :preferences
          alias_method :setting?, :preferred?        
          alias_method :set, :write_preference
          alias_method :get, :preferred
        end
      end
    end
    
  end
end

ActiveRecord::Base.send(:include, ActsAsConfigurable::Aliases)