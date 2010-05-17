class PagesController < InheritedResources::Base
  layout :determine_layout
  
  def determine_layout
    if params[:action] == "index"
      "news"
    else
      "right"
    end
  end
  
  protected
    def resource
      @page ||= Page.find(params[:path].split("/").last)
    end
end
