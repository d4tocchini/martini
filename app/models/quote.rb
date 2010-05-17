class Quote < ActiveRecord::Base
  acts_as_taggable
  acts_as_categorizable
end
