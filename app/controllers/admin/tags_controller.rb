class Admin::TagsController < Admin::BaseController
  defaults :resource_class => ActsAsTaggableOn::Tag
  
  def extract
    yahoo = TermExtraction::Yahoo.new(
      :api_key => YAML.load_file("config/keys.yml")["yahoo_api"],
      :context => params[:content]
    )
    render :text => yahoo.terms
  end
end
