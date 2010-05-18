class PagesController < InheritedResources::Base
  layout :determine_layout
  
  def determine_layout
    Page.template(@page)
  end
  
  protected
    def resource
      @page ||= Page.find(basename)
    end
    
    def basename
      params[:request_path].split("/").last.to_s
    end
end
