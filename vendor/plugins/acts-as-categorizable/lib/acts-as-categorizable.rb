require 'awesome_nested_set'
module ActsAsCategorizable
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods

    def acts_as_categorizable
      has_many :categorizations, :as => :categorizable
      has_many :categories, :through => :categorizations
      Category.send(:has_many, self.class_name.downcase.pluralize.to_sym, :through => :categorizations, :source => :categorizable, :source_type => self.class_name)
      extend SingletonMethods
    end
  end
  
  module SingletonMethods
    def categories
      Category.find_all_by_categorizable_type(name)
    end
  end
end
