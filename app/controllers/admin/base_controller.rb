class Admin::BaseController < InheritedResources::Base
  layout "admin"
  
  def update
    update!{ self.send("admin_#{resource_collection_name}_url") }
  end
  
end