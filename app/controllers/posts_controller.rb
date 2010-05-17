class PostsController < InheritedResources::Base
  layout :determine_layout
  
  def determine_layout
    if params[:action] == "index"
      "blog"
    else
      "right"
    end
  end
end
