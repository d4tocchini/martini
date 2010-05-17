class Category < ActiveRecord::Base
  acts_as_nested_set
  has_many :categorizations
  has_many :categorizables, :through => :categorizations
end
