class Admin::PagesController < Admin::BaseController
  layout "admin"
  
  protected
    def collection
      @pages = Page.roots
    end
end